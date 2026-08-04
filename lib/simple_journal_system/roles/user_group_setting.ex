defmodule SimpleJournalSystem.Roles.UserGroupSetting do
  @moduledoc """
  Maps the existing OJS `user_group_settings` table.

  Holds localized properties (such as the display name) for a user group.
  """
  use Ecto.Schema

  alias SimpleJournalSystem.Roles.UserGroup

  @primary_key {:user_group_setting_id, :id, []}

  schema "user_group_settings" do
    belongs_to :user_group, UserGroup, foreign_key: :user_group_id, references: :user_group_id
    field :locale, :string
    field :setting_name, :string
    field :setting_value, :string
  end
end
