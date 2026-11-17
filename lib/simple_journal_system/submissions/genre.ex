defmodule SimpleJournalSystem.Submissions.Genre do
  @moduledoc """
  Jenis file submission dalam sebuah jurnal.
  Sama dengan tabel `genres` di OJS 3.5.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:genre_id, :id, autogenerate: true}

  schema "genres" do
    field :context_id, :integer
    field :seq, :integer
    field :enabled, :integer, default: 1
    field :category, :integer, default: 1
    field :dependent, :integer, default: 0
    field :supplementary, :integer, default: 0
    field :required, :integer, default: 0
    field :entry_key, :string
  end

  def changeset(genre, attrs) do
    genre
    |> cast(attrs, [
      :context_id,
      :seq,
      :enabled,
      :category,
      :dependent,
      :supplementary,
      :required,
      :entry_key
    ])
    |> validate_required([
      :context_id,
      :seq,
      :enabled,
      :category,
      :dependent,
      :supplementary,
      :required
    ])
    |> validate_length(:entry_key, max: 30)
  end
end
