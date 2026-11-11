defmodule SimpleJournalSystem.Submissions.Publication do
  @moduledoc """
  Publikasi (versi naskah), sama dengan tabel `publications` di OJS 3.5.

  Judul dan abstrak disimpan di `publication_settings`, bukan di tabel ini.
  Setiap naskah punya minimal satu publikasi (`version` 1).
  """
  use Ecto.Schema

  @primary_key {:publication_id, :id, autogenerate: true}

  schema "publications" do
    field :access_status, :integer, default: 0
    field :date_published, :date
    field :last_modified, :naive_datetime
    field :primary_contact_id, :integer
    field :section_id, :integer
    field :seq, :float, default: 0.0
    field :submission_id, :integer
    field :status, :integer, default: 1
    field :url_path, :string
    field :version, :integer
    field :doi_id, :integer
    field :issue_id, :integer
  end
end
