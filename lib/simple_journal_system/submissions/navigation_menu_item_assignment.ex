defmodule SimpleJournalSystem.Submissions.NavigationMenuItemAssignment do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:navigation_menu_item_assignment_id, :id, autogenerate: true}
  @derive {Phoenix.Param, key: :navigation_menu_item_assignment_id}

  schema "navigation_menu_item_assignments" do
    field :navigation_menu_id, :integer
    field :navigation_menu_item_id, :integer
    field :parent_id, :integer
    field :seq, :integer, default: 0
  end

  def changeset(assignment, attrs) do
    assignment
    |> cast(attrs, [
      :navigation_menu_id,
      :navigation_menu_item_id,
      :parent_id,
      :seq
    ])
    |> validate_required([
      :navigation_menu_id,
      :navigation_menu_item_id
    ])
  end
end
