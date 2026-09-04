defmodule SimpleJournalSystem.Issues.Issue do
  use Ecto.Schema
  import Ecto.Changeset

  alias SimpleJournalSystem.Repo

  @primary_key {:issue_id, :id, autogenerate: false}
  @derive {Phoenix.Param, key: :issue_id}

  schema "issues" do
    field :journal_id, :integer
    field :volume, :integer
    field :number, :string
    field :year, :integer
    field :published, :integer
    field :date_published, :naive_datetime
    field :date_notified, :naive_datetime
    field :last_modified, :naive_datetime
    field :access_status, :integer
    field :open_access_date, :naive_datetime
    field :show_volume, :integer
    field :show_number, :integer
    field :show_year, :integer
    field :show_title, :integer
    field :style_file_name, :string
    field :original_style_file_name, :string
    field :url_path, :string
    field :doi_id, :integer
  end

  @doc false
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
    |> validate_number(:journal_id, greater_than: 0)
  end

  @doc false
  def create_changeset(issue, attrs) do
    issue
    |> changeset(attrs)
    |> put_issue_id()
  end

  defp put_issue_id(changeset) do
    case changeset.valid? do
      true ->
        max_id = Repo.aggregate(__MODULE__, :max, :issue_id) || 0
        change(changeset, issue_id: max_id + 1)

      false ->
        changeset
    end
  end
end
