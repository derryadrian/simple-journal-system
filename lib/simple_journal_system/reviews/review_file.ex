defmodule SimpleJournalSystem.Reviews.ReviewFile do
  @moduledoc """
  Penghubung antara penugasan reviewer dan file submission,
  sesuai tabel `review_files` OJS 3.5.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:review_file_id, :id, autogenerate: true}
  @derive {Phoenix.Param, key: :review_file_id}

  schema "review_files" do
    field :review_id, :integer
    field :submission_file_id, :integer
  end

  def changeset(review_file, attrs) do
    review_file
    |> cast(attrs, [
      :review_id,
      :submission_file_id
    ])
    |> validate_required([
      :review_id,
      :submission_file_id
    ])
    |> validate_number(:review_id, greater_than: 0)
    |> validate_number(:submission_file_id, greater_than: 0)
    |> unique_constraint(
      [:review_id, :submission_file_id],
      name: :review_files_unique
    )
  end
end
