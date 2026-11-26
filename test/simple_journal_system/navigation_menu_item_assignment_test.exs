defmodule SimpleJournalSystem.Submissions.NavigationMenuItemAssignmentTest do
  use SimpleJournalSystem.DataCase, async: true

  alias SimpleJournalSystem.Submissions.NavigationMenuItemAssignment

  describe "changeset/2" do
    test "menerima data assignment yang valid" do
      changeset =
        NavigationMenuItemAssignment.changeset(
          %NavigationMenuItemAssignment{},
          %{
            navigation_menu_id: 1,
            navigation_menu_item_id: 1,
            parent_id: nil,
            seq: 0
          }
        )

      assert changeset.valid?
    end

    test "menolak data tanpa navigation_menu_id" do
      changeset =
        NavigationMenuItemAssignment.changeset(
          %NavigationMenuItemAssignment{},
          %{navigation_menu_item_id: 1}
        )

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).navigation_menu_id
    end

    test "menolak data tanpa navigation_menu_item_id" do
      changeset =
        NavigationMenuItemAssignment.changeset(
          %NavigationMenuItemAssignment{},
          %{navigation_menu_id: 1}
        )

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).navigation_menu_item_id
    end

    test "mengizinkan parent_id bernilai nil" do
      changeset =
        NavigationMenuItemAssignment.changeset(
          %NavigationMenuItemAssignment{},
          %{navigation_menu_id: 1, navigation_menu_item_id: 1}
        )

      assert changeset.valid?
      assert get_change(changeset, :parent_id) == nil
    end
  end
end
