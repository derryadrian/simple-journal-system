defmodule SimpleJournalSystem.Issues.Issue do
  @moduledoc """
  Edisi terbitan jurnal.
  Sama dengan tabel `issues` di OJS 3.5.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:issue_id, :id, autogenerate: true}
  @derive {Phoenix.Param, key: :issue_id}

  schema "issues" do
    field :volume, :integer
    field :number, :string
    field :year, :integer
    field :published, :integer, default: 0
    field :date_published, :naive_datetime
    field :date_notified, :naive_datetime
    field :last_modified, :naive_datetime
    field :access_status, :integer, default: 1
    field :open_access_date, :naive_datetime
    field :show_volume, :integer, default: 0
    field :show_number, :integer, default: 0
    field :show_year, :integer, default: 0
    field :show_title, :integer, default: 0
    field :style_file_name, :string
    field :original_style_file_name, :string
    field :url_path, :string
    field :doi_id, :integer

    belongs_to :journal, SimpleJournalSystem.Journals.Journal,
      foreign_key: :journal_id,
      references: :journal_id
  end

  def changeset(issue, attrs) do
    issue
    |> cast(attrs, [
      :journal_id,
      :volume,
      :number,
      :year,
      :published,
      :date_published,
      :date_notified,
      :last_modified,
      :access_status,
      :open_access_date,
      :show_volume,
      :show_number,
      :show_year,
      :show_title,
      :style_file_name,
      :original_style_file_name,
      :url_path,
      :doi_id
    ])
    |> validate_required([
      :journal_id,
      :published,
      :access_status,
      :show_volume,
      :show_number,
      :show_year,
      :show_title
    ])
    |> validate_length(:number, max: 40)
    |> validate_length(:style_file_name, max: 90)
    |> validate_length(:original_style_file_name, max: 255)
    |> validate_length(:url_path, max: 64)
  end
end
