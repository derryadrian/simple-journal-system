defmodule SimpleJournalSystem.Issues.IssueGalleyTest do
  use SimpleJournalSystem.DataCase, async: true

  alias SimpleJournalSystem.Issues.IssueGalley

  describe "changeset/2" do
    test "menerima galley dengan data valid" do
      changeset =
        IssueGalley.changeset(%IssueGalley{}, %{
          issue_id: 1,
          file_id: 1,
          locale: "id",
          label: "PDF",
          seq: 1.0,
          url_path: "edisi-pertama"
        })

      assert changeset.valid?
    end

    test "menolak galley tanpa issue_id" do
      changeset =
        IssueGalley.changeset(%IssueGalley{}, %{
          file_id: 1,
          seq: 0.0
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).issue_id
    end

    test "menolak galley tanpa file_id" do
      changeset =
        IssueGalley.changeset(%IssueGalley{}, %{
          issue_id: 1,
          seq: 0.0
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).file_id
    end

    test "default seq adalah 0.0" do
      galley = %IssueGalley{}

      assert galley.seq == 0.0
    end

    test "mengizinkan metadata opsional bernilai nil" do
      changeset =
        IssueGalley.changeset(%IssueGalley{}, %{
          issue_id: 1,
          file_id: 1,
          seq: 0.0,
          locale: nil,
          label: nil,
          url_path: nil
        })

      assert changeset.valid?
    end
  end
end
