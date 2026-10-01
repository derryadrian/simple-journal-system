defmodule SimpleJournalSystem.Accounts.UserGroup do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:user_group_id, :id, []}
  @derive {Phoenix.Param, key: :user_group_id}

  schema "user_groups" do
    field :context_id, :integer
    field :role_id, :integer
    field :is_default, :integer, default: 0
    field :show_title, :integer, default: 0
    field :permit_self_registration, :integer, default: 0
    field :permit_metadata_edit, :integer, default: 0
    field :permit_settings, :integer, default: 0
    field :masthead, :integer, default: 0

    has_many :user_user_groups,
      SimpleJournalSystem.Accounts.UserUserGroup,
      foreign_key: :user_group_id,
      references: :user_group_id

    has_many :user_group_settings,
      SimpleJournalSystem.Accounts.UserGroupSetting,
      foreign_key: :user_group_id,
      references: :user_group_id

    timestamps(type: :utc_datetime, updated_at: false)
  end

  def changeset(group, attrs) do
    group
    |> cast(attrs, [
      :context_id, :role_id, :is_default, :show_title,
      :permit_self_registration, :permit_metadata_edit,
      :permit_settings, :masthead
    ])
    |> validate_required([:role_id])
    |> unique_constraint([:context_id, :role_id], name: :user_groups_context_id_role_id_key)
  end
end