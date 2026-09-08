defmodule SimpleJournalSystem.AnnouncementsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SimpleJournalSystem.Announcements` context.
  """

  @doc """
  Generate an announcement.
  """
  def announcement_fixture(attrs \\ %{}) do
    {:ok, announcement} =
      attrs
      |> Enum.into(%{
        assoc_type: 1,
        assoc_id: 1,
        type_id: 1,
        date_expire: ~D[2024-12-31],
        date_posted: ~N[2024-01-01 00:00:00]
      })
      |> SimpleJournalSystem.Announcements.create_announcement()

    announcement
  end
end
