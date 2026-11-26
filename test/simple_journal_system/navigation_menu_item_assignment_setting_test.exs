defmodule SimpleJournalSystem.Submissions.NavigationMenuItemAssignmentSettingTest do
  use SimpleJournalSystem.DataCase, async: true

  alias SimpleJournalSystem.Submissions.NavigationMenuItemAssignmentSetting

  describe "changeset/2" do
    test "menerima data setting yang valid" do
      changeset =
        NavigationMenuItemAssignmentSetting.changeset(
          %NavigationMenuItemAssignmentSetting{},
          %{
            navigation_menu_item_assignment_id: 1,
            locale: "en_US",
            setting_name: "label",
            setting_value: "Home",
            setting_type: "string"
          }
        )

      assert changeset.valid?
    end

    test "menolak data tanpa navigation_menu_item_assignment_id" do
      changeset =
        NavigationMenuItemAssignmentSetting.changeset(
          %NavigationMenuItemAssignmentSetting{},
          %{
            locale: "en_US",
            setting_name: "label",
            setting_type: "string"
          }
        )

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).navigation_menu_item_assignment_id
    end

    test "menolak data tanpa locale" do
      changeset =
        NavigationMenuItemAssignmentSetting.changeset(
          %NavigationMenuItemAssignmentSetting{},
          %{
            navigation_menu_item_assignment_id: 1,
            setting_name: "label",
            setting_type: "string"
          }
        )

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).locale
    end

    test "menolak data tanpa setting_name" do
      changeset =
        NavigationMenuItemAssignmentSetting.changeset(
          %NavigationMenuItemAssignmentSetting{},
          %{
            navigation_menu_item_assignment_id: 1,
            locale: "en_US",
            setting_type: "string"
          }
        )

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).setting_name
    end

    test "menolak data tanpa setting_type" do
      changeset =
        NavigationMenuItemAssignmentSetting.changeset(
          %NavigationMenuItemAssignmentSetting{},
          %{
            navigation_menu_item_assignment_id: 1,
            locale: "en_US",
            setting_name: "label"
          }
        )

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).setting_type
    end

    test "mengizinkan setting_value bernilai nil" do
      changeset =
        NavigationMenuItemAssignmentSetting.changeset(
          %NavigationMenuItemAssignmentSetting{},
          %{
            navigation_menu_item_assignment_id: 1,
            locale: "en_US",
            setting_name: "label",
            setting_type: "string"
          }
        )

      assert changeset.valid?
    end
  end
end
