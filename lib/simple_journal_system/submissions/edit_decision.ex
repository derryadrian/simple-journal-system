defmodule SimpleJournalSystem.Submissions.EditDecision do
  @moduledoc """
  Keputusan editor terhadap submission, sesuai tabel `edit_decisions` di OJS 3.5.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:edit_decision_id, :id, autogenerate: true}
  @derive {Phoenix.Param, key: :edit_decision_id}

  schema "edit_decisions" do
    field :submission_id, :integer
    field :review_round_id, :integer
    field :stage_id, :integer
    field :round, :integer
    field :editor_id, :integer
    field :decision, :integer
    field :date_decided, :naive_datetime
  end

  def changeset(edit_decision, attrs) do
    edit_decision
    |> cast(attrs, [
      :submission_id,
      :review_round_id,
      :stage_id,
      :round,
      :editor_id,
      :decision,
      :date_decided
    ])
    |> validate_required([
      :submission_id,
      :editor_id,
      :decision,
      :date_decided
    ])
  end
end
