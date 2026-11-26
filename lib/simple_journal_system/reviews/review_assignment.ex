defmodule SimpleJournalSystem.Reviews.ReviewAssignment do
  @moduledoc """
  Penugasan reviewer terhadap submission dalam suatu review round,
  sesuai tabel `review_assignments` OJS 3.5.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias SimpleJournalSystem.Ojs.{
    ReviewAssignmentConsidered,
    ReviewMethod,
    ReviewRecommendation
  }

  @primary_key {:review_id, :id, autogenerate: true}
  @derive {Phoenix.Param, key: :review_id}

  schema "review_assignments" do
    field :submission_id, :integer
    field :reviewer_id, :integer
    field :competing_interests, :string
    field :recommendation, :integer

    field :date_assigned, :naive_datetime
    field :date_notified, :naive_datetime
    field :date_confirmed, :naive_datetime
    field :date_completed, :naive_datetime
    field :date_considered, :naive_datetime
    field :date_acknowledged, :naive_datetime
    field :date_due, :naive_datetime
    field :date_response_due, :naive_datetime
    field :last_modified, :naive_datetime

    field :reminder_was_automatic, :integer, default: 0
    field :declined, :integer, default: 0
    field :cancelled, :integer, default: 0

    field :date_cancelled, :naive_datetime
    field :date_rated, :naive_datetime
    field :date_reminded, :naive_datetime

    field :quality, :integer
    field :review_round_id, :integer
    field :stage_id, :integer
    field :review_method, :integer, default: 1
    field :round, :integer, default: 1
    field :step, :integer, default: 1
    field :review_form_id, :integer
    field :considered, :integer
    field :request_resent, :integer, default: 0
  end

  def changeset(review_assignment, attrs) do
    review_assignment
    |> cast(attrs, [
      :submission_id,
      :reviewer_id,
      :competing_interests,
      :recommendation,
      :date_assigned,
      :date_notified,
      :date_confirmed,
      :date_completed,
      :date_considered,
      :date_acknowledged,
      :date_due,
      :date_response_due,
      :last_modified,
      :reminder_was_automatic,
      :declined,
      :cancelled,
      :date_cancelled,
      :date_rated,
      :date_reminded,
      :quality,
      :review_round_id,
      :stage_id,
      :review_method,
      :round,
      :step,
      :review_form_id,
      :considered,
      :request_resent
    ])
    |> validate_required([
      :submission_id,
      :reviewer_id,
      :review_round_id,
      :stage_id
    ])
    |> validate_number(:submission_id, greater_than: 0)
    |> validate_number(:reviewer_id, greater_than: 0)
    |> validate_number(:review_round_id, greater_than: 0)
    |> validate_number(:stage_id, greater_than: 0)
    |> validate_number(:round, greater_than: 0)
    |> validate_number(:step, greater_than: 0)
    |> validate_inclusion(
      :recommendation,
      ReviewRecommendation.all()
    )
    |> validate_inclusion(
      :review_method,
      ReviewMethod.all()
    )
    |> validate_inclusion(
      :considered,
      ReviewAssignmentConsidered.all()
    )
  end
end
