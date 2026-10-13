defmodule SimpleJournalSystem.Repo.Migrations.CreateRoleChangeLogs do
  use Ecto.Migration

  def change do
    create table(:role_change_logs) do
      add :user_id, references(:users, column: :user_id, type: :bigint, on_delete: :nilify_all)
      add :changed_by_id, references(:users, column: :user_id, type: :bigint, on_delete: :nilify_all)
      add :action, :string, null: false  # "enroll", "unenroll", "role_change", "approve", "reject"
      add :old_role_id, :integer
      add :new_role_id, :integer
      add :user_group_id, :integer
      add :context_id, :integer
      add :metadata, :map
      add :ip_address, :string
      add :user_agent, :string

      timestamps(type: :utc_datetime)
    end

    create index(:role_change_logs, [:user_id])
    create index(:role_change_logs, [:changed_by_id])
    create index(:role_change_logs, [:action])
    create index(:role_change_logs, [:context_id])
    create index(:role_change_logs, [:inserted_at])
  end
end