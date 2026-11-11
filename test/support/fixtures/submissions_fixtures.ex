defmodule SimpleJournalSystem.SubmissionsFixtures do
  @moduledoc """
  Fungsi bantu untuk membuat naskah di test.
  """

  @doc """
  Membuat naskah baru. Bawaannya untuk journal 1 (stage 1, status queued).
  """
  def submission_fixture(attrs \\ %{}) do
    {:ok, submission} =
      attrs
      |> Enum.into(%{context_id: 1, locale: "en"})
      |> SimpleJournalSystem.Submissions.create_submission()

    submission
  end
end
