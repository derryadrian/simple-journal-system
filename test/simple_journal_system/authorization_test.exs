defmodule SimpleJournalSystem.AuthorizationTest do
  use SimpleJournalSystem.DataCase

  alias SimpleJournalSystem.Accounts
  alias SimpleJournalSystem.Accounts.User
  alias SimpleJournalSystem.Accounts.UserGroup
  alias SimpleJournalSystem.Accounts.UserUserGroup
  alias SimpleJournalSystem.Authorization
  alias SimpleJournalSystem.Accounts.Roles

  @tag :authorization
  describe "Authorization" do
    setup do
      # Create a user
      {:ok, user} = Accounts.register_user(%{
        username: "testuser#{System.unique_integer()}",
        email: "test#{System.unique_integer()}@example.com",
        password: "password123",
        password_confirmation: "password123"
      })

      # Create user groups for different roles
      {:ok, manager_group} = Accounts.create_user_group(%{
        context_id: 1,
        role_id: Roles.manager(),
        is_default: 1
      })

      {:ok, author_group} = Accounts.create_user_group(%{
        context_id: 1,
        role_id: Roles.author(),
        is_default: 0
      })

      {:ok, editor_group} = Accounts.create_user_group(%{
        context_id: 1,
        role_id: Roles.editor(),
        is_default: 0
      })

      {:ok, reviewer_group} = Accounts.create_user_group(%{
        context_id: 1,
        role_id: Roles.reviewer(),
        is_default: 0
      })

      {:ok, reader_group} = Accounts.create_user_group(%{
        context_id: 1,
        role_id: Roles.reader(),
        is_default: 0
      })

      {:ok, journal_manager_group} = Accounts.create_user_group(%{
        context_id: 1,
        role_id: Roles.journal_manager(),
        is_default: 0
      })

      {:ok, site_admin_group} = Accounts.create_user_group(%{
        context_id: nil,
        role_id: Roles.site_admin(),
        is_default: 0
      })

      %{
        user: user,
        manager_group: manager_group,
        author_group: author_group,
        editor_group: editor_group,
        reviewer_group: reviewer_group,
        reader_group: reader_group,
        journal_manager_group: journal_manager_group,
        site_admin_group: site_admin_group
      }
    end

    @tag :get_roles
    test "get_roles returns empty list for user without roles", %{user: user} do
      assert Authorization.get_roles(user) == []
    end

    @tag :has_role
    test "has_role? returns true when user has the role", %{user: user, author_group: author_group} do
      Accounts.enroll_user(user.user_id, author_group.user_group_id)
      user = Accounts.get_user_by_session_token(user.user_id) |> elem(0)

      assert Authorization.has_role?(user, Roles.author())
      refute Authorization.has_role?(user, Roles.editor())
    end

    @tag :has_any_role
    test "has_any_role? returns true when user has at least one role", %{user: user, author_group: author_group, editor_group: editor_group} do
      Accounts.enroll_user(user.user_id, author_group.user_group_id)
      user = Accounts.get_user_by_session_token(user.user_id) |> elem(0)

      assert Authorization.has_any_role?(user, [Roles.author(), Roles.editor()])
      assert Authorization.has_any_role?(user, [Roles.manager(), Roles.author()])
      refute Authorization.has_any_role?(user, [Roles.manager(), Roles.reviewer()])
    end

    @tag :has_all_roles
    test "has_all_roles? returns true only when user has all roles", %{user: user, author_group: author_group, editor_group: editor_group} do
      Accounts.enroll_user(user.user_id, author_group.user_group_id)
      Accounts.enroll_user(user.user_id, editor_group.user_group_id)
      user = Accounts.get_user_by_session_token(user.user_id) |> elem(0)

      assert Authorization.has_all_roles?(user, [Roles.author(), Roles.editor()])
      refute Authorization.has_all_roles?(user, [Roles.author(), Roles.editor(), Roles.reviewer()])
    end

    @tag :helper_functions
    test "helper functions work correctly", %{user: user, editor_group: editor_group, reviewer_group: reviewer_group} do
      Accounts.enroll_user(user.user_id, editor_group.user_group_id)
      Accounts.enroll_user(user.user_id, reviewer_group.user_group_id)
      user = Accounts.get_user_by_session_token(user.user_id) |> elem(0)

      assert Authorization.is_editor?(user)
      assert Authorization.is_reviewer?(user)
      refute Authorization.is_author?(user)
      refute Authorization.is_manager?(user)
    end

    @tag :multi_journal
    test "user can have different roles in different journals", %{user: user, author_group: author_group, editor_group: editor_group} do
      # Enroll as author in journal 1
      Accounts.enroll_user(user.user_id, author_group.user_group_id)
      
      # Create editor group for journal 2
      {:ok, editor_group_j2} = Accounts.create_user_group(%{
        context_id: 2,
        role_id: Roles.editor(),
        is_default: 0
      })
      Accounts.enroll_user(user.user_id, editor_group_j2.user_group_id)
      
      user = Accounts.get_user_by_session_token(user.user_id) |> elem(0)
      roles = Authorization.get_roles(user)
      
      assert Roles.author() in roles
      assert Roles.editor() in roles
      assert length(roles) == 2
    end
  end
end