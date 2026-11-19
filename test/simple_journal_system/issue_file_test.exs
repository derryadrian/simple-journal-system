defmodule SimpleJournalSystem.Issues.IssueFileTest do
  use SimpleJournalSystem.DataCase, async: true

  alias SimpleJournalSystem.Issues.IssueFile

  describe "changeset/2" do
    test "menerima issue file dengan data valid" do
      changeset =
        IssueFile.changeset(%IssueFile{}, %{
          issue_id: 1,
          file_name: "cover.jpg",
          file_type: "image/jpeg",
          file_size: 1024,
          content_type: 1,
          original_file_name: "cover-original.jpg",
          date_uploaded: ~N[2026-11-19 10:00:00],
          date_modified: ~N[2026-11-19 10:00:00]
        })

      assert changeset.valid?
    end

    test "menolak issue file tanpa issue_id" do
      changeset =
        IssueFile.changeset(%IssueFile{}, %{
          file_name: "cover.jpg",
          file_type: "image/jpeg",
          file_size: 1024,
          content_type: 1,
          date_uploaded: ~N[2026-11-19 10:00:00],
          date_modified: ~N[2026-11-19 10:00:00]
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).issue_id
    end

    test "menolak file_size negatif" do
      changeset =
        IssueFile.changeset(%IssueFile{}, %{
          issue_id: 1,
          file_name: "cover.jpg",
          file_type: "image/jpeg",
          file_size: -1,
          content_type: 1,
          date_uploaded: ~N[2026-11-19 10:00:00],
          date_modified: ~N[2026-11-19 10:00:00]
        })

      refute changeset.valid?
      assert "must be greater than or equal to 0" in errors_on(changeset).file_size
    end

    test "mengizinkan original_file_name bernilai nil" do
      changeset =
        IssueFile.changeset(%IssueFile{}, %{
          issue_id: 1,
          file_name: "cover.jpg",
          file_type: "image/jpeg",
          file_size: 1024,
          content_type: 1,
          original_file_name: nil,
          date_uploaded: ~N[2026-11-19 10:00:00],
          date_modified: ~N[2026-11-19 10:00:00]
        })

      assert changeset.valid?
    end
  end
end
