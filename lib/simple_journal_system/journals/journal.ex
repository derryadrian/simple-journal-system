defmodule SimpleJournalSystem.Journals.Journal do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:journal_id, :id, []}
  @derive {Phoenix.Param, key: :journal_id}

  schema "journals" do
    field :path, :string
    field :seq, :float
    field :primary_locale, :string
    field :enabled, :integer, default: 1
    field :current_issue_id, :integer

    has_many :user_groups, SimpleJournalSystem.Accounts.UserGroup,
      foreign_key: :context_id,
      references: :journal_id

    timestamps(type: :utc_datetime, updated_at: false)
  end

  def changeset(journal, attrs) do
    journal
    |> cast(attrs, [:path, :seq, :primary_locale, :enabled, :current_issue_id])
    |> validate_required([:path, :primary_locale])
    |> unique_constraint(:path)
  end
end