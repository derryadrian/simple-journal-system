defmodule SimpleJournalSystem.AuthorizationTest do
  use SimpleJournalSystem.DataCase, async: true

  alias SimpleJournalSystem.Authorization

  import SimpleJournalSystem.RolesFixtures

  describe "get_roles/1" do
    test "returns an empty list for nil" do
      assert Authorization.get_roles(nil) == []
    end

    test "returns an empty list for a user without any role" do
      user = user_fixture()

      assert Authorization.get_roles(user) == []
    end

    test "returns a single role_id for a user with one role" do
      user = user_with_role_fixture(Authorization.role_author())

      assert Authorization.get_roles(user) == [Authorization.role_author()]
    end

    test "returns all unique role_ids for a user with multiple roles" do
      user = user_with_roles_fixture([Authorization.role_author(), Authorization.role_reviewer()])

      assert Enum.sort(Authorization.get_roles(user)) ==
               Enum.sort([Authorization.role_author(), Authorization.role_reviewer()])
    end

    test "deduplicates role_ids when a user belongs to multiple groups with the same role" do
      user = user_fixture()
      user = with_role(user, Authorization.role_author())
      user = with_role(user, Authorization.role_author())

      assert Authorization.get_roles(user) == [Authorization.role_author()]
    end

    test "works for a user whose role comes from a non-author group" do
      user = user_with_role_fixture(Authorization.role_editor())

      assert Authorization.get_roles(user) == [Authorization.role_editor()]
    end
  end

  describe "has_role?/2" do
    test "returns true when the user has the role" do
      user = user_with_role_fixture(Authorization.role_author())

      assert Authorization.has_role?(user, Authorization.role_author())
    end

    test "returns false when the user has a different role" do
      user = user_with_role_fixture(Authorization.role_author())

      refute Authorization.has_role?(user, Authorization.role_editor())
    end

    test "returns false for a user without any role" do
      user = user_fixture()

      refute Authorization.has_role?(user, Authorization.role_author())
    end

    test "returns false for nil" do
      refute Authorization.has_role?(nil, Authorization.role_author())
    end
  end

  describe "has_any_role?/2" do
    test "returns true when the user has at least one allowed role" do
      user = user_with_role_fixture(Authorization.role_author())

      assert Authorization.has_any_role?(user, [
               Authorization.role_editor(),
               Authorization.role_author()
             ])
    end

    test "returns false when the user has none of the allowed roles" do
      user = user_with_role_fixture(Authorization.role_reader())

      refute Authorization.has_any_role?(user, [
               Authorization.role_editor(),
               Authorization.role_author()
             ])
    end

    test "returns false for an empty allowed list" do
      user = user_with_role_fixture(Authorization.role_author())

      refute Authorization.has_any_role?(user, [])
    end

    test "returns false for a user without any role" do
      user = user_fixture()

      refute Authorization.has_any_role?(user, [Authorization.role_author()])
    end

    test "returns false for nil" do
      refute Authorization.has_any_role?(nil, [Authorization.role_author()])
    end
  end

  describe "has_all_roles?/2" do
    test "returns true when the user has all required roles" do
      user = user_with_roles_fixture([Authorization.role_author(), Authorization.role_reviewer()])

      assert Authorization.has_all_roles?(user, [
               Authorization.role_author(),
               Authorization.role_reviewer()
             ])
    end

    test "returns false when the user is missing one required role" do
      user = user_with_role_fixture(Authorization.role_author())

      refute Authorization.has_all_roles?(user, [
               Authorization.role_author(),
               Authorization.role_reviewer()
             ])
    end

    test "returns true for an empty required list" do
      user = user_with_role_fixture(Authorization.role_author())

      assert Authorization.has_all_roles?(user, [])
    end

    test "returns false for a user without any role" do
      user = user_fixture()

      refute Authorization.has_all_roles?(user, [Authorization.role_author()])
    end

    test "returns false for nil" do
      refute Authorization.has_all_roles?(nil, [Authorization.role_author()])
    end
  end

  describe "OJS role helpers" do
    test "is_author?/1 is true only for author users" do
      user = user_with_role_fixture(Authorization.role_author())

      assert Authorization.is_author?(user)
      refute Authorization.is_manager?(user)
      refute Authorization.is_site_admin?(user)
      refute Authorization.is_editor?(user)
      refute Authorization.is_reviewer?(user)
      refute Authorization.is_assistant?(user)
      refute Authorization.is_reader?(user)
    end

    test "each is_*?/1 helper matches only its own role" do
      helpers = [
        {Authorization.role_manager(), &Authorization.is_manager?/1},
        {Authorization.role_admin(), &Authorization.is_site_admin?/1},
        {Authorization.role_author(), &Authorization.is_author?/1},
        {Authorization.role_editor(), &Authorization.is_editor?/1},
        {Authorization.role_reviewer(), &Authorization.is_reviewer?/1},
        {Authorization.role_assistant(), &Authorization.is_assistant?/1},
        {Authorization.role_reader(), &Authorization.is_reader?/1}
      ]

      for {role_id, _helper} <- helpers do
        user = user_with_role_fixture(role_id)

        for {other_role_id, other_helper} <- helpers do
          if role_id == other_role_id do
            assert other_helper.(user),
                   "expected helper for role #{role_id} to be true"
          else
            refute other_helper.(user),
                   "expected helper for role #{other_role_id} to be false for role #{role_id} user"
          end
        end
      end
    end

    test "role helpers return false for users without that role" do
      user = user_with_role_fixture(Authorization.role_editor())

      refute Authorization.is_author?(user)
      refute Authorization.is_manager?(user)
      refute Authorization.is_reader?(user)
    end

    test "role helpers return false for nil" do
      refute Authorization.is_author?(nil)
      refute Authorization.is_manager?(nil)
      refute Authorization.is_reader?(nil)
    end
  end
end
