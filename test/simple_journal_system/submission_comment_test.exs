defmodule SimpleJournalSystem.Submissions.SubmissionCommentTest do
  use SimpleJournalSystem.DataCase, async: true

  alias SimpleJournalSystem.Submissions.SubmissionComment

  describe "changeset/2" do
    test "menerima komentar submission dengan data valid" do
      changeset =
        SubmissionComment.changeset(%SubmissionComment{}, %{
          role_id: 16,
          submission_id: 1,
          assoc_id: 1,
          author_id: 1,
          comment_title: "Revisi naskah"
        })

      assert changeset.valid?
    end

    test "menolak komentar tanpa role_id" do
      changeset =
        SubmissionComment.changeset(%SubmissionComment{}, %{
          submission_id: 1,
          assoc_id: 1,
          author_id: 1,
          comment_title: "Revisi naskah"
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).role_id
    end

    test "menolak komentar tanpa submission_id" do
      changeset =
        SubmissionComment.changeset(%SubmissionComment{}, %{
          role_id: 16,
          assoc_id: 1,
          author_id: 1,
          comment_title: "Revisi naskah"
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).submission_id
    end

    test "menolak komentar tanpa assoc_id" do
      changeset =
        SubmissionComment.changeset(%SubmissionComment{}, %{
          role_id: 16,
          submission_id: 1,
          author_id: 1,
          comment_title: "Revisi naskah"
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).assoc_id
    end

    test "menolak komentar tanpa author_id" do
      changeset =
        SubmissionComment.changeset(%SubmissionComment{}, %{
          role_id: 16,
          submission_id: 1,
          assoc_id: 1,
          comment_title: "Revisi naskah"
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).author_id
    end

    test "menolak komentar tanpa comment_title" do
      changeset =
        SubmissionComment.changeset(%SubmissionComment{}, %{
          role_id: 16,
          submission_id: 1,
          assoc_id: 1,
          author_id: 1
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).comment_title
    end

    test "mengizinkan comments bernilai nil" do
      changeset =
        SubmissionComment.changeset(%SubmissionComment{}, %{
          role_id: 16,
          submission_id: 1,
          assoc_id: 1,
          author_id: 1,
          comment_title: "Catatan",
          comments: nil
        })

      assert changeset.valid?
    end
  end
end
