defmodule SimpleJournalSystem.Submissions.Author do
  @moduledoc """
  Kontributor (penulis) sebuah publikasi, sama dengan tabel `authors` di OJS 3.5.

  Nama, afiliasi, negara, dan lainnya ada di `author_settings`.
  """
  use Ecto.Schema

  @primary_key {:author_id, :id, autogenerate: true}

  schema "authors" do
    field :email, :string
    field :include_in_browse, :integer, default: 1
    field :publication_id, :integer
    field :seq, :float, default: 0.0
    field :user_group_id, :integer
  end
end
