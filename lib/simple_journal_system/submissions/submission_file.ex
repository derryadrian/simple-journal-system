defmodule SimpleJournalSystem.Submissions.SubmissionFile do
  @moduledoc """
  Penghubung antara submission, file fisik, dan genre.
  Sama dengan tabel `submission_files` di OJS 3.5.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:submission_file_id, :id, autogenerate: true}

  schema "submission_files" do
    field :submission_id, :integer
    field :file_id, :integer
    field :source_submission_file_id, :integer
    field :genre_id, :integer
    field :file_stage, :integer
    field :direct_sales_price, :string
    field :sales_type, :string
    field :viewable, :integer
    field :created_at, :naive_datetime
    field :updated_at, :naive_datetime
    field :uploader_user_id, :integer
    field :assoc_type, :integer
    field :assoc_id, :integer
  end

  def changeset(submission_file, attrs) do
    submission_file
    |> cast(attrs, [
      :submission_id,
      :file_id,
      :source_submission_file_id,
      :genre_id,
      :file_stage,
      :direct_sales_price,
      :sales_type,
      :viewable,
      :created_at,
      :updated_at,
      :uploader_user_id,
      :assoc_type,
      :assoc_id
    ])
    |> validate_required([
      :submission_id,
      :file_id,
      :file_stage,
      :created_at,
      :updated_at
    ])
    |> validate_length(:direct_sales_price, max: 255)
    |> validate_length(:sales_type, max: 255)
  end
end
