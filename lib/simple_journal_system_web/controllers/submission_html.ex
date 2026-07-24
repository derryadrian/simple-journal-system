defmodule SimpleJournalSystemWeb.SubmissionHTML do
  use SimpleJournalSystemWeb, :html

  embed_templates "submission_html/*"

  @doc """
  Renders a submission form.

  The form is defined in the template at
  submission_html/submission_form.html.heex
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :return_to, :string, default: nil

  def submission_form(assigns)
end
