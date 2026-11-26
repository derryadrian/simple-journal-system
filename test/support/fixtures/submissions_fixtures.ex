
defmodule SimpleJournalSystem.SubmissionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the SimpleJournalSystem.Submissions context.
  """

  def submission_fixture(attrs \\ %{}) do
    {:ok, submission} =
      attrs
      |> Enum.into(%{
        context_id: 1,
        stage_id: 1,
        status: 1,
        locale: "en",
        submission_progress: "start",
        work_type: 1
      })
      |> SimpleJournalSystem.Submissions.create_submission()

    submission
  end
end
