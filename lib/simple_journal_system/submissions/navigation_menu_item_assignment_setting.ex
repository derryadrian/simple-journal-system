defmodule SimpleJournalSystem.Submissions.NavigationMenuItemAssignmentSetting do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:navigation_menu_item_assignment_setting_id, :id, autogenerate: true}
  @derive {Phoenix.Param, key: :navigation_menu_item_assignment_setting_id}

  schema "navigation_menu_item_assignment_settings" do
    field :navigation_menu_item_assignment_id, :integer
    field :locale, :string, default: ""
    field :setting_name, :string
    field :setting_value, :string
    field :setting_type, :string
  end

  def changeset(setting, attrs) do
    setting
    |> cast(attrs, [
      :navigation_menu_item_assignment_id,
      :locale,
      :setting_name,
      :setting_value,
      :setting_type
    ])
    |> validate_required([
      :navigation_menu_item_assignment_id,
      :locale,
      :setting_name,
      :setting_type
    ])
    |> validate_length(:locale, max: 28)
    |> validate_length(:setting_name, max: 255)
    |> validate_length(:setting_type, max: 6)
    |> unique_constraint(
      [:navigation_menu_item_assignment_id, :locale, :setting_name],
      name: :navigation_menu_item_assignment_settings_unique
    )
  end
end
