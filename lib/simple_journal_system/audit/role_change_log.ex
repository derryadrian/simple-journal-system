defmodule SimpleJournalSystem.Audit.RoleChangeLog do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:role_change_log_id, :id, []}
  @derive {Phoenix.Param, key: :role_change_log_id}

  schema "role_change_logs" do
    field :action, :string
    field :old_role_id, :integer
    field :new_role_id, :integer
    field :user_group_id, :integer
    field :context_id, :integer
    field :metadata, :map
    field :ip_address, :string
    field :user_agent, :string

    belongs_to :user, SimpleJournalSystem.Accounts.User,
      foreign_key: :user_id,
      references: :user_id

    belongs_to :changed_by, SimpleJournalSystem.Accounts.User,
      foreign_key: :changed_by_id,
      references: :user_id

    timestamps(type: :utc_datetime)
  end

  def changeset(log, attrs) do
    log
    |> cast(attrs, [
      :user_id, :changed_by_id, :action, :old_role_id, :new_role_id,
      :user_group_id, :context_id, :metadata, :ip_address, :user_agent
    ])
    |> validate_required([:user_id, :changed_by_id, :action])
  end
end