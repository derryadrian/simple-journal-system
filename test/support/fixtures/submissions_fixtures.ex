defmodule SimpleJournalSystem.SubmissionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SimpleJournalSystem.Submissions` context.
  """

  @doc """
  Generate a submission.
  """
  def submission_fixture(attrs \\ %{}) do
    {:ok, submission} =
      attrs
      |> Enum.into(%{
        abstract: "some abstract",
        journal_id: 42,
        status: 42,
        title: "some title"
      })
      |> SimpleJournalSystem.Submissions.create_submission()

    submission
  end
end
