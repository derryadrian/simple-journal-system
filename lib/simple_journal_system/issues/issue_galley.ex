defmodule SimpleJournalSystem.Issues.IssueGalley do
  @moduledoc """
  Galley atau file terbitan untuk sebuah issue jurnal.
  Sama dengan tabel `issue_galleys` di OJS 3.5.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:galley_id, :id, autogenerate: true}
  @derive {Phoenix.Param, key: :galley_id}

  schema "issue_galleys" do
    field :locale, :string
    field :file_id, :integer
    field :label, :string
    field :seq, :float, default: 0.0
    field :url_path, :string

    belongs_to :issue, SimpleJournalSystem.Issues.Issue,
      foreign_key: :issue_id,
      references: :issue_id
  end

  def changeset(galley, attrs) do
    galley
    |> cast(attrs, [
      :issue_id,
      :file_id,
      :locale,
      :label,
      :seq,
      :url_path
    ])
    |> validate_required([:issue_id, :file_id, :seq])
    |> validate_length(:locale, max: 28)
    |> validate_length(:label, max: 255)
    |> validate_length(:url_path, max: 64)
  end
end
