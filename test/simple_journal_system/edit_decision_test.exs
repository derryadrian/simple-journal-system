defmodule SimpleJournalSystem.Submissions.EditDecisionTest do
  use SimpleJournalSystem.DataCase, async: true

  alias SimpleJournalSystem.Submissions.EditDecision

  describe "changeset/2" do
    test "menerima keputusan editor dengan data valid" do
      changeset =
        EditDecision.changeset(%EditDecision{}, %{
          submission_id: 1,
          editor_id: 1,
          decision: 1,
          date_decided: ~N[2026-11-20 09:00:00]
        })

      assert changeset.valid?
    end

    test "menolak data tanpa submission_id" do
      changeset =
        EditDecision.changeset(%EditDecision{}, %{
          editor_id: 1,
          decision: 1,
          date_decided: ~N[2026-11-20 09:00:00]
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).submission_id
    end

    test "menolak data tanpa editor_id" do
      changeset =
        EditDecision.changeset(%EditDecision{}, %{
          submission_id: 1,
          decision: 1,
          date_decided: ~N[2026-11-20 09:00:00]
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).editor_id
    end

    test "menolak data tanpa decision" do
      changeset =
        EditDecision.changeset(%EditDecision{}, %{
          submission_id: 1,
          editor_id: 1,
          date_decided: ~N[2026-11-20 09:00:00]
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).decision
    end

    test "menolak data tanpa date_decided" do
      changeset =
        EditDecision.changeset(%EditDecision{}, %{
          submission_id: 1,
          editor_id: 1,
          decision: 1
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).date_decided
    end

    test "mengizinkan review_round_id, stage_id, dan round bernilai nil" do
      changeset =
        EditDecision.changeset(%EditDecision{}, %{
          submission_id: 1,
          editor_id: 1,
          decision: 1,
          date_decided: ~N[2026-11-20 09:00:00],
          review_round_id: nil,
          stage_id: nil,
          round: nil
        })

      assert changeset.valid?
    end
  end
end
