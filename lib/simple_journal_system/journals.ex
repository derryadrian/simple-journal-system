defmodule SimpleJournalSystem.Journals do
  @moduledoc """
  The Journals context.
  """

  import Ecto.Query, warn: false
  alias SimpleJournalSystem.Repo

  alias SimpleJournalSystem.Journals.Journal

  @doc """
  Returns the list of journals.
  """
  def list_journals do
    Repo.all(Journal)
  end

  @doc """
  Gets a single journal.
  """
  def get_journal!(id), do: Repo.get!(Journal, id)

  @doc """
  Gets a journal by path.
  """
  def get_journal_by_path(path) do
    Repo.one(from j in Journal, where: j.path == ^path)
  end

  @doc """
  Gets the enabled journals.
  """
  def list_enabled_journals do
    Repo.all(from j in Journal, where: j.enabled == 1, order_by: j.seq)
  end

  @doc """
  Creates a journal.
  """
  def create_journal(attrs) do
    %Journal{}
    |> Journal.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a journal.
  """
  def update_journal(%Journal{} = journal, attrs) do
    journal
    |> Journal.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a journal.
  """
  def delete_journal(%Journal{} = journal) do
    Repo.delete(journal)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking journal changes.
  """
  def change_journal(%Journal{} = journal, attrs \\ %{}) do
    Journal.changeset(journal, attrs)
  end
end