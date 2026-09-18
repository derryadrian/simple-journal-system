defmodule SimpleJournalSystem.Repo.Migrations.CreateUserGroupsAndUserUserGroups do
  use Ecto.Migration

  def change do
    execute """
    CREATE TABLE IF NOT EXISTS user_groups (
      user_group_id BIGSERIAL PRIMARY KEY,
      context_id BIGINT,
      role_id BIGINT NOT NULL,
      is_default SMALLINT NOT NULL DEFAULT 0,
      show_title SMALLINT NOT NULL DEFAULT 1,
      permit_self_registration SMALLINT NOT NULL DEFAULT 0,
      permit_metadata_edit SMALLINT NOT NULL DEFAULT 0,
      permit_settings SMALLINT NOT NULL DEFAULT 0,
      masthead SMALLINT NOT NULL DEFAULT 0
    )
    """, ""

    execute """
    CREATE TABLE IF NOT EXISTS user_user_groups (
      user_user_group_id BIGSERIAL PRIMARY KEY,
      user_group_id BIGINT NOT NULL REFERENCES user_groups(user_group_id) ON DELETE CASCADE,
      user_id BIGINT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
      date_start TIMESTAMP,
      date_end TIMESTAMP,
      masthead SMALLINT
    )
    """, ""

    execute """
    CREATE INDEX IF NOT EXISTS user_user_groups_user_id_index
      ON user_user_groups(user_id)
    """, ""

    execute """
    CREATE INDEX IF NOT EXISTS user_user_groups_user_group_id_index
      ON user_user_groups(user_group_id)
    """, ""
  end
end
