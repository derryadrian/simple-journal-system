defmodule SimpleJournalSystem.Accounts.UserGroupSetting do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:user_group_setting_id, :id, []}
  @derive {Phoenix.Param, key: :user_group_setting_id}

  schema "user_group_settings" do
    field :locale, :string
    field :setting_name, :string
    field :setting_value, :string

    belongs_to :user_group, SimpleJournalSystem.Accounts.UserGroup,
      foreign_key: :user_group_id,
      references: :user_group_id

    timestamps(type: :utc_datetime, updated_at: false)
  end

  def changeset(setting, attrs) do
    setting
    |> cast(attrs, [:user_group_id, :locale, :setting_name, :setting_value])
    |> validate_required([:user_group_id, :setting_name])
    |> unique_constraint(:user_group_id, name: :user_group_settings_user_group_id_locale_setting_name_key)
  end
end