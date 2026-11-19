defmodule SimpleJournalSystem.Issues.IssueFile do
  @moduledoc """
  File yang terkait dengan sebuah issue jurnal.
  Sama dengan tabel `issue_files` di OJS 3.5.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:file_id, :id, autogenerate: true}
  @derive {Phoenix.Param, key: :file_id}

  schema "issue_files" do
    field :file_name, :string
    field :file_type, :string
    field :file_size, :integer
    field :content_type, :integer
    field :original_file_name, :string
    field :date_uploaded, :naive_datetime
    field :date_modified, :naive_datetime

    belongs_to :issue, SimpleJournalSystem.Issues.Issue,
      foreign_key: :issue_id,
      references: :issue_id
  end

  def changeset(issue_file, attrs) do
    issue_file
    |> cast(attrs, [
      :issue_id,
      :file_name,
      :file_type,
      :file_size,
      :content_type,
      :original_file_name,
      :date_uploaded,
      :date_modified
    ])
    |> validate_required([
      :issue_id,
      :file_name,
      :file_type,
      :file_size,
      :content_type,
      :date_uploaded,
      :date_modified
    ])
    |> validate_length(:file_name, max: 90)
    |> validate_length(:file_type, max: 255)
    |> validate_length(:original_file_name, max: 127)
    |> validate_number(:file_size, greater_than_or_equal_to: 0)
  end
end
