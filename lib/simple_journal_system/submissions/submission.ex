defmodule SimpleJournalSystem.Submissions.Submission do
  @moduledoc """
  Naskah, sama dengan tabel `submissions` di OJS 3.5.

  Judul, abstrak, dan penulis TIDAK disimpan di sini. Di OJS semuanya ada di
  `publications` / `publication_settings` / `authors`.

  Kolom penting:

    * `stage_id` - tahap workflow (lihat `Accounts.Stages`): 1 submission, 3 review,
      4 copyediting, 5 production.
    * `status` - lihat `Ojs.SubmissionStatus`. Hanya berubah lewat keputusan editor
      atau publikasi, jangan diubah sembarangan.
    * `submission_progress` - langkah wizard author yang sedang dikerjakan. Teks
      kosong berarti naskah sudah dikirim (submitted).
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias SimpleJournalSystem.Accounts.Stages
  alias SimpleJournalSystem.Ojs.SubmissionStatus

  @primary_key {:submission_id, :id, autogenerate: true}

  schema "submissions" do
    field :context_id, :integer
    field :current_publication_id, :integer
    field :date_last_activity, :naive_datetime
    field :date_submitted, :naive_datetime
    field :last_modified, :naive_datetime
    field :stage_id, :integer, default: 1
    field :locale, :string
    field :status, :integer, default: 1
    field :submission_progress, :string, default: "start"
    field :work_type, :integer, default: 0
  end

  @doc """
  Changeset umum. Mengisi `last_modified` setiap ada perubahan.
  """
  def changeset(submission, attrs) do
    submission
    |> cast(attrs, [
      :context_id,
      :current_publication_id,
      :stage_id,
      :locale,
      :status,
      :submission_progress,
      :work_type
    ])
    |> validate_required([:context_id, :stage_id, :status])
    |> validate_inclusion(:stage_id, Stages.all())
    |> validate_inclusion(:status, SubmissionStatus.all())
    |> validate_length(:locale, max: 28)
    |> validate_length(:submission_progress, max: 50)
    |> touch_last_modified()
  end

  @doc """
  Changeset untuk naskah baru (awal wizard author). Mengisi `date_last_activity`.
  """
  def create_changeset(submission, attrs) do
    submission
    |> changeset(attrs)
    |> put_change(:date_last_activity, now())
  end

  @doc """
  Menandai naskah sudah dikirim, seperti saat author menekan Submit di OJS:
  `date_submitted` diisi dan `submission_progress` dikosongkan.
  """
  def submit_changeset(submission) do
    submission
    |> change()
    |> put_change(:date_submitted, now())
    |> put_change(:submission_progress, "")
    |> put_change(:date_last_activity, now())
    |> put_change(:last_modified, now())
  end

  defp touch_last_modified(changeset) do
    if changeset.valid? and map_size(changeset.changes) > 0 do
      put_change(changeset, :last_modified, now())
    else
      changeset
    end
  end

  defp now, do: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)
end
