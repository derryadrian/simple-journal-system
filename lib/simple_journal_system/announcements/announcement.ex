defmodule SimpleJournalSystem.Announcements.Announcement do
  use Ecto.Schema
  import Ecto.Changeset

  alias SimpleJournalSystem.Repo

  @primary_key {:announcement_id, :id, autogenerate: false}
  @derive {Phoenix.Param, key: :announcement_id}

  schema "announcements" do
    field :assoc_type, :integer
    field :assoc_id, :integer
    field :type_id, :integer
    field :date_expire, :date
    field :date_posted, :naive_datetime
  end

  @doc false
  def changeset(announcement, attrs) do
    announcement
    |> cast(attrs, [
      :assoc_type,
      :assoc_id,
      :type_id,
      :date_expire,
      :date_posted
    ])
    |> validate_required([:date_posted])
  end

  @doc false
  def create_changeset(announcement, attrs) do
    announcement
    |> changeset(attrs)
    |> put_announcement_id()
  end

  defp put_announcement_id(changeset) do
    case changeset.valid? do
      true ->
        max_id = Repo.aggregate(__MODULE__, :max, :announcement_id) || 0
        change(changeset, announcement_id: max_id + 1)

      false ->
        changeset
    end
  end
end
