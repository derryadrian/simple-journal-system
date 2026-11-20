defmodule SimpleJournalSystem.SubmissionsTest do
  use SimpleJournalSystem.DataCase, async: true

  import SimpleJournalSystem.SubmissionsFixtures
  import Ecto.Query
  import SimpleJournalSystem.AccountsFixtures, only: [author_fixture: 1, user_fixture: 0]

  alias SimpleJournalSystem.Ojs.SubmissionStatus
  alias SimpleJournalSystem.Repo
  alias SimpleJournalSystem.Submissions
  alias SimpleJournalSystem.Submissions.File
  alias SimpleJournalSystem.Submissions.Submission
  alias SimpleJournalSystem.Accounts.Roles
  alias SimpleJournalSystem.Accounts.UserGroup
  alias SimpleJournalSystem.Accounts.UserUserGroup
  alias SimpleJournalSystem.Submissions.StageAssignment

  describe "create_submission/1" do
    test "naskah baru mulai di stage 1, status queued, progress start" do
      assert {:ok, %Submission{} = submission} =
               Submissions.create_submission(%{context_id: 1, locale: "en"})

      assert submission.context_id == 1
      assert submission.stage_id == 1
      assert submission.status == SubmissionStatus.queued()
      assert submission.submission_progress == "start"
      assert submission.date_submitted == nil
      assert submission.date_last_activity
    end

    test "context_id wajib diisi" do
      assert {:error, changeset} = Submissions.create_submission(%{locale: "en"})
      assert "can't be blank" in errors_on(changeset).context_id
    end

    test "stage_id yang tidak dikenal ditolak" do
      assert {:error, changeset} =
               Submissions.create_submission(%{context_id: 1, stage_id: 99})

      assert errors_on(changeset).stage_id != []
    end

    test "status yang tidak dikenal ditolak" do
      assert {:error, changeset} =
               Submissions.create_submission(%{context_id: 1, status: 2})

      assert errors_on(changeset).status != []
    end
  end

  describe "list_submissions_for_context/1 dan get_submission!/1" do
    test "hanya mengembalikan naskah milik jurnal itu" do
      mine = submission_fixture(%{context_id: 1})
      _other = submission_fixture(%{context_id: 2})

      ids = Enum.map(Submissions.list_submissions_for_context(1), & &1.submission_id)
      assert mine.submission_id in ids
      refute Enum.any?(Submissions.list_submissions_for_context(1), &(&1.context_id == 2))
    end

    test "get_submission!/1 mengambil berdasarkan submission_id" do
      submission = submission_fixture()

      assert Submissions.get_submission!(submission.submission_id).submission_id ==
               submission.submission_id
    end
  end

  describe "submit_submission/1" do
    test "mengisi date_submitted dan mengosongkan submission_progress" do
      submission = submission_fixture()

      assert {:ok, submitted} = Submissions.submit_submission(submission)
      assert submitted.date_submitted
      assert submitted.submission_progress == ""

      reloaded = Submissions.get_submission!(submission.submission_id)
      assert reloaded.submission_progress == ""
      assert reloaded.date_submitted
    end
  end

  describe "submission files" do
    test "membuat metadata file dan menghubungkannya dengan submission" do
      submission = submission_fixture()

      assert {:ok, %{file: file, submission_file: submission_file}} =
               Submissions.create_submission_file(
                 submission,
                 %{path: "test/document.pdf", mimetype: "application/pdf"},
                 %{file_stage: 1}
               )

      assert file.path == "test/document.pdf"
      assert file.mimetype == "application/pdf"
      assert submission_file.submission_id == submission.submission_id
      assert submission_file.file_id == file.file_id
      assert submission_file.file_stage == 1
      assert submission_file.created_at
      assert submission_file.updated_at
    end

    test "mengambil daftar file milik submission" do
      submission = submission_fixture()

      assert {:ok, %{submission_file: created}} =
               Submissions.create_submission_file(
                 submission,
                 %{path: "test/document.pdf", mimetype: "application/pdf"},
                 %{file_stage: 1}
               )

      files = Submissions.list_submission_files(submission.submission_id)

      assert length(files) == 1

      assert hd(files).submission_file.submission_file_id ==
               created.submission_file_id

      assert hd(files).file.path == "test/document.pdf"
    end

    test "mengambil submission file berdasarkan ID" do
      submission = submission_fixture()

      assert {:ok, %{submission_file: created}} =
               Submissions.create_submission_file(
                 submission,
                 %{path: "test/document.pdf", mimetype: "application/pdf"},
                 %{file_stage: 1}
               )

      result = Submissions.get_submission_file!(created.submission_file_id)

      assert result.submission_file_id == created.submission_file_id
    end

    test "membatalkan penyimpanan metadata jika submission file gagal dibuat" do
      submission = submission_fixture()
      files_before = Repo.aggregate(File, :count, :file_id)

      assert {:error, %Ecto.Changeset{}} =
               Submissions.create_submission_file(
                 submission,
                 %{path: "test/document.pdf", mimetype: "application/pdf"},
                 %{}
               )

      files_after = Repo.aggregate(File, :count, :file_id)

      assert files_after == files_before
    end
  end

  describe "author_owns_submission?/2" do
    test "mengembalikan true untuk Author yang ditugaskan" do
      user = author_fixture(1)
      submission = submission_fixture()

      group =
        Repo.one!(
          from ug in UserGroup,
            join: uug in UserUserGroup,
            on: uug.user_group_id == ug.user_group_id,
            where:
              uug.user_id == ^user.user_id and
                ug.context_id == 1 and
                ug.role_id == ^Roles.author(),
            select: ug
        )

      Repo.insert!(%StageAssignment{
        submission_id: submission.submission_id,
        user_id: user.user_id,
        user_group_id: group.user_group_id,
        date_assigned: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
      })

      assert Submissions.author_owns_submission?(
               submission.submission_id,
               user.user_id
             )
    end

    test "mengembalikan false untuk user yang tidak ditugaskan" do
      submission = submission_fixture()
      user = user_fixture()

      refute Submissions.author_owns_submission?(
               submission.submission_id,
               user.user_id
             )
    end
  end

  describe "create_author_submission_file/4" do
    test "Author yang ditugaskan boleh membuat file submission" do
      user = author_fixture(1)
      submission = submission_fixture()

      group =
        Repo.one!(
          from ug in UserGroup,
            join: uug in UserUserGroup,
            on: uug.user_group_id == ug.user_group_id,
            where:
              uug.user_id == ^user.user_id and
                ug.context_id == 1 and
                ug.role_id == ^Roles.author(),
            select: ug
        )

      Repo.insert!(%StageAssignment{
        submission_id: submission.submission_id,
        user_id: user.user_id,
        user_group_id: group.user_group_id,
        date_assigned: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
      })

      assert {:ok, %{file: file, submission_file: submission_file}} =
               Submissions.create_author_submission_file(
                 user,
                 submission.submission_id,
                 %{path: "test/author.pdf", mimetype: "application/pdf"},
                 %{file_stage: 1}
               )

      assert file.path == "test/author.pdf"
      assert submission_file.submission_id == submission.submission_id
    end

    test "user yang bukan Author pemilik ditolak" do
      user = user_fixture()
      submission = submission_fixture()

      assert {:error, :not_authorized} =
               Submissions.create_author_submission_file(
                 user,
                 submission.submission_id,
                 %{path: "test/unauthorized.pdf", mimetype: "application/pdf"},
                 %{file_stage: 1}
               )
    end

    test "submission yang tidak ditemukan ditolak" do
      user = user_fixture()

      assert {:error, :submission_not_found} =
               Submissions.create_author_submission_file(
                 user,
                 -1,
                 %{path: "test/missing.pdf", mimetype: "application/pdf"},
                 %{file_stage: 1}
               )
    end
  end
end
