defmodule SimpleJournalSystem.Accounts.UserUserGroup do
  use Ecto.Schema

  @primary_key {:user_user_group_id, :id, []}

  schema "user_user_groups" do
    field :date_start, :naive_datetime
    field :date_end, :naive_datetime
    field :masthead, :integer

    belongs_to :user,
      SimpleJournalSystem.Accounts.User,
      foreign_key: :user_id,
      references: :user_id

    belongs_to :user_group,
      SimpleJournalSystem.Accounts.UserGroup,
      foreign_key: :user_group_id,
      references: :user_group_id
  end
end
