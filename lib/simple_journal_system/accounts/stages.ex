defmodule SimpleJournalSystem.Accounts.Stages do
  @moduledoc """
  OJS Workflow Stage constants based on actual data in ojs_db_wsl.
  Stages found: 1, 3, 4, 5 (no stage 2 in this dataset)
  """

  @submission 1
  @review 3
  @editing 4
  @production 5

  @all [
    @submission,
    @review,
    @editing,
    @production
  ]

  @doc """
  Returns all defined stage IDs.
  """
  def all, do: @all

  @doc """
  Returns stage ID for submission.
  """
  def submission, do: @submission

  @doc """
  Returns stage ID for review.
  """
  def review, do: @review

  @doc """
  Returns stage ID for editing.
  """
  def editing, do: @editing

  @doc """
  Returns stage ID for production.
  """
  def production, do: @production

  @doc """
  Returns human-readable name for stage ID.
  """
  def name(stage_id) do
    case stage_id do
      @submission -> "Submission"
      @review -> "Review"
      @editing -> "Editing"
      @production -> "Production"
      _ -> "Unknown (#{stage_id})"
    end
  end

  @doc """
  Checks if stage_id is valid.
  """
  def valid?(stage_id), do: stage_id in @all

  @doc """
  Returns stage IDs in workflow order.
  """
  def workflow_order, do: [@submission, @review, @editing, @production]

  @doc """
  Returns stages accessible by editorial roles.
  """
  def editorial_stages, do: [@review, @editing, @production]

  @doc """
  Returns stages accessible by authors.
  """
  def author_stages, do: [@submission]
end