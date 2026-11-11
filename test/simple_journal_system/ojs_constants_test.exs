defmodule SimpleJournalSystem.Ojs.ConstantsTest do
  use ExUnit.Case, async: true

  alias SimpleJournalSystem.Ojs.{
    Decision,
    FileStage,
    ReviewAssignmentConsidered,
    ReviewAssignmentStatus,
    ReviewMethod,
    ReviewRecommendation,
    ReviewRoundStatus,
    SubmissionStatus
  }

  @modules [
    Decision,
    FileStage,
    ReviewAssignmentConsidered,
    ReviewAssignmentStatus,
    ReviewMethod,
    ReviewRecommendation,
    ReviewRoundStatus,
    SubmissionStatus
  ]

  describe "semua modul konstanta" do
    test "tidak ada nilai kembar" do
      for mod <- @modules do
        assert mod.all() == Enum.uniq(mod.all()), "nilai kembar di #{inspect(mod)}"
      end
    end

    test "setiap nilai dikenal dan punya nama" do
      for mod <- @modules, value <- mod.all() do
        assert mod.valid?(value)
        refute String.starts_with?(mod.name(value), "Unknown")
      end
    end

    test "nilai yang tidak dikenal ditolak" do
      for mod <- @modules do
        refute mod.valid?(9999)
        assert mod.name(9999) == "Unknown (9999)"
      end
    end
  end

  describe "nilai sama dengan OJS 3.5 (pkp-lib)" do
    test "status naskah" do
      assert SubmissionStatus.queued() == 1
      assert SubmissionStatus.published() == 3
      assert SubmissionStatus.declined() == 4
      assert SubmissionStatus.scheduled() == 5
    end

    test "kode keputusan" do
      assert Decision.accept() == 2
      assert Decision.external_review() == 3
      assert Decision.pending_revisions() == 4
      assert Decision.decline() == 6
      assert Decision.send_to_production() == 7
      assert Decision.initial_decline() == 8
      assert Decision.back_from_production() == 29
      assert length(Decision.all()) == 18
    end

    test "rekomendasi bukan keputusan yang mengubah stage" do
      assert Decision.recommendation?(Decision.recommend_accept())
      assert Decision.recommendation?(Decision.recommend_decline())
      refute Decision.recommendation?(Decision.accept())
      refute Decision.recommendation?(Decision.decline())
    end

    test "status review round" do
      assert ReviewRoundStatus.pending_reviewers() == 6
      assert ReviewRoundStatus.reviews_completed() == 9
      assert ReviewRoundStatus.revisions_submitted() == 11
    end

    test "status penugasan reviewer" do
      assert ReviewAssignmentStatus.awaiting_response() == 0
      assert ReviewAssignmentStatus.received() == 7

      assert ReviewAssignmentStatus.complete_statuses() == [7, 8, 9, 12]
    end

    test "tahap file" do
      assert FileStage.submission() == 2
      assert FileStage.review_file() == 4
      assert FileStage.review_revision() == 15
      assert FileStage.production_ready() == 11
    end
  end
end
