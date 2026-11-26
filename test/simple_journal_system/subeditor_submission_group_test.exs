defmodule SimpleJournalSystem.Submissions.SubeditorSubmissionGroupTest do
  use SimpleJournalSystem.DataCase, async: true

  alias SimpleJournalSystem.Submissions.SubeditorSubmissionGroup

  describe "changeset/2" do
    test "menerima data subeditor submission group yang valid" do
      changeset =
        SubeditorSubmissionGroup.changeset(%SubeditorSubmissionGroup{}, %{
          context_id: 1,
          assoc_id: 1,
          assoc_type: 515,
          user_id: 1,
          user_group_id: 17
        })

      assert changeset.valid?
    end

    test "menolak data tanpa context_id" do
      changeset =
        SubeditorSubmissionGroup.changeset(%SubeditorSubmissionGroup{}, %{
          assoc_id: 1,
          assoc_type: 515,
          user_id: 1,
          user_group_id: 17
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).context_id
    end

    test "menolak data tanpa assoc_id" do
      changeset =
        SubeditorSubmissionGroup.changeset(%SubeditorSubmissionGroup{}, %{
          context_id: 1,
          assoc_type: 515,
          user_id: 1,
          user_group_id: 17
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).assoc_id
    end

    test "menolak data tanpa assoc_type" do
      changeset =
        SubeditorSubmissionGroup.changeset(%SubeditorSubmissionGroup{}, %{
          context_id: 1,
          assoc_id: 1,
          user_id: 1,
          user_group_id: 17
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).assoc_type
    end

    test "menolak data tanpa user_id" do
      changeset =
        SubeditorSubmissionGroup.changeset(%SubeditorSubmissionGroup{}, %{
          context_id: 1,
          assoc_id: 1,
          assoc_type: 515,
          user_group_id: 17
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).user_id
    end

    test "menolak data tanpa user_group_id" do
      changeset =
        SubeditorSubmissionGroup.changeset(%SubeditorSubmissionGroup{}, %{
          context_id: 1,
          assoc_id: 1,
          assoc_type: 515,
          user_id: 1
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).user_group_id
    end
  end
end
