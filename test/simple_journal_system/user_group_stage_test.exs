defmodule SimpleJournalSystem.Accounts.UserGroupStageTest do
  use SimpleJournalSystem.DataCase, async: true

  alias SimpleJournalSystem.Accounts.UserGroupStage

  describe "changeset/2" do
    test "menerima user group stage dengan data valid" do
      changeset =
        UserGroupStage.changeset(%UserGroupStage{}, %{
          context_id: 1,
          user_group_id: 16,
          stage_id: 3
        })

      assert changeset.valid?
    end

    test "menolak data tanpa context_id" do
      changeset =
        UserGroupStage.changeset(%UserGroupStage{}, %{
          user_group_id: 16,
          stage_id: 3
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).context_id
    end

    test "menolak data tanpa user_group_id" do
      changeset =
        UserGroupStage.changeset(%UserGroupStage{}, %{
          context_id: 1,
          stage_id: 3
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).user_group_id
    end

    test "menolak data tanpa stage_id" do
      changeset =
        UserGroupStage.changeset(%UserGroupStage{}, %{
          context_id: 1,
          user_group_id: 16
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).stage_id
    end
  end
end
