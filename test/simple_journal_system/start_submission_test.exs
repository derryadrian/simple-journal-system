defmodule SimpleJournalSystem.StartSubmissionTest do
  use SimpleJournalSystem.DataCase, async: true

  import SimpleJournalSystem.AccountsFixtures

  alias SimpleJournalSystem.Accounts
  alias SimpleJournalSystem.Accounts.Roles
  alias SimpleJournalSystem.Accounts.UserUserGroup
  alias SimpleJournalSystem.Journals
  alias SimpleJournalSystem.Repo
  alias SimpleJournalSystem.Submissions
  alias SimpleJournalSystem.Submissions.Author
  alias SimpleJournalSystem.Submissions.Publication
  alias SimpleJournalSystem.Submissions.StageAssignment

  setup do
    {:ok, journal} =
      Journals.create_journal(%{
        path: "j#{System.unique_integer([:positive])}",
        primary_locale: "en"
      })

    %{journal: journal}
  end

  defp insert_section(journal, attrs \\ %{}) do
    row = Map.merge(%{journal_id: journal.journal_id}, attrs)

    {1, [%{section_id: section_id}]} =
      Repo.insert_all("sections", [row], returning: [:section_id])

    section_id
  end

  describe "start_submission/3 oleh author" do
    test "membuat naskah, publikasi, stage assignment, dan author", %{journal: journal} do
      user = author_fixture(journal.journal_id)

      assert {:ok, result} = Submissions.start_submission(user, journal.journal_id)
      %{submission: submission, publication: publication, author: author} = result

      assert submission.context_id == journal.journal_id
      assert submission.stage_id == 1
      assert submission.status == 1
      assert submission.submission_progress == "start"
      assert submission.locale == "en"
      assert submission.date_submitted == nil

      reloaded = Submissions.get_submission!(submission.submission_id)
      assert reloaded.current_publication_id == publication.publication_id

      assert publication.submission_id == submission.submission_id
      assert publication.version == 1
      assert publication.status == 1

      assignment = Repo.get_by!(StageAssignment, submission_id: submission.submission_id)
      assert assignment.user_id == user.user_id
      assert assignment.user_group_id == result.user_group.user_group_id
      assert assignment.can_change_metadata == 1

      assert author.email == user.email
      assert author.publication_id == publication.publication_id
      assert author.include_in_browse == 1

      saved_publication = Repo.get!(Publication, publication.publication_id)
      assert saved_publication.primary_contact_id == author.author_id
    end

    test "menyalin nama dari pengaturan akun ke author_settings", %{journal: journal} do
      user = author_fixture(journal.journal_id)

      Repo.insert_all("user_settings", [
        %{user_id: user.user_id, locale: "en", setting_name: "givenName", setting_value: "Ana"},
        %{user_id: user.user_id, locale: "en", setting_name: "familyName", setting_value: "Putri"}
      ])

      assert {:ok, %{author: author}} = Submissions.start_submission(user, journal.journal_id)

      settings =
        Repo.all(
          from s in "author_settings",
            where: s.author_id == ^author.author_id,
            select: {s.setting_name, s.locale, s.setting_value}
        )

      assert {"givenName", "en", "Ana"} in settings
      assert {"familyName", "en", "Putri"} in settings
    end

    test "section yang dipilih tersimpan di publikasi", %{journal: journal} do
      user = author_fixture(journal.journal_id)
      section_id = insert_section(journal)

      assert {:ok, %{publication: publication}} =
               Submissions.start_submission(user, journal.journal_id, %{section_id: section_id})

      assert publication.section_id == section_id
    end
  end

  describe "start_submission/3 aturan penolakan" do
    test "jurnal tidak ada" do
      user = user_fixture()
      assert {:error, :journal_not_found} = Submissions.start_submission(user, 999_999_999)
    end

    test "jurnal menonaktifkan pengiriman naskah", %{journal: journal} do
      user = author_fixture(journal.journal_id)

      Repo.insert_all("journal_settings", [
        %{
          journal_id: journal.journal_id,
          locale: "",
          setting_name: "disableSubmissions",
          setting_value: "1"
        }
      ])

      assert {:error, :submissions_disabled} =
               Submissions.start_submission(user, journal.journal_id)
    end

    test "section milik jurnal lain ditolak", %{journal: journal} do
      user = author_fixture(journal.journal_id)

      {:ok, other_journal} =
        Journals.create_journal(%{
          path: "other#{System.unique_integer([:positive])}",
          primary_locale: "en"
        })

      section_id = insert_section(other_journal)

      assert {:error, :section_not_found} =
               Submissions.start_submission(user, journal.journal_id, %{section_id: section_id})
    end

    test "section nonaktif ditolak", %{journal: journal} do
      user = author_fixture(journal.journal_id)
      section_id = insert_section(journal, %{is_inactive: 1})

      assert {:error, :section_inactive} =
               Submissions.start_submission(user, journal.journal_id, %{section_id: section_id})
    end

    test "section khusus editor ditolak untuk author", %{journal: journal} do
      user = author_fixture(journal.journal_id)
      section_id = insert_section(journal, %{editor_restricted: 1})

      assert {:error, :section_editor_restricted} =
               Submissions.start_submission(user, journal.journal_id, %{section_id: section_id})
    end

    test "tidak ada naskah yang tertinggal saat ditolak", %{journal: journal} do
      user = author_fixture(journal.journal_id)
      section_id = insert_section(journal, %{is_inactive: 1})

      {:error, :section_inactive} =
        Submissions.start_submission(user, journal.journal_id, %{section_id: section_id})

      assert Submissions.list_submissions_for_context(journal.journal_id) == []
    end
  end

  describe "start_submission/3 oleh manager" do
    test "manager boleh memakai section khusus editor dan tidak dibuatkan author", %{
      journal: journal
    } do
      user = journal_manager_fixture(journal.journal_id)
      section_id = insert_section(journal, %{editor_restricted: 1})

      assert {:ok, %{author: nil, publication: publication, user_group: group}} =
               Submissions.start_submission(user, journal.journal_id, %{section_id: section_id})

      assert publication.section_id == section_id
      assert group.role_id == Roles.manager()
    end
  end

  describe "start_submission/3 user tanpa role di jurnal" do
    test "otomatis didaftarkan ke grup Author jurnal", %{journal: journal} do
      {:ok, group} =
        Accounts.create_user_group(%{
          context_id: journal.journal_id,
          role_id: Roles.author(),
          is_default: 1
        })

      user = user_fixture()

      assert {:ok, %{author: %Author{}}} = Submissions.start_submission(user, journal.journal_id)

      assert Repo.exists?(
               from uug in UserUserGroup,
                 where: uug.user_id == ^user.user_id and uug.user_group_id == ^group.user_group_id
             )
    end

    test "ditolak kalau jurnal tidak punya grup Author", %{journal: journal} do
      user = user_fixture()
      assert {:error, :not_allowed} = Submissions.start_submission(user, journal.journal_id)
    end
  end
end
