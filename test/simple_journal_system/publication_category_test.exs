defmodule SimpleJournalSystem.PublicationCategoryTest do
  use SimpleJournalSystem.DataCase, async: true

  alias SimpleJournalSystem.Submissions.PublicationCategory

  describe "changeset/2" do
    test "menerima relasi publikasi dan kategori yang valid" do
      changeset =
        PublicationCategory.changeset(%PublicationCategory{}, %{
          publication_id: 1,
          category_id: 1
        })

      assert changeset.valid?
    end

    test "menolak relasi tanpa publication_id" do
      changeset =
        PublicationCategory.changeset(%PublicationCategory{}, %{
          category_id: 1
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).publication_id
    end

    test "menolak relasi tanpa category_id" do
      changeset =
        PublicationCategory.changeset(%PublicationCategory{}, %{
          publication_id: 1
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).category_id
    end
  end
end
