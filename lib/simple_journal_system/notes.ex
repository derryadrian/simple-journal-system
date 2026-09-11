defmodule SimpleJournalSystem.Notes do
  @moduledoc """
  The Notes context.
  """

  import Ecto.Query, warn: false
  alias SimpleJournalSystem.Repo

  alias SimpleJournalSystem.Notes.Note

  def list_notes do
    Repo.all(Note)
  end

  def get_note!(id), do: Repo.get!(Note, id)

  def create_note(attrs) do
    %Note{}
    |> Note.create_changeset(attrs)
    |> Repo.insert()
  end

  def update_note(%Note{} = note, attrs) do
    note
    |> Note.changeset(attrs)
    |> Repo.update()
  end

  def delete_note(%Note{} = note) do
    Repo.delete(note)
  end

  def change_note(%Note{} = note, attrs \\ %{}) do
    Note.changeset(note, attrs)
  end
end
