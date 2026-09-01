defmodule SimpleJournalSystem.IssuesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SimpleJournalSystem.Issues` context.
  """

  @doc """
  Generate an issue.
  """
  def issue_fixture(attrs \\ %{}) do
    {:ok, issue} =
      attrs
      |> Enum.into(%{
        journal_id: 1,
        volume: 1,
        number: "1",
        year: 2024,
        published: 0,
        access_status: 0,
        show_volume: 1,
        show_number: 1,
        show_year: 1,
        show_title: 1
      })
      |> SimpleJournalSystem.Issues.create_issue()

    issue
  end
end
