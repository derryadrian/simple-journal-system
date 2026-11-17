defmodule SimpleJournalSystem.Submissions.File do
  @moduledoc """
  Metadata file fisik yang disimpan OJS 3.5.
  Sama dengan tabel `files`.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:file_id, :id, autogenerate: true}

  schema "files" do
    field :path, :string
    field :mimetype, :string
  end

  def changeset(file, attrs) do
    file
    |> cast(attrs, [:path, :mimetype])
    |> validate_required([:path, :mimetype])
    |> validate_length(:path, max: 255)
    |> validate_length(:mimetype, max: 255)
  end
end
