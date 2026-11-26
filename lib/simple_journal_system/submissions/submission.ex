defmodule SimpleJournalSystem.Submissions.Submission do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:submission_id, :id, autogenerate: true}
  @derive {Phoenix.Param, key: :submission_id}

  schema "submissions" do
    field :context_id, :integer
    field :current_publication_id, :integer
    field :date_last_activity, :naive_datetime
    field :date_submitted, :naive_datetime
    field :last_modified, :naive_datetime
    field :stage_id, :integer
    field :locale, :string
    field :status, :integer
    field :submission_progress, :string
    field :work_type, :integer
  end

  def changeset(submission, attrs) do
    submission
    |> cast(attrs, [
      :context_id,
      :current_publication_id,
      :date_last_activity,
      :date_submitted,
      :last_modified,
      :stage_id,
      :locale,
      :status,
      :submission_progress,
      :work_type
    ])
    |> validate_required([:context_id, :stage_id, :status])
  end
end