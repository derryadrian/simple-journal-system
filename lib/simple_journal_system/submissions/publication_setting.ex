defmodule SimpleJournalSystem.Submissions.PublicationSetting do
  @moduledoc """
  Pengaturan metadata publikasi, sama dengan tabel
  `publication_settings` di OJS 3.5.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:publication_setting_id, :id, autogenerate: true}
  @derive {Phoenix.Param, key: :publication_setting_id}

  schema "publication_settings" do
    field :locale, :string, default: ""
    field :setting_name, :string
    field :setting_value, :string

    belongs_to :publication, SimpleJournalSystem.Submissions.Publication,
      foreign_key: :publication_id,
      references: :publication_id
  end

  def changeset(setting, attrs) do
    setting
    |> cast(attrs, [:publication_id, :locale, :setting_name, :setting_value])
    |> validate_required([:publication_id, :locale, :setting_name])
    |> unique_constraint(:publication_id, name: :publication_settings_unique)
  end
end
