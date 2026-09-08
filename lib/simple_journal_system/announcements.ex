defmodule SimpleJournalSystem.Announcements do
  @moduledoc """
  The Announcements context.
  """

  import Ecto.Query, warn: false
  alias SimpleJournalSystem.Repo

  alias SimpleJournalSystem.Announcements.Announcement

  @doc """
  Returns the list of announcements.
  """
  def list_announcements do
    Repo.all(Announcement)
  end

  @doc """
  Gets a single announcement.
  """
  def get_announcement!(id), do: Repo.get!(Announcement, id)

  @doc """
  Creates an announcement.
  """
  def create_announcement(attrs) do
    %Announcement{}
    |> Announcement.create_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates an announcement.
  """
  def update_announcement(%Announcement{} = announcement, attrs) do
    announcement
    |> Announcement.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes an announcement.
  """
  def delete_announcement(%Announcement{} = announcement) do
    Repo.delete(announcement)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking announcement changes.
  """
  def change_announcement(%Announcement{} = announcement, attrs \\ %{}) do
    Announcement.changeset(announcement, attrs)
  end
end
