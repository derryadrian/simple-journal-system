defmodule SimpleJournalSystemWeb.UserAuthRoleTest do
  use SimpleJournalSystemWeb.ConnCase, async: true

  alias SimpleJournalSystem.Authorization
  alias SimpleJournalSystemWeb.UserAuth

  import SimpleJournalSystem.RolesFixtures

  setup %{conn: conn} do
    conn =
      conn
      |> Map.replace!(:secret_key_base, SimpleJournalSystemWeb.Endpoint.config(:secret_key_base))
      |> Phoenix.ConnTest.init_test_session(%{})
      |> fetch_flash()

    %{conn: conn}
  end

  describe "require_role/2" do
    test "allows an authenticated user that has the required role", %{conn: conn} do
      user = user_with_role_fixture(Authorization.role_author())
      conn = log_in(conn, user)

      conn = UserAuth.require_role(conn, Authorization.role_author())

      refute conn.halted
    end

    test "redirects an authenticated user that does not have the required role", %{conn: conn} do
      user = user_with_role_fixture(Authorization.role_reader())
      conn = log_in(conn, user)

      conn = UserAuth.require_role(conn, Authorization.role_author())

      assert conn.halted
      assert redirected_to(conn) == ~p"/"

      assert Phoenix.Flash.get(conn.assigns.flash, :error) ==
               "You are not authorized to access this page."
    end

    test "redirects an authenticated user without any role", %{conn: conn} do
      user = user_fixture()
      conn = log_in(conn, user)

      conn = UserAuth.require_role(conn, Authorization.role_author())

      assert conn.halted
      assert redirected_to(conn) == ~p"/"
    end

    test "allows an authenticated user with multiple roles when one matches", %{conn: conn} do
      user =
        user_with_roles_fixture([Authorization.role_reader(), Authorization.role_author()])

      conn = log_in(conn, user)

      conn = UserAuth.require_role(conn, Authorization.role_author())

      refute conn.halted
    end

    test "redirects an unauthenticated user to the login page", %{conn: conn} do
      conn = UserAuth.require_role(conn, Authorization.role_author())

      assert conn.halted
      assert redirected_to(conn) == ~p"/users/log-in"
    end
  end

  describe "require_author/2" do
    test "allows an authenticated author", %{conn: conn} do
      user = user_with_role_fixture(Authorization.role_author())
      conn = log_in(conn, user)

      conn = UserAuth.require_author(conn, [])

      refute conn.halted
    end

    test "redirects an authenticated non-author", %{conn: conn} do
      user = user_with_role_fixture(Authorization.role_manager())
      conn = log_in(conn, user)

      conn = UserAuth.require_author(conn, [])

      assert conn.halted
      assert redirected_to(conn) == ~p"/"

      assert Phoenix.Flash.get(conn.assigns.flash, :error) ==
               "You are not authorized to access this page."
    end

    test "redirects an authenticated user without any role", %{conn: conn} do
      user = user_fixture()
      conn = log_in(conn, user)

      conn = UserAuth.require_author(conn, [])

      assert conn.halted
      assert redirected_to(conn) == ~p"/"
    end

    test "redirects an unauthenticated user to the login page", %{conn: conn} do
      conn = UserAuth.require_author(conn, [])

      assert conn.halted
      assert redirected_to(conn) == ~p"/users/log-in"
    end
  end

  defp log_in(conn, user) do
    token = SimpleJournalSystem.Accounts.generate_user_session_token(user)

    conn
    |> Phoenix.ConnTest.init_test_session(%{})
    |> Plug.Conn.put_session(:user_token, token)
    |> SimpleJournalSystemWeb.UserAuth.fetch_current_scope_for_user([])
  end
end
