defmodule SimpleJournalSystem.Submissions.StageAssignment do
  @moduledoc """
  Penugasan user ke sebuah naskah, sama dengan tabel `stage_assignments` di OJS 3.5.

  Inilah yang menentukan siapa boleh melihat dan mengerjakan naskah (author,
  editor, copyeditor, dan seterusnya).
  """
  use Ecto.Schema

  @primary_key {:stage_assignment_id, :id, autogenerate: true}

  schema "stage_assignments" do
    field :submission_id, :integer
    field :user_group_id, :integer
    field :user_id, :integer
    field :date_assigned, :naive_datetime
    field :recommend_only, :integer, default: 0
    field :can_change_metadata, :integer, default: 0
  end
end
