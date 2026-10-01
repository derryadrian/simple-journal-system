defmodule SimpleJournalSystem.Accounts.UserUserGroup do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:user_user_group_id, :id, []}
  @derive {Phoenix.Param, key: :user_user_group_id}

  schema "user_user_groups" do
    field :date_start, :naive_datetime
    field :date_end, :naive_datetime
    field :masthead, :integer

    belongs_to :user,
      SimpleJournalSystem.Accounts.User,
      foreign_key: :user_id,
      references: :user_id

    belongs_to :user_group,
      SimpleJournalSystem.Accounts.UserGroup,
      foreign_key: :user_group_id,
      references: :user_group_id

    timestamps(type: :utc_datetime, updated_at: false)
  end

  def changeset(uug, attrs) do
    uug
    |> cast(attrs, [:user_id, :user_group_id, :date_start, :date_end, :masthead])
    |> validate_required([:user_id, :user_group_id])
    |> unique_constraint([:user_id, :user_group_id], name: :user_user_groups_user_id_user_group_id_key)
  end
end