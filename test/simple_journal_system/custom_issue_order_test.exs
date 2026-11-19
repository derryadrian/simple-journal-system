defmodule SimpleJournalSystem.Issues.CustomIssueOrderTest do
  use SimpleJournalSystem.DataCase, async: true

  alias SimpleJournalSystem.Issues.CustomIssueOrder

  describe "changeset/2" do
    test "menerima custom issue order dengan data valid" do
      changeset =
        CustomIssueOrder.changeset(%CustomIssueOrder{}, %{
          issue_id: 1,
          journal_id: 1,
          seq: 1.0
        })

      assert changeset.valid?
    end

    test "menolak data tanpa issue_id" do
      changeset =
        CustomIssueOrder.changeset(%CustomIssueOrder{}, %{
          journal_id: 1,
          seq: 1.0
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).issue_id
    end

    test "menolak data tanpa journal_id" do
      changeset =
        CustomIssueOrder.changeset(%CustomIssueOrder{}, %{
          issue_id: 1,
          seq: 1.0
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).journal_id
    end

    test "default seq adalah 0.0" do
      custom_issue_order = %CustomIssueOrder{}

      assert custom_issue_order.seq == 0.0
    end
  end
end
