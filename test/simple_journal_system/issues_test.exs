defmodule SimpleJournalSystem.IssuesTest do
  use SimpleJournalSystem.DataCase

  alias SimpleJournalSystem.Issues

  describe "issues" do
    alias SimpleJournalSystem.Issues.Issue

    import SimpleJournalSystem.IssuesFixtures

    @invalid_attrs %{journal_id: nil}

    test "list_issues/0 returns all issues" do
      issue = issue_fixture()
      assert Issues.list_issues() == [issue]
    end

    test "get_issue!/1 returns the issue with given id" do
      issue = issue_fixture()
      assert Issues.get_issue!(issue.issue_id) == issue
    end

    test "create_issue/1 with valid data creates an issue" do
      valid_attrs = %{
        journal_id: 1,
        volume: 1,
        number: "1",
        year: 2024,
        published: 0,
        access_status: 0,
        show_volume: 1,
        show_number: 1,
        show_year: 1,
        show_title: 1
      }

      assert {:ok, %Issue{} = issue} = Issues.create_issue(valid_attrs)
      assert issue.journal_id == 1
      assert issue.volume == 1
      assert issue.number == "1"
      assert issue.year == 2024
      assert issue.published == 0
      assert issue.access_status == 0
      assert issue.show_volume == 1
      assert issue.show_number == 1
      assert issue.show_year == 1
      assert issue.show_title == 1
    end

    test "create_issue/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Issues.create_issue(@invalid_attrs)
    end

    test "update_issue/2 with valid data updates the issue" do
      issue = issue_fixture()
      update_attrs = %{number: "2", year: 2025}

      assert {:ok, %Issue{} = issue} = Issues.update_issue(issue, update_attrs)
      assert issue.number == "2"
      assert issue.year == 2025
    end

    test "update_issue/2 with invalid data returns error changeset" do
      issue = issue_fixture()
      assert {:error, %Ecto.Changeset{}} = Issues.update_issue(issue, @invalid_attrs)
    end

    test "update_issue/2 does not change issue_id" do
      issue = issue_fixture()
      original_issue_id = issue.issue_id

      assert {:ok, updated_issue} = Issues.update_issue(issue, %{number: "2", year: 2025})
      assert updated_issue.issue_id == original_issue_id
    end

    test "delete_issue/1 deletes the issue" do
      issue = issue_fixture()
      assert {:ok, %Issue{}} = Issues.delete_issue(issue)
      assert_raise Ecto.NoResultsError, fn -> Issues.get_issue!(issue.issue_id) end
    end

    test "change_issue/1 returns an issue changeset" do
      issue = issue_fixture()
      assert %Ecto.Changeset{} = Issues.change_issue(issue)
    end
  end
end
