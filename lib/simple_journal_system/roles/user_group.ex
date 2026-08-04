defmodule SimpleJournalSystem.Roles.UserGroup do
  @moduledoc """
  Maps the existing OJS `user_groups` table.

  Each row describes a role (user group) within a context (journal).
  `role_id` is the OJS permission level (see `SimpleJournalSystem.Roles.role_id_to_key/1`),
  while localized names live in `user_group_settings`.
  """
  use Ecto.Schema

  alias SimpleJournalSystem.Roles.UserGroupSetting
  alias SimpleJournalSystem.Roles.UserUserGroup

  @primary_key {:user_group_id, :id, []}

  schema "user_groups" do
    field :context_id, :integer
    field :role_id, :integer
    field :is_default, :integer
    field :show_title, :integer
    field :permit_self_registration, :integer
    field :permit_metadata_edit, :integer
    field :permit_settings, :integer
    field :masthead, :integer

    has_many :user_group_settings, UserGroupSetting,
      foreign_key: :user_group_id,
      references: :user_group_id

    has_many :user_user_groups, UserUserGroup,
      foreign_key: :user_group_id,
      references: :user_group_id
  end
end
