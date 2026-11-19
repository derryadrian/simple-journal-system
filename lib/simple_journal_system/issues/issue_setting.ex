defmodule SimpleJournalSystem.Issues.IssueSetting do
  @moduledoc """
  Pengaturan metadata issue jurnal.
  Sama dengan tabel `issue_settings` di OJS 3.5.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:issue_setting_id, :id, autogenerate: true}
  @derive {Phoenix.Param, key: :issue_setting_id}

  schema "issue_settings" do
    field :locale, :string, default: ""
    field :setting_name, :string
    field :setting_value, :string

    belongs_to :issue, SimpleJournalSystem.Issues.Issue,
      foreign_key: :issue_id,
      references: :issue_id
  end

  def changeset(setting, attrs) do
    setting
    |> cast(attrs, [:issue_id, :locale, :setting_name, :setting_value])
    |> validate_required([:issue_id, :locale, :setting_name])
    |> validate_length(:locale, max: 28)
    |> validate_length(:setting_name, max: 255)
    |> unique_constraint(:issue_id, name: :issue_settings_unique)
  end
end
