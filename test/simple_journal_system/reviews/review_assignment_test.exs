defmodule SimpleJournalSystem.Reviews.ReviewAssignmentTest do
  use SimpleJournalSystem.DataCase, async: true

  alias SimpleJournalSystem.Reviews.ReviewAssignment

  alias SimpleJournalSystem.Ojs.{
    ReviewAssignmentConsidered,
    ReviewMethod,
    ReviewRecommendation
  }

  @valid_attrs %{
    submission_id: 1,
    reviewer_id: 2,
    review_round_id: 1,
    stage_id: 3
  }

  describe "changeset/2" do
    test "valid dengan atribut wajib" do
      changeset =
        ReviewAssignment.changeset(%ReviewAssignment{}, @valid_attrs)

      assert changeset.valid?
    end

    test "valid dengan nilai enum OJS" do
      attrs =
        Map.merge(@valid_attrs, %{
          recommendation: ReviewRecommendation.accept(),
          review_method: ReviewMethod.anonymous(),
          considered: ReviewAssignmentConsidered.new()
        })

      changeset =
        ReviewAssignment.changeset(%ReviewAssignment{}, attrs)

      assert changeset.valid?
    end

    test "menggunakan default OJS" do
      changeset =
        ReviewAssignment.changeset(%ReviewAssignment{}, @valid_attrs)

      assert changeset.data.reminder_was_automatic == 0
      assert changeset.data.declined == 0
      assert changeset.data.cancelled == 0
      assert changeset.data.review_method == 1
      assert changeset.data.round == 1
      assert changeset.data.step == 1
      assert changeset.data.request_resent == 0
    end

    test "menolak atribut wajib yang kosong" do
      for field <- [
            :submission_id,
            :reviewer_id,
            :review_round_id,
            :stage_id
          ] do
        attrs = Map.delete(@valid_attrs, field)

        changeset =
          ReviewAssignment.changeset(%ReviewAssignment{}, attrs)

        refute changeset.valid?
        assert Map.has_key?(errors_on(changeset), field)
      end
    end

    test "menolak recommendation yang tidak dikenal" do
      attrs = Map.put(@valid_attrs, :recommendation, 9999)

      changeset =
        ReviewAssignment.changeset(%ReviewAssignment{}, attrs)

      refute changeset.valid?
    end

    test "menolak review_method yang tidak dikenal" do
      attrs = Map.put(@valid_attrs, :review_method, 9999)

      changeset =
        ReviewAssignment.changeset(%ReviewAssignment{}, attrs)

      refute changeset.valid?
    end

    test "menolak considered yang tidak dikenal" do
      attrs = Map.put(@valid_attrs, :considered, 9999)

      changeset =
        ReviewAssignment.changeset(%ReviewAssignment{}, attrs)

      refute changeset.valid?
    end
  end
end
