defmodule SimpleJournalSystem.Submissions.Section do
  @moduledoc """
  Section jurnal, sama dengan tabel `sections` di OJS 3.5.

  Judul section ada di `section_settings` (setting `title`).
  """
  use Ecto.Schema

  @primary_key {:section_id, :id, autogenerate: true}

  schema "sections" do
    field :journal_id, :integer
    field :review_form_id, :integer
    field :seq, :float, default: 0.0
    field :editor_restricted, :integer, default: 0
    field :meta_indexed, :integer, default: 0
    field :meta_reviewed, :integer, default: 1
    field :abstracts_not_required, :integer, default: 0
    field :hide_title, :integer, default: 0
    field :hide_author, :integer, default: 0
    field :is_inactive, :integer, default: 0
    field :abstract_word_count, :integer
  end
end
