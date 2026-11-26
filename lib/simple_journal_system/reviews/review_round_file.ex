defmodule SimpleJournalSystem.Reviews.ReviewRoundFile do
  @moduledoc """
  Penghubung antara review round dan file submission,
  sesuai tabel `review_round_files` OJS 3.5.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:review_round_file_id, :id, autogenerate: true}
  @derive {Phoenix.Param, key: :review_round_file_id}

  schema "review_round_files" do
    field :submission_id, :integer
    field :review_round_id, :integer
    field :stage_id, :integer
    field :submission_file_id, :integer
  end

  def changeset(review_round_file, attrs) do
    review_round_file
    |> cast(attrs, [
      :submission_id,
      :review_round_id,
      :stage_id,
      :submission_file_id
    ])
    |> validate_required([
      :submission_id,
      :review_round_id,
      :stage_id,
      :submission_file_id
    ])
    |> validate_number(:submission_id, greater_than: 0)
    |> validate_number(:review_round_id, greater_than: 0)
    |> validate_number(:stage_id, greater_than: 0)
    |> validate_number(:submission_file_id, greater_than: 0)
    |> unique_constraint(
      [:submission_id, :review_round_id, :submission_file_id],
      name: :review_round_files_unique
    )
  end
end
