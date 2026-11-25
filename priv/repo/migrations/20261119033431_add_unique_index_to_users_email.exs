defmodule SimpleJournalSystem.Repo.Migrations.AddUniqueIndexToUsersEmail do
  use Ecto.Migration

  def change do
    # Pake huruf kecil "lower" sesuai saran ChatGPT
    create unique_index(:users, ["lower(email)"], name: :users_lower_email_index)
  end
end