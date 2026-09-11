defmodule SimpleJournalSystem.Notes.Note do
  use Ecto.Schema
  import Ecto.Changeset

  alias SimpleJournalSystem.Repo

  @primary_key {:note_id, :id, autogenerate: false}
  @derive {Phoenix.Param, key: :note_id}

  schema "notes" do
    field :assoc_type, :integer
    field :assoc_id, :integer
    field :user_id, :integer
    field :date_created, :naive_datetime
    field :date_modified, :naive_datetime
    field :title, :string
    field :contents, :string
  end

  @doc false
  def changeset(note, attrs) do
    note
    |> cast(attrs, [
      :assoc_type,
      :assoc_id,
      :user_id,
      :date_created,
      :date_modified,
      :title,
      :contents
    ])
    |> validate_required([
      :assoc_type,
      :assoc_id,
      :user_id,
      :date_created
    ])
  end

  @doc false
  def create_changeset(note, attrs) do
    note
    |> changeset(attrs)
    |> put_note_id()
  end

  defp put_note_id(changeset) do
    case changeset.valid? do
      true ->
        max_id = Repo.aggregate(__MODULE__, :max, :note_id) || 0
        change(changeset, note_id: max_id + 1)

      false ->
        changeset
    end
  end
end
