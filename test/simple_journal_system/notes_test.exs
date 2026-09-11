defmodule SimpleJournalSystem.NotesTest do
  use SimpleJournalSystem.DataCase

  alias SimpleJournalSystem.Notes

  describe "notes" do
    alias SimpleJournalSystem.Notes.Note

    import SimpleJournalSystem.NotesFixtures

    @invalid_attrs %{assoc_type: nil, assoc_id: nil, user_id: nil, date_created: nil}

    test "list_notes/0 returns all notes" do
      note = note_fixture()
      assert Notes.list_notes() == [note]
    end

    test "get_note!/1 returns the note with given id" do
      note = note_fixture()
      assert Notes.get_note!(note.note_id) == note
    end

    test "create_note/1 with valid data creates a note" do
      valid_attrs = %{
        assoc_type: 1,
        assoc_id: 1,
        user_id: 1,
        date_created: ~N[2024-01-01 00:00:00],
        title: "some title",
        contents: "some contents"
      }

      assert {:ok, %Note{} = note} = Notes.create_note(valid_attrs)
      assert note.assoc_type == 1
      assert note.assoc_id == 1
      assert note.user_id == 1
      assert note.date_created == ~N[2024-01-01 00:00:00]
      assert note.title == "some title"
      assert note.contents == "some contents"
    end

    test "create_note/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Notes.create_note(@invalid_attrs)
    end

    test "update_note/2 with valid data updates the note" do
      note = note_fixture()
      update_attrs = %{title: "updated title"}

      assert {:ok, %Note{} = note} = Notes.update_note(note, update_attrs)
      assert note.title == "updated title"
    end

    test "update_note/2 with invalid data returns error changeset" do
      note = note_fixture()
      assert {:error, %Ecto.Changeset{}} = Notes.update_note(note, @invalid_attrs)
    end

    test "update_note/2 does not change note_id" do
      note = note_fixture()
      original_note_id = note.note_id

      assert {:ok, updated_note} = Notes.update_note(note, %{title: "updated title"})
      assert updated_note.note_id == original_note_id
    end

    test "delete_note/1 deletes the note" do
      note = note_fixture()
      assert {:ok, %Note{}} = Notes.delete_note(note)
      assert_raise Ecto.NoResultsError, fn -> Notes.get_note!(note.note_id) end
    end

    test "change_note/1 returns a note changeset" do
      note = note_fixture()
      assert %Ecto.Changeset{} = Notes.change_note(note)
    end
  end
end
