defmodule SimpleJournalSystem.Submissions.PublicationGalley do
  @moduledoc """
  Galley atau format publikasi artikel.
  Sama dengan tabel `publication_galleys` di OJS 3.5.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:galley_id, :id, autogenerate: true}
  @derive {Phoenix.Param, key: :galley_id}

  schema "publication_galleys" do
    field :locale, :string
    field :label, :string
    field :submission_file_id, :integer
    field :seq, :float, default: 0.0
    field :remote_url, :string
    field :is_approved, :integer, default: 0
    field :url_path, :string
    field :doi_id, :integer

    belongs_to :publication, SimpleJournalSystem.Submissions.Publication,
      foreign_key: :publication_id,
      references: :publication_id
  end

  def changeset(galley, attrs) do
    galley
    |> cast(attrs, [
      :publication_id,
      :locale,
      :label,
      :submission_file_id,
      :seq,
      :remote_url,
      :is_approved,
      :url_path,
      :doi_id
    ])
    |> validate_required([:publication_id, :seq, :is_approved])
    |> validate_length(:locale, max: 28)
    |> validate_length(:label, max: 255)
    |> validate_length(:remote_url, max: 2047)
    |> validate_length(:url_path, max: 64)
  end
end
