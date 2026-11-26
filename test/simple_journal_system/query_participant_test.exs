defmodule SimpleJournalSystem.Submissions.QueryParticipantTest do
  use SimpleJournalSystem.DataCase, async: true

  alias SimpleJournalSystem.Submissions.QueryParticipant

  describe "changeset/2" do
    test "menerima query participant dengan data valid" do
      changeset =
        QueryParticipant.changeset(%QueryParticipant{}, %{
          query_id: 1,
          user_id: 1
        })

      assert changeset.valid?
    end

    test "menolak data tanpa query_id" do
      changeset =
        QueryParticipant.changeset(%QueryParticipant{}, %{
          user_id: 1
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).query_id
    end

    test "menolak data tanpa user_id" do
      changeset =
        QueryParticipant.changeset(%QueryParticipant{}, %{
          query_id: 1
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).user_id
    end
  end
end
