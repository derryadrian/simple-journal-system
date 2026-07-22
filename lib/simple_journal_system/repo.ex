defmodule SimpleJournalSystem.Repo do
  use Ecto.Repo,
    otp_app: :simple_journal_system,
    adapter: Ecto.Adapters.Postgres
end
