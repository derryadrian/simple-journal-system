defmodule SimpleJournalSystem.Submissions.PublicationGalleySetting do
  @moduledoc """
  Pengaturan metadata galley publikasi.
  Sama dengan tabel `publication_galley_settings` di OJS 3.5.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:publication_galley_setting_id, :id, autogenerate: true}
  @derive {Phoenix.Param, key: :publication_galley_setting_id}

  schema "publication_galley_settings" do
    field :locale, :string, default: ""
    field :setting_name, :string
    field :setting_value, :string

    belongs_to :publication_galley,
               SimpleJournalSystem.Submissions.PublicationGalley,
               foreign_key: :galley_id,
               references: :galley_id
  end

  def changeset(setting, attrs) do
    setting
    |> cast(attrs, [:galley_id, :locale, :setting_name, :setting_value])
    |> validate_required([:galley_id, :locale, :setting_name])
    |> validate_length(:locale, max: 28)
    |> validate_length(:setting_name, max: 255)
    |> unique_constraint(:galley_id, name: :publication_galley_settings_unique)
  end
end
