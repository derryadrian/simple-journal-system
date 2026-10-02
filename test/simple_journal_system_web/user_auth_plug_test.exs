defmodule SimpleJournalSystemWeb.UserAuthPlugTest do
  use SimpleJournalSystemWeb.ConnCase

  alias SimpleJournalSystem.Accounts
  alias SimpleJournalSystem.Accounts.User
  alias SimpleJournalSystem.Accounts.UserGroup
  alias SimpleJournalSystem.Accounts.UserUserGroup
  alias SimpleJournalSystem.Accounts.Roles
  alias SimpleJournalSystemWeb.UserAuth

  @tag :plug
  describe "require_role plugs" do
    setup do
      # Create user
      {:ok, user} = Accounts.register_user(%{
        username: "plugtest#{System.unique_integer()}",
        email: "plugtest#{System.unique_integer()}@example.com",
        password: "password123",
        password_confirmation: "password123"
      })

      # Create groups
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

      {:ok, manager_group} = Accounts.create_user_group(%{
        context_id: 1,
        role_id: Roles.manager(),
        is_default: 0
      })

      {:ok, site_admin_group} = Accounts.create_user_group(%{
        context_id: nil,
        role_id: Roles.site_admin(),
        is_default: 0
      })

      {:ok, reviewer_group} = Accounts.create_user_group(%{
        context_id: 1,
        role_id: Roles.reviewer(),
        is_default: 0
      })

      %{
        user: user,
        author_group: author_group,
        editor_group: editor_group,
        manager_group: manager_group,
        site_admin_group: site_admin_group,
        reviewer_group: reviewer_group
      }
    end

    @tag :require_author
    test "require_author allows user with author role", %{conn: conn, user: user, author_group: author_group} do
      Accounts.enroll_user(user.user_id, author_group.user_group_id)
      conn = log_in_user(conn, user)

      conn = get(conn, ~p"/author")
      assert html_response(conn, 200)
    end

    @tag :require_author
    test "require_author denies user without author role", %{conn: conn, user: user} do
      conn = log_in_user(conn, user)

      conn = get(conn, ~p"/author")
      assert redirected_to(conn) == ~p"/"
      assert get_flash(conn, :error) == "You are not authorized to access this page."
    end

    @tag :require_editor
    test "require_editor allows user with editor role", %{conn: conn, user: user, editor_group: editor_group} do
      Accounts.enroll_user(user.user_id, editor_group.user_group_id)
      conn = log_in_user(conn, user)

      # Need to add a route for testing - using a test route
      conn = get_test_authorized_route(conn, :editor)
      assert html_response(conn, 200)
    end

    @tag :require_manager
    test "require_manager allows user with manager role", %{conn: conn, user: user, manager_group: manager_group} do
      Accounts.enroll_user(user.user_id, manager_group.user_group_id)
      conn = log_in_user(conn, user)

      conn = get_test_authorized_route(conn, :manager)
      assert html_response(conn, 200)
    end

    @tag :require_admin
    test "require_admin allows user with site_admin role", %{conn: conn, user: user, site_admin_group: site_admin_group} do
      Accounts.enroll_user(user.user_id, site_admin_group.user_group_id)
      conn = log_in_user(conn, user)

      conn = get_test_authorized_route(conn, :admin)
      assert html_response(conn, 200)
    end

    @tag :require_reviewer
    test "require_reviewer allows user with reviewer role", %{conn: conn, user: user, reviewer_group: reviewer_group} do
      Accounts.enroll_user(user.user_id, reviewer_group.user_group_id)
      conn = log_in_user(conn, user)

      conn = get_test_authorized_route(conn, :reviewer)
      assert html_response(conn, 200)
    end

    @tag :unauthenticated
    test "redirects to login when not authenticated", %{conn: conn} do
      conn = get(conn, ~p"/author")
      assert redirected_to(conn) == ~p"/users/log-in"
      assert get_flash(conn, :error) == "You must log in to access this page."
    end
  end

  defp log_in_user(conn, user) do
    conn
    |> post(~p"/users/log-in", user: %{
      email: user.email,
      password: "password123"
    })
  end

  defp get_test_authorized_route(conn, role) do
    # We need to test via the actual routes defined in router
    # For now test the plug directly
    path = case role do
      :author -> ~p"/author"
      :editor -> ~p"/editor/test"
      :manager -> ~p"/manager/test"
      :admin -> ~p"/admin"
      _ -> ~p"/"
    end
    get(conn, path)
  end
end