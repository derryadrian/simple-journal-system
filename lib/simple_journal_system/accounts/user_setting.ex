defmodule SimpleJournalSystem.Accounts.UserSetting do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:user_setting_id, :id, []}
  @derive {Phoenix.Param, key: :user_setting_id}

  schema "user_settings" do
    field :locale, :string
    field :setting_name, :string
    field :setting_value, :string

    belongs_to :user, SimpleJournalSystem.Accounts.User,
      foreign_key: :user_id,
      references: :user_id

    timestamps(type: :utc_datetime, updated_at: false)
  end

  def changeset(setting, attrs) do
    setting
    |> cast(attrs, [:user_id, :locale, :setting_name, :setting_value])
    |> validate_required([:user_id, :setting_name])
    |> unique_constraint(:user_id, name: :user_settings_user_id_locale_setting_name_key)
  end
end