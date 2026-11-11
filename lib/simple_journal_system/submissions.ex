defmodule SimpleJournalSystem.Submissions do
  @moduledoc """
  Konteks naskah (submission) sesuai OJS 3.5.
  """

  import Ecto.Query, warn: false
  alias SimpleJournalSystem.Repo

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
end
