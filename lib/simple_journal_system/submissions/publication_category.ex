defmodule SimpleJournalSystem.Submissions.PublicationCategory do
  @moduledoc """
  Relasi antara publikasi dan kategori jurnal.
  Sama dengan tabel `publication_categories` di OJS 3.5.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:publication_category_id, :id, autogenerate: true}
  @derive {Phoenix.Param, key: :publication_category_id}

  schema "publication_categories" do
    field :category_id, :integer

    belongs_to :publication, SimpleJournalSystem.Submissions.Publication,
      foreign_key: :publication_id,
      references: :publication_id
  end

  def changeset(publication_category, attrs) do
    publication_category
    |> cast(attrs, [:publication_id, :category_id])
    |> validate_required([:publication_id, :category_id])
    |> unique_constraint(:publication_id, name: :publication_categories_id)
  end
end
