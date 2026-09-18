defmodule SimpleJournalSystem.Repo.Migrations.CreateUsersAuthTables do
  use Ecto.Migration

  def change do
    execute """
    CREATE TABLE IF NOT EXISTS users (
      user_id BIGSERIAL PRIMARY KEY,
      username VARCHAR(32),
      password VARCHAR(255),
      email VARCHAR(255),
      url VARCHAR(2047),
      phone VARCHAR(32),
      mailing_address VARCHAR(255),
      billing_address VARCHAR(255),
      country VARCHAR(90),
      locales VARCHAR(255),
      gossip TEXT,
      date_last_email TIMESTAMP,
      date_registered TIMESTAMP NOT NULL DEFAULT NOW(),
      date_validated TIMESTAMP,
      date_last_login TIMESTAMP,
      must_change_password SMALLINT,
      auth_id BIGINT,
      auth_str VARCHAR(255),
      disabled SMALLINT NOT NULL DEFAULT 0,
      disabled_reason TEXT,
      inline_help SMALLINT,
      remember_token VARCHAR(100)
    )
    """, ""
  end
end
