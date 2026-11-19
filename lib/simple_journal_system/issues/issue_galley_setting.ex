defmodule SimpleJournalSystem.Issues.IssueGalleySetting do
  @moduledoc """
  Pengaturan metadata galley issue jurnal.
  Sama dengan tabel `issue_galley_settings` di OJS 3.5.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:issue_galley_setting_id, :id, autogenerate: true}
  @derive {Phoenix.Param, key: :issue_galley_setting_id}

  schema "issue_galley_settings" do
    field :locale, :string, default: ""
    field :setting_name, :string
    field :setting_value, :string
    field :setting_type, :string

    belongs_to :issue_galley, SimpleJournalSystem.Issues.IssueGalley,
      foreign_key: :galley_id,
      references: :galley_id
  end

  def changeset(setting, attrs) do
    setting
    |> cast(attrs, [:galley_id, :locale, :setting_name, :setting_value, :setting_type])
    |> validate_required([:galley_id, :locale, :setting_name, :setting_type])
    |> validate_length(:locale, max: 28)
    |> validate_length(:setting_name, max: 255)
    |> validate_length(:setting_type, max: 6)
    |> unique_constraint(:galley_id, name: :issue_galley_settings_unique)
  end
end
