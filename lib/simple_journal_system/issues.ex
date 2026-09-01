defmodule SimpleJournalSystem.Issues do
  @moduledoc """
  The Issues context.
  """

  import Ecto.Query, warn: false
  alias SimpleJournalSystem.Repo

  alias SimpleJournalSystem.Issues.Issue

  @doc """
  Returns the list of issues.
  """
  def list_issues do
    Repo.all(Issue)
  end

  @doc """
  Gets a single issue.
  """
  def get_issue!(id), do: Repo.get!(Issue, id)

  @doc """
  Creates an issue.
  """
  def create_issue(attrs) do
    %Issue{}
    |> Issue.create_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates an issue.
  """
  def update_issue(%Issue{} = issue, attrs) do
    issue
    |> Issue.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes an issue.
  """
  def delete_issue(%Issue{} = issue) do
    Repo.delete(issue)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking issue changes.
  """
  def change_issue(%Issue{} = issue, attrs \\ %{}) do
    Issue.changeset(issue, attrs)
  end
end
