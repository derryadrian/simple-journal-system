defmodule SimpleJournalSystem.Submissions.QueryParticipant do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:query_participant_id, :id, autogenerate: true}
  @derive {Phoenix.Param, key: :query_participant_id}

  schema "query_participants" do
    field :query_id, :integer

    belongs_to :user,
               SimpleJournalSystem.Accounts.User,
               foreign_key: :user_id,
               references: :user_id
  end

  def changeset(participant, attrs) do
    participant
    |> cast(attrs, [:query_id, :user_id])
    |> validate_required([:query_id, :user_id])
    |> unique_constraint([:query_id, :user_id],
      name: :query_participants_unique
    )
  end
end
