defmodule SimpleJournalSystem.AnnouncementsTest do
  use SimpleJournalSystem.DataCase

  alias SimpleJournalSystem.Announcements

  describe "announcements" do
    alias SimpleJournalSystem.Announcements.Announcement

    import SimpleJournalSystem.AnnouncementsFixtures

    @invalid_attrs %{date_posted: nil}

    test "list_announcements/0 returns all announcements" do
      announcement = announcement_fixture()
      assert Announcements.list_announcements() == [announcement]
    end

    test "get_announcement!/1 returns the announcement with given id" do
      announcement = announcement_fixture()
      assert Announcements.get_announcement!(announcement.announcement_id) == announcement
    end

    test "create_announcement/1 with valid data creates an announcement" do
      valid_attrs = %{
        assoc_type: 1,
        assoc_id: 1,
        type_id: 1,
        date_expire: ~D[2024-12-31],
        date_posted: ~N[2024-01-01 00:00:00]
      }

      assert {:ok, %Announcement{} = announcement} =
               Announcements.create_announcement(valid_attrs)

      assert announcement.assoc_type == 1
      assert announcement.assoc_id == 1
      assert announcement.type_id == 1
      assert announcement.date_expire == ~D[2024-12-31]
      assert announcement.date_posted == ~N[2024-01-01 00:00:00]
    end

    test "create_announcement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Announcements.create_announcement(@invalid_attrs)
    end

    test "update_announcement/2 with valid data updates the announcement" do
      announcement = announcement_fixture()
      update_attrs = %{date_expire: ~D[2025-06-30]}

      assert {:ok, %Announcement{} = announcement} =
               Announcements.update_announcement(announcement, update_attrs)

      assert announcement.date_expire == ~D[2025-06-30]
    end

    test "update_announcement/2 with invalid data returns error changeset" do
      announcement = announcement_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Announcements.update_announcement(announcement, @invalid_attrs)
    end

    test "update_announcement/2 does not change announcement_id" do
      announcement = announcement_fixture()
      original_announcement_id = announcement.announcement_id

      assert {:ok, updated_announcement} =
               Announcements.update_announcement(announcement, %{date_expire: ~D[2025-06-30]})

      assert updated_announcement.announcement_id == original_announcement_id
    end

    test "delete_announcement/1 deletes the announcement" do
      announcement = announcement_fixture()
      assert {:ok, %Announcement{}} = Announcements.delete_announcement(announcement)

      assert_raise Ecto.NoResultsError, fn ->
        Announcements.get_announcement!(announcement.announcement_id)
      end
    end

    test "change_announcement/1 returns an announcement changeset" do
      announcement = announcement_fixture()
      assert %Ecto.Changeset{} = Announcements.change_announcement(announcement)
    end
  end
end
