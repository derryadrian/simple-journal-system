defmodule SimpleJournalSystem.PublicationGalleyTest do
  use SimpleJournalSystem.DataCase, async: true

  alias SimpleJournalSystem.Submissions.PublicationGalley

  describe "changeset/2" do
    test "menerima galley dengan data valid" do
      changeset =
        PublicationGalley.changeset(%PublicationGalley{}, %{
          publication_id: 1,
          locale: "id",
          label: "PDF",
          seq: 1.0,
          is_approved: 0
        })

      assert changeset.valid?
    end

    test "menolak galley tanpa publication_id" do
      changeset =
        PublicationGalley.changeset(%PublicationGalley{}, %{
          seq: 1.0,
          is_approved: 0
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).publication_id
    end

    test "default seq dan is_approved" do
      galley = %PublicationGalley{}

      assert galley.seq == 0.0
      assert galley.is_approved == 0
    end

    test "mengizinkan submission_file_id dan remote_url bernilai nil" do
      changeset =
        PublicationGalley.changeset(%PublicationGalley{}, %{
          publication_id: 1,
          seq: 0.0,
          is_approved: 0,
          submission_file_id: nil,
          remote_url: nil
        })

      assert changeset.valid?
    end
  end
end
