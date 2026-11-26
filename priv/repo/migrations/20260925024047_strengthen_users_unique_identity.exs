defmodule SimpleJournalSystem.Repo.Migrations.StrengthenUsersUniqueIdentity do
  use Ecto.Migration

  def change do
    create unique_index(
      :users,
      ["lower(username)"],
      name: :users_username_unique
    )

    create unique_index(
      :users,
      ["lower(email)"],
      name: :users_email_unique
    )
  end
end
