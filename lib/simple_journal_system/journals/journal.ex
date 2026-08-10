defmodule SimpleJournalSystem.Journals.Journal do
  use Ecto.Schema

  @primary_key {:journal_id, :id, autogenerate: false}

  schema "journals" do
    field :path, :string
    field :seq, :float
    field :primary_locale, :string
    field :enabled, :integer
    field :current_issue_id, :id
  end
end
