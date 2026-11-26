defmodule SimpleJournalSystem.Reviews.ReviewRoundTest do
  use SimpleJournalSystem.DataCase, async: true

  alias SimpleJournalSystem.Reviews.ReviewRound

  describe "changeset/2" do
    test "valid dengan atribut wajib" do
      changeset =
        ReviewRound.changeset(%ReviewRound{}, %{
          submission_id: 1,
          round: 1
        })

      assert changeset.valid?
    end

    test "valid dengan semua atribut" do
      changeset =
        ReviewRound.changeset(%ReviewRound{}, %{
          submission_id: 1,
          stage_id: 3,
          round: 1,
          review_revision: 1,
          status: 6
        })

      assert changeset.valid?
    end

    test "menolak submission_id kosong" do
      changeset =
        ReviewRound.changeset(%ReviewRound{}, %{
          round: 1
        })

      refute changeset.valid?
      assert %{submission_id: [_]} = errors_on(changeset)
    end

    test "menolak round kosong" do
      changeset =
        ReviewRound.changeset(%ReviewRound{}, %{
          submission_id: 1
        })

      refute changeset.valid?
      assert %{round: [_]} = errors_on(changeset)
    end

    test "menolak submission_id nol atau negatif" do
      for value <- [0, -1] do
        changeset =
          ReviewRound.changeset(%ReviewRound{}, %{
            submission_id: value,
            round: 1
          })

        refute changeset.valid?
      end
    end

    test "menolak round nol atau negatif" do
      for value <- [0, -1] do
        changeset =
          ReviewRound.changeset(%ReviewRound{}, %{
            submission_id: 1,
            round: value
          })

        refute changeset.valid?
      end
    end
  end
end
