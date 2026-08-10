defmodule SimpleJournalSystem.Journals do
  import Ecto.Query, warn: false

  alias SimpleJournalSystem.Repo
  alias SimpleJournalSystem.Journals.Journal

  def list_journals do
    Repo.all(Journal)
  end

  def get_journal!(id) do
    Repo.get!(Journal, id)
  end
end
