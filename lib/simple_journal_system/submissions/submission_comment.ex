defmodule SimpleJournalSystem.Submissions.SubmissionComment do
  @moduledoc """
  Komentar pada submission, sesuai tabel `submission_comments` di OJS 3.5.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:comment_id, :id, autogenerate: true}
  @derive {Phoenix.Param, key: :comment_id}

  schema "submission_comments" do
    field :comment_type, :integer
    field :role_id, :integer
    field :submission_id, :integer
    field :assoc_id, :integer
    field :author_id, :integer
    field :comment_title, :string
    field :comments, :string
    field :date_posted, :naive_datetime
    field :date_modified, :naive_datetime
    field :viewable, :integer
  end

  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [
      :comment_type,
      :role_id,
      :submission_id,
      :assoc_id,
      :author_id,
      :comment_title,
      :comments,
      :date_posted,
      :date_modified,
      :viewable
    ])
    |> validate_required([
      :role_id,
      :submission_id,
      :assoc_id,
      :author_id,
      :comment_title
    ])
  end
end
