defmodule SimpleJournalSystem.Reviews.ReviewRoundFileTest do
  use SimpleJournalSystem.DataCase, async: true

  alias SimpleJournalSystem.Reviews.ReviewRoundFile

  describe "changeset/2" do
    test "valid dengan seluruh atribut wajib" do
      changeset =
        ReviewRoundFile.changeset(%ReviewRoundFile{}, %{
          submission_id: 1,
          review_round_id: 1,
          stage_id: 3,
          submission_file_id: 1
        })

      assert changeset.valid?
    end

    test "menolak setiap atribut wajib yang kosong" do
      attrs = %{
        submission_id: 1,
        review_round_id: 1,
        stage_id: 3,
        submission_file_id: 1
      }

      for field <- Map.keys(attrs) do
        changeset =
          ReviewRoundFile.changeset(
            %ReviewRoundFile{},
            Map.delete(attrs, field)
          )

        refute changeset.valid?
        assert Map.has_key?(errors_on(changeset), field)
      end
    end

    test "menolak ID nol atau negatif" do
      attrs = %{
        submission_id: 1,
        review_round_id: 1,
        stage_id: 3,
        submission_file_id: 1
      }

      for field <- Map.keys(attrs), value <- [0, -1] do
        changeset =
          ReviewRoundFile.changeset(
            %ReviewRoundFile{},
            Map.put(attrs, field, value)
          )

        refute changeset.valid?
      end
    end

    test "mendaftarkan unique constraint dengan nama yang benar" do
      changeset =
        ReviewRoundFile.changeset(%ReviewRoundFile{}, %{
          submission_id: 1,
          review_round_id: 1,
          stage_id: 3,
          submission_file_id: 1
        })

      assert Enum.any?(
               changeset.constraints,
               &(&1.constraint == "review_round_files_unique")
             )
    end
  end
end
