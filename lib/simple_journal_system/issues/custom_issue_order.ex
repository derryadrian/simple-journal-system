defmodule SimpleJournalSystem.Issues.CustomIssueOrder do
  @moduledoc """
  Pengaturan urutan khusus issue dalam sebuah jurnal.
  Sama dengan tabel `custom_issue_orders` di OJS 3.5.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:custom_issue_order_id, :id, autogenerate: true}
  @derive {Phoenix.Param, key: :custom_issue_order_id}

  schema "custom_issue_orders" do
    field :seq, :float, default: 0.0

    belongs_to :issue, SimpleJournalSystem.Issues.Issue,
      foreign_key: :issue_id,
      references: :issue_id

    belongs_to :journal, SimpleJournalSystem.Journals.Journal,
      foreign_key: :journal_id,
      references: :journal_id
  end

  def changeset(custom_issue_order, attrs) do
    custom_issue_order
    |> cast(attrs, [:issue_id, :journal_id, :seq])
    |> validate_required([:issue_id, :journal_id, :seq])
    |> unique_constraint(:issue_id, name: :custom_issue_orders_unique)
  end
end
