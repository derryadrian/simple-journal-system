defmodule SimpleJournalSystem.Roles.UserUserGroup do
  @moduledoc """
  Maps the existing OJS `user_user_groups` table.

  Associates a user with a user group (role), including assignment dates.
  """
  use Ecto.Schema

  alias SimpleJournalSystem.Roles.UserGroup

  @primary_key {:user_user_group_id, :id, []}

  schema "user_user_groups" do
    belongs_to :user_group, UserGroup, foreign_key: :user_group_id, references: :user_group_id
    field :user_id, :integer
    field :date_start, :naive_datetime
    field :date_end, :naive_datetime
    field :masthead, :integer
  end
end
