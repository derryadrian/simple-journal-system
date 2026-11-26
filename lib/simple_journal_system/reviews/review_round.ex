defmodule SimpleJournalSystem.Reviews.ReviewRound do
  @moduledoc """
  Putaran review sebuah submission, sesuai tabel `review_rounds` OJS 3.5.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:review_round_id, :id, autogenerate: true}
  @derive {Phoenix.Param, key: :review_round_id}

  schema "review_rounds" do
    field :submission_id, :integer
    field :stage_id, :integer
    field :round, :integer
    field :review_revision, :integer
    field :status, :integer
  end

  def changeset(review_round, attrs) do
    review_round
    |> cast(attrs, [
      :submission_id,
      :stage_id,
      :round,
      :review_revision,
      :status
    ])
    |> validate_required([
      :submission_id,
      :round
    ])
    |> validate_number(:submission_id, greater_than: 0)
    |> validate_number(:round, greater_than: 0)
    |> validate_number(:stage_id, greater_than: 0)
  end
end
