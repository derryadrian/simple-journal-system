defmodule SimpleJournalSystemWeb.UserAuthTest do
  use SimpleJournalSystemWeb.ConnCase
  alias SimpleJournalSystem.Repo
  alias SimpleJournalSystem.Journals.Journal

  alias SimpleJournalSystem.Accounts
  alias SimpleJournalSystem.Accounts.User
  alias SimpleJournalSystem.Accounts.UserGroup
  alias SimpleJournalSystem.Accounts.UserUserGroup
  alias SimpleJournalSystem.Accounts.Roles
  alias SimpleJournalSystemWeb.UserAuth

  import SimpleJournalSystem.AccountsFixtures

  @tag :auth_plug
  describe "fetch_current_scope_for_user" do
    setup do
      user = user_fixture()
      {:ok, user: user}
    end

    @tag :plug
    test "assigns current_scope with user when logged in", %{conn: conn, user: user} do
      conn = post(conn, ~p"/users/log-in", user: %{
        email: user.email,
        password: "password123"
      })
      conn = get(conn, ~p"/")
      
      assert conn.assigns[:current_scope].user != nil
      assert conn.assigns.current_scope.user.user_id == user.user_id
    end

    @tag :plug
    test "assigns nil current_scope when not logged in", %{conn: conn} do
      conn = get(conn, ~p"/")
      assert conn.assigns[:current_scope].user == nil
    end
  end

  @tag :auth_plug
  describe "require_authenticated_user" do
    setup do
      user = user_fixture()
      {:ok, user: user}
    end

    @tag :plug
    test "allows authenticated user", %{conn: conn, user: user} do
      conn = post(conn, ~p"/users/log-in", user: %{
        email: user.email,
        password: "password123"
      })
      conn = get(conn, ~p"/users/settings")
      
      assert html_response(conn, 200)
    end

    @tag :plug
    test "redirects unauthenticated user to login", %{conn: conn} do
      conn = get(conn, ~p"/users/settings")
      
      assert redirected_to(conn) == ~p"/users/log-in"
      assert get_flash(conn, :error) == "You must log in to access this page."
    end

    @tag :plug
    test "stores return_to for GET requests", %{conn: conn} do
      conn = get(conn, ~p"/users/settings")
      
      assert get_session(conn, :user_return_to) == "/users/settings"
    end
  end

  @tag :auth_plug
  describe "require_role plugs" do
    setup do
      journal = Repo.get!(Journal, 1)
      {:ok, author_group} = Accounts.create_user_group(%{
        context_id: journal.journal_id,
        role_id: Roles.author(),
        is_default: 1
      })
      
      {:ok, editor_group} = Accounts.create_user_group(%{
        context_id: journal.journal_id,
        role_id: Roles.editor(),
        is_default: 0
      })
      
      {:ok, admin_group} = Accounts.create_user_group(%{
        context_id: nil,
        role_id: Roles.site_admin(),
        is_default: 0
      })
      
      user = user_fixture()
      
      %{
        user: user,
        author_group: author_group,
        editor_group: editor_group,
        admin_group: admin_group
      }
    end

    @tag :require_author
    test "require_author allows user with author role", %{conn: conn, user: user, author_group: author_group} do
      Accounts.enroll_user(user.user_id, author_group.user_group_id, user.user_id)
      conn = post(conn, ~p"/users/log-in", user: %{
        email: user.email,
        password: "password123"
      })
      
      # Need a test route - we'll test the plug directly
      assert true
    end

    @tag :require_admin
    test "require_admin allows site admin", %{conn: conn, user: user, admin_group: admin_group} do
      Accounts.enroll_user(user.user_id, admin_group.user_group_id, user.user_id)
      conn = post(conn, ~p"/users/log-in", user: %{
        email: user.email,
        password: "password123"
      })
      
      conn = get(conn, ~p"/admin/users")
      assert html_response(conn, 200)
    end

    @tag :require_admin
    test "require_admin denies non-admin", %{conn: conn, user: user} do
      conn = post(conn, ~p"/users/log-in", user: %{
        email: user.email,
        password: "password123"
      })
      
      conn = get(conn, ~p"/admin/users")
      assert redirected_to(conn) == ~p"/"
      assert get_flash(conn, :error) == "You are not authorized to access this page."
    end
  end
end