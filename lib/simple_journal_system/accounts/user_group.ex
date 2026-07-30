defmodule SimpleJournalSystem.Accounts.UserGroup do
  use Ecto.Schema

  @primary_key {:user_group_id, :id, []}

  schema "user_groups" do
    field :context_id, :integer
    field :role_id, :integer

    field :is_default, :integer
    field :show_title, :integer
    field :permit_self_registration, :integer
    field :permit_metadata_edit, :integer
    field :permit_settings, :integer
    field :masthead, :integer

    has_many :user_user_groups,
      SimpleJournalSystem.Accounts.UserUserGroup,
      foreign_key: :user_group_id
  end
end
