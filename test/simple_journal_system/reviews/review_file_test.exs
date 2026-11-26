defmodule SimpleJournalSystem.Reviews.ReviewFileTest do
  use SimpleJournalSystem.DataCase, async: true

  alias SimpleJournalSystem.Reviews.ReviewFile

  describe "changeset/2" do
    test "valid dengan atribut wajib" do
      changeset =
        ReviewFile.changeset(%ReviewFile{}, %{
          review_id: 1,
          submission_file_id: 1
        })

      assert changeset.valid?
    end

    test "menolak review_id kosong" do
      changeset =
        ReviewFile.changeset(%ReviewFile{}, %{
          submission_file_id: 1
        })

      refute changeset.valid?
      assert %{review_id: [_]} = errors_on(changeset)
    end

    test "menolak submission_file_id kosong" do
      changeset =
        ReviewFile.changeset(%ReviewFile{}, %{
          review_id: 1
        })

      refute changeset.valid?
      assert %{submission_file_id: [_]} = errors_on(changeset)
    end

    test "menolak ID nol atau negatif" do
      for {field, value} <- [
            {:review_id, 0},
            {:review_id, -1},
            {:submission_file_id, 0},
            {:submission_file_id, -1}
          ] do
        attrs =
          Map.put(
            %{
              review_id: 1,
              submission_file_id: 1
            },
            field,
            value
          )

        changeset = ReviewFile.changeset(%ReviewFile{}, attrs)

        refute changeset.valid?
      end
    end

    test "mendaftarkan unique constraint dengan nama yang benar" do
      changeset =
        ReviewFile.changeset(%ReviewFile{}, %{
          review_id: 1,
          submission_file_id: 1
        })

      assert Enum.any?(
               changeset.constraints,
               &(&1.constraint == "review_files_unique")
             )
    end
  end
end
