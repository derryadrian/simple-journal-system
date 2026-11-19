defmodule SimpleJournalSystem.Issues.IssueTest do
  use SimpleJournalSystem.DataCase, async: true

  alias SimpleJournalSystem.Issues.Issue

  describe "changeset/2" do
    test "menerima issue dengan data valid" do
      changeset =
        Issue.changeset(%Issue{}, %{
          journal_id: 1,
          volume: 1,
          number: "1",
          year: 2026,
          published: 0,
          access_status: 1,
          show_volume: 1,
          show_number: 1,
          show_year: 1,
          show_title: 1
        })

      assert changeset.valid?
    end

    test "menolak issue tanpa journal_id" do
      changeset =
        Issue.changeset(%Issue{}, %{
          published: 0,
          access_status: 1,
          show_volume: 0,
          show_number: 0,
          show_year: 0,
          show_title: 0
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).journal_id
    end

    test "memiliki default value sesuai database" do
      issue = %Issue{}

      assert issue.published == 0
      assert issue.access_status == 1
      assert issue.show_volume == 0
      assert issue.show_number == 0
      assert issue.show_year == 0
      assert issue.show_title == 0
    end

    test "mengizinkan metadata opsional bernilai nil" do
      changeset =
        Issue.changeset(%Issue{}, %{
          journal_id: 1,
          published: 0,
          access_status: 1,
          show_volume: 0,
          show_number: 0,
          show_year: 0,
          show_title: 0,
          date_published: nil,
          doi_id: nil,
          url_path: nil
        })

      assert changeset.valid?
    end
  end
end
