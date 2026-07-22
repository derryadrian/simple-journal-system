defmodule SimpleJournalSystem.SubmissionsTest do
  use SimpleJournalSystem.DataCase

  alias SimpleJournalSystem.Submissions

  describe "submissions" do
    alias SimpleJournalSystem.Submissions.Submission

    import SimpleJournalSystem.SubmissionsFixtures

    @invalid_attrs %{status: nil, title: nil, abstract: nil, journal_id: nil}

    test "list_submissions/0 returns all submissions" do
      submission = submission_fixture()
      assert Submissions.list_submissions() == [submission]
    end

    test "get_submission!/1 returns the submission with given id" do
      submission = submission_fixture()
      assert Submissions.get_submission!(submission.id) == submission
    end

    test "create_submission/1 with valid data creates a submission" do
      valid_attrs = %{status: 42, title: "some title", abstract: "some abstract", journal_id: 42}

      assert {:ok, %Submission{} = submission} = Submissions.create_submission(valid_attrs)
      assert submission.status == 42
      assert submission.title == "some title"
      assert submission.abstract == "some abstract"
      assert submission.journal_id == 42
    end

    test "create_submission/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Submissions.create_submission(@invalid_attrs)
    end

    test "update_submission/2 with valid data updates the submission" do
      submission = submission_fixture()
      update_attrs = %{status: 43, title: "some updated title", abstract: "some updated abstract", journal_id: 43}

      assert {:ok, %Submission{} = submission} = Submissions.update_submission(submission, update_attrs)
      assert submission.status == 43
      assert submission.title == "some updated title"
      assert submission.abstract == "some updated abstract"
      assert submission.journal_id == 43
    end

    test "update_submission/2 with invalid data returns error changeset" do
      submission = submission_fixture()
      assert {:error, %Ecto.Changeset{}} = Submissions.update_submission(submission, @invalid_attrs)
      assert submission == Submissions.get_submission!(submission.id)
    end

    test "delete_submission/1 deletes the submission" do
      submission = submission_fixture()
      assert {:ok, %Submission{}} = Submissions.delete_submission(submission)
      assert_raise Ecto.NoResultsError, fn -> Submissions.get_submission!(submission.id) end
    end

    test "change_submission/1 returns a submission changeset" do
      submission = submission_fixture()
      assert %Ecto.Changeset{} = Submissions.change_submission(submission)
    end
  end
end
