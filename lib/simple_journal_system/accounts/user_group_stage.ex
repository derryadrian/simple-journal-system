defmodule SimpleJournalSystem.Accounts.UserGroupStage do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:user_group_stage_id, :id, []}
  @derive {Phoenix.Param, key: :user_group_stage_id}

  schema "user_group_stage" do
    field :context_id, :integer
    field :stage_id, :integer

    belongs_to :user_group, SimpleJournalSystem.Accounts.UserGroup,
      foreign_key: :user_group_id,
      references: :user_group_id

    timestamps(type: :utc_datetime, updated_at: false)
  end

  def changeset(stage, attrs) do
    stage
    |> cast(attrs, [:context_id, :user_group_id, :stage_id])
    |> validate_required([:context_id, :user_group_id, :stage_id])
    |> unique_constraint([:context_id, :user_group_id, :stage_id], name: :user_group_stage_context_id_user_group_id_stage_id_key)
  end
end