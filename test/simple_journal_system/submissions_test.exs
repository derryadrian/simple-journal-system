defmodule SimpleJournalSystem.SubmissionsTest do
  use SimpleJournalSystem.DataCase, async: true

  import SimpleJournalSystem.SubmissionsFixtures

  alias SimpleJournalSystem.Ojs.SubmissionStatus
  alias SimpleJournalSystem.Submissions
  alias SimpleJournalSystem.Submissions.Submission

  describe "create_submission/1" do
    test "naskah baru mulai di stage 1, status queued, progress start" do
      assert {:ok, %Submission{} = submission} =
               Submissions.create_submission(%{context_id: 1, locale: "en"})

      assert submission.context_id == 1
      assert submission.stage_id == 1
      assert submission.status == SubmissionStatus.queued()
      assert submission.submission_progress == "start"
      assert submission.date_submitted == nil
      assert submission.date_last_activity
    end

    test "context_id wajib diisi" do
      assert {:error, changeset} = Submissions.create_submission(%{locale: "en"})
      assert "can't be blank" in errors_on(changeset).context_id
    end

    test "stage_id yang tidak dikenal ditolak" do
      assert {:error, changeset} =
               Submissions.create_submission(%{context_id: 1, stage_id: 99})

      assert errors_on(changeset).stage_id != []
    end

    test "status yang tidak dikenal ditolak" do
      assert {:error, changeset} =
               Submissions.create_submission(%{context_id: 1, status: 2})

      assert errors_on(changeset).status != []
    end
  end

  describe "list_submissions_for_context/1 dan get_submission!/1" do
    test "hanya mengembalikan naskah milik jurnal itu" do
      mine = submission_fixture(%{context_id: 1})
      _other = submission_fixture(%{context_id: 2})

      ids = Enum.map(Submissions.list_submissions_for_context(1), & &1.submission_id)
      assert mine.submission_id in ids
      refute Enum.any?(Submissions.list_submissions_for_context(1), &(&1.context_id == 2))
    end

    test "get_submission!/1 mengambil berdasarkan submission_id" do
      submission = submission_fixture()

      assert Submissions.get_submission!(submission.submission_id).submission_id ==
               submission.submission_id
    end
  end

  describe "submit_submission/1" do
    test "mengisi date_submitted dan mengosongkan submission_progress" do
      submission = submission_fixture()

      assert {:ok, submitted} = Submissions.submit_submission(submission)
      assert submitted.date_submitted
      assert submitted.submission_progress == ""

      reloaded = Submissions.get_submission!(submission.submission_id)
      assert reloaded.submission_progress == ""
      assert reloaded.date_submitted
    end
  end
end
