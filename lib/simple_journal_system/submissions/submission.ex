defmodule SimpleJournalSystem.Submissions.Submission do
  use Ecto.Schema
  import Ecto.Changeset

  schema "submissions" do
    field :title, :string
    field :abstract, :string
    field :status, :integer
    field :journal_id, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(submission, attrs) do
    submission
    |> cast(attrs, [:title, :abstract, :status, :journal_id])
    |> validate_required([:title, :abstract, :status, :journal_id])
  end
end
