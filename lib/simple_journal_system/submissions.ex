defmodule SimpleJournalSystem.Submissions do
  @moduledoc """
  Konteks naskah (submission) sesuai OJS 3.5.
  """

  import Ecto.Query, warn: false
  alias SimpleJournalSystem.Repo

  alias SimpleJournalSystem.Accounts
  alias SimpleJournalSystem.Accounts.Roles
  alias SimpleJournalSystem.Accounts.User
  alias SimpleJournalSystem.Accounts.UserGroup
  alias SimpleJournalSystem.Accounts.UserUserGroup
  alias SimpleJournalSystem.Journals.Journal
  alias SimpleJournalSystem.Submissions.Author
  alias SimpleJournalSystem.Submissions.Publication
  alias SimpleJournalSystem.Submissions.Section
  alias SimpleJournalSystem.Submissions.StageAssignment
  alias SimpleJournalSystem.Submissions.Submission

  @doc """
  Daftar naskah milik satu jurnal (`context_id`), yang terbaru lebih dulu.
  """
  def list_submissions_for_context(context_id) do
    Submission
    |> where([s], s.context_id == ^context_id)
    |> order_by([s], desc: s.submission_id)
    |> Repo.all()
  end

  @doc """
  Mengambil satu naskah. Error `Ecto.NoResultsError` kalau tidak ada.
  """
  def get_submission!(submission_id), do: Repo.get!(Submission, submission_id)

  @doc """
  Membuat naskah baru (awal wizard author): stage 1, status queued,
  `submission_progress` "start".

  Ini hanya membuat baris `submissions`. Untuk alur lengkap seperti tombol
  "Begin Submission" di OJS, pakai `start_submission/3`.
  """
  def create_submission(attrs) do
    %Submission{}
    |> Submission.create_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Mengubah naskah.
  """
  def update_submission(%Submission{} = submission, attrs) do
    submission
    |> Submission.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Author mengirim naskah (menekan Submit): `date_submitted` terisi dan
  `submission_progress` kosong.
  """
  def submit_submission(%Submission{} = submission) do
    submission
    |> Submission.submit_changeset()
    |> Repo.update()
  end

  @doc """
  Changeset untuk form.
  """
  def change_submission(%Submission{} = submission, attrs \\ %{}) do
    Submission.changeset(submission, attrs)
  end

  ## Begin Submission (langkah pertama wizard author)

  @doc """
  Memulai naskah baru oleh `user` di jurnal `journal_id`, sama seperti tombol
  "Begin Submission" di OJS 3.5 (PKPSubmissionController::add).

  `attrs` boleh berisi `:section_id` dan `:locale`.

  Yang ditulis ke database, dalam satu transaksi:

    1. `submissions` (stage 1, status queued, progress "start")
    2. `publications` (versi 1, status sama dengan naskah, section yang dipilih)
    3. `submissions.current_publication_id` diisi publikasi itu
    4. `stage_assignments` untuk user sebagai pengirim
    5. kalau user mengirim sebagai Author: `authors` dari data akun user
       (+ `author_settings`), lalu `publications.primary_contact_id` diisi

  Kalau user belum punya role Author/Manager di jurnal itu, user otomatis
  didaftarkan ke grup Author jurnal tersebut (seperti OJS).

  Mengembalikan `{:ok, %{submission:, publication:, author:, user_group:}}`
  atau `{:error, alasan}`. Alasan: `:journal_not_found`, `:submissions_disabled`,
  `:section_not_found`, `:section_inactive`, `:section_editor_restricted`,
  `:not_allowed`, atau `%Ecto.Changeset{}`.
  """
  def start_submission(%User{} = user, journal_id, attrs \\ %{}) do
    Repo.transaction(fn ->
      case do_start_submission(user, journal_id, attrs) do
        {:ok, result} -> result
        {:error, reason} -> Repo.rollback(reason)
      end
    end)
  end

  defp do_start_submission(user, journal_id, attrs) do
    with {:ok, journal} <- fetch_journal(journal_id),
         :ok <- check_accepting_submissions(journal),
         groups = list_user_groups_in_journal(user.user_id, journal.journal_id),
         {:ok, section_id} <- validate_section(attrs, journal, groups),
         {:ok, group} <- pick_submitter_group(user, journal, groups),
         {:ok, submission} <- insert_submission(journal, attrs),
         {:ok, publication} <- insert_publication(submission, section_id),
         {:ok, submission} <- set_current_publication(submission, publication),
         {:ok, _assignment} <- insert_stage_assignment(submission, group, user),
         {:ok, %{author: author, publication: publication}} <-
           maybe_create_author(user, submission, publication, group) do
      {:ok,
       %{submission: submission, publication: publication, author: author, user_group: group}}
    end
  end

  defp fetch_journal(journal_id) do
    case Repo.get(Journal, journal_id) do
      nil -> {:error, :journal_not_found}
      journal -> {:ok, journal}
    end
  end

  # Setting jurnal `disableSubmissions` mematikan pengiriman naskah baru.
  defp check_accepting_submissions(journal) do
    disabled? =
      Repo.exists?(
        from s in "journal_settings",
          where:
            s.journal_id == ^journal.journal_id and s.setting_name == "disableSubmissions" and
              s.setting_value in ["1", "true"]
      )

    if disabled?, do: {:error, :submissions_disabled}, else: :ok
  end

  # Grup user di jurnal ini yang masih aktif (date_end kosong atau belum lewat).
  defp list_user_groups_in_journal(user_id, journal_id) do
    now = now()

    from(g in UserGroup,
      join: uug in UserUserGroup,
      on: uug.user_group_id == g.user_group_id,
      where: uug.user_id == ^user_id and g.context_id == ^journal_id,
      where: is_nil(uug.date_end) or uug.date_end > ^now,
      select: g
    )
    |> Repo.all()
  end

  defp editor?(groups) do
    Enum.any?(groups, &(&1.role_id in [Roles.manager(), Roles.sub_editor()]))
  end

  defp validate_section(attrs, journal, groups) do
    case Map.get(attrs, :section_id) do
      nil ->
        {:ok, nil}

      section_id ->
        Section
        |> Repo.get_by(section_id: section_id, journal_id: journal.journal_id)
        |> check_section(groups)
    end
  end

  defp check_section(nil, _groups), do: {:error, :section_not_found}

  defp check_section(%Section{is_inactive: inactive}, _groups) when inactive != 0,
    do: {:error, :section_inactive}

  defp check_section(%Section{editor_restricted: restricted, section_id: id}, groups)
       when restricted != 0 do
    if editor?(groups), do: {:ok, id}, else: {:error, :section_editor_restricted}
  end

  defp check_section(%Section{section_id: id}, _groups), do: {:ok, id}

  # Mengirim sebagai Author kalau user punya grup Author, kalau tidak sebagai
  # Manager. Kalau tidak punya keduanya, user didaftarkan ke grup Author jurnal.
  defp pick_submitter_group(user, journal, groups) do
    submitter_groups = Enum.filter(groups, &(&1.role_id in [Roles.author(), Roles.manager()]))

    case Enum.find(submitter_groups, &(&1.role_id == Roles.author())) ||
           List.first(submitter_groups) do
      nil -> enroll_in_default_author_group(user, journal)
      group -> {:ok, group}
    end
  end

  defp enroll_in_default_author_group(user, journal) do
    author_role = Roles.author()

    group =
      Repo.one(
        from g in UserGroup,
          where: g.context_id == ^journal.journal_id and g.role_id == ^author_role,
          order_by: g.user_group_id,
          limit: 1
      )

    with %UserGroup{} <- group,
         {:ok, :enrolled} <- Accounts.enroll_user(user.user_id, group.user_group_id, user.user_id) do
      {:ok, group}
    else
      _ -> {:error, :not_allowed}
    end
  end

  defp insert_submission(journal, attrs) do
    create_submission(%{
      context_id: journal.journal_id,
      locale: Map.get(attrs, :locale) || journal.primary_locale
    })
  end

  defp insert_publication(submission, section_id) do
    Repo.insert(%Publication{
      submission_id: submission.submission_id,
      version: 1,
      status: submission.status,
      section_id: section_id,
      last_modified: now()
    })
  end

  defp set_current_publication(submission, publication) do
    submission
    |> Ecto.Changeset.change(
      current_publication_id: publication.publication_id,
      last_modified: now()
    )
    |> Repo.update()
  end

  # "Penulis selalu boleh mengubah metadata sebelum submit" (aturan OJS), jadi
  # `can_change_metadata` bernilai 1 selama `submission_progress` belum kosong.
  defp insert_stage_assignment(submission, group, user) do
    Repo.insert(%StageAssignment{
      submission_id: submission.submission_id,
      user_group_id: group.user_group_id,
      user_id: user.user_id,
      date_assigned: now(),
      recommend_only: 0,
      can_change_metadata: 1
    })
  end

  defp maybe_create_author(user, submission, publication, %UserGroup{role_id: role_id} = group) do
    if role_id == Roles.author() do
      create_author_from_user(user, submission, publication, group)
    else
      {:ok, %{author: nil, publication: publication}}
    end
  end

  # Membuat kontributor dari akun user (Repo::author()->newAuthorFromUser di OJS).
  defp create_author_from_user(user, submission, publication, group) do
    with {:ok, author} <-
           Repo.insert(%Author{
             email: user.email,
             include_in_browse: 1,
             publication_id: publication.publication_id,
             seq: next_author_seq(publication.publication_id),
             user_group_id: group.user_group_id
           }),
         :ok <- insert_author_settings(author, user, submission),
         {:ok, publication} <-
           publication
           |> Ecto.Changeset.change(primary_contact_id: author.author_id, last_modified: now())
           |> Repo.update() do
      {:ok, %{author: author, publication: publication}}
    end
  end

  defp next_author_seq(publication_id) do
    max_seq =
      Repo.one(
        from a in Author,
          where: a.publication_id == ^publication_id,
          select: max(a.seq)
      )

    if max_seq, do: max_seq + 1.0, else: 0.0
  end

  # Menyalin nama (givenName, familyName), biografi, dan ORCID dari pengaturan
  # user, serta negara dan URL dari akun. Nama depan wajib ada untuk bahasa
  # naskah, kalau belum ada disalin dari bahasa lain.
  defp insert_author_settings(author, user, submission) do
    user_settings =
      Repo.all(
        from s in "user_settings",
          where:
            s.user_id == ^user.user_id and
              s.setting_name in ["givenName", "familyName", "biography", "orcid"],
          select: {s.setting_name, s.locale, s.setting_value}
      )

    copied = Enum.map(user_settings, fn {name, locale, value} -> {name, locale || "", value} end)
    copied = ensure_given_name(copied, submission.locale)

    from_account = [{"country", "", user.country}, {"url", "", user.url}]

    rows =
      (copied ++ from_account)
      |> Enum.reject(fn {_name, _locale, value} -> value in [nil, ""] end)
      |> Enum.map(fn {name, locale, value} ->
        %{
          author_id: author.author_id,
          locale: locale,
          setting_name: name,
          setting_value: value
        }
      end)

    if rows != [], do: Repo.insert_all("author_settings", rows)
    :ok
  end

  defp ensure_given_name(settings, submission_locale) do
    given = Enum.filter(settings, fn {name, _locale, _value} -> name == "givenName" end)

    cond do
      given == [] -> settings
      Enum.any?(given, fn {_name, locale, _value} -> locale == submission_locale end) -> settings
      true -> [{"givenName", submission_locale, elem(hd(given), 2)} | settings]
    end
  end

  defp now, do: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)
end
