defmodule SimpleJournalSystem.Submissions.SubeditorSubmissionGroup do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:subeditor_submission_group_id, :id, autogenerate: true}
  @derive {Phoenix.Param, key: :subeditor_submission_group_id}

  schema "subeditor_submission_group" do
    field :context_id, :integer
    field :assoc_id, :integer
    field :assoc_type, :integer

    belongs_to :user,
               SimpleJournalSystem.Accounts.User,
               foreign_key: :user_id,
               references: :user_id

    belongs_to :user_group,
               SimpleJournalSystem.Accounts.UserGroup,
               foreign_key: :user_group_id,
               references: :user_group_id
  end

  def changeset(group, attrs) do
    group
    |> cast(attrs, [
      :context_id,
      :assoc_id,
      :assoc_type,
      :user_id,
      :user_group_id
    ])
    |> validate_required([
      :context_id,
      :assoc_id,
      :assoc_type,
      :user_id,
      :user_group_id
    ])
    |> unique_constraint(
      [:context_id, :assoc_id, :assoc_type, :user_id, :user_group_id],
      name: :section_editors_unique
    )
  end
end
