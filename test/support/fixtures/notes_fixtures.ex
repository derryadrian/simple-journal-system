defmodule SimpleJournalSystem.NotesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SimpleJournalSystem.Notes` context.
  """

  def note_fixture(attrs \\ %{}) do
    {:ok, note} =
      attrs
      |> Enum.into(%{
        assoc_type: 1,
        assoc_id: 1,
        user_id: 1,
        date_created: ~N[2024-01-01 00:00:00],
        title: "some title",
        contents: "some contents"
      })
      |> SimpleJournalSystem.Notes.create_note()

    note
  end
end
