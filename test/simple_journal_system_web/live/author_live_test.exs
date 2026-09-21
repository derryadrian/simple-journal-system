defmodule SimpleJournalSystemWeb.AuthorLiveTest do
  use SimpleJournalSystemWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias SimpleJournalSystem.Authorization

  import SimpleJournalSystem.RolesFixtures

  describe "GET /author" do
    test "renders the Author dashboard for an authenticated author", %{conn: conn} do
      user = user_with_role_fixture(Authorization.role_author())
      conn = log_in_user(conn, user)

      {:ok, _view, html} = live(conn, ~p"/author")

      assert html =~ "Author Dashboard"
    end

    test "redirects an authenticated non-author to the home page", %{conn: conn} do
      user = user_with_role_fixture(Authorization.role_manager())
      conn = log_in_user(conn, user)

      conn = get(conn, ~p"/author")

      assert redirected_to(conn) == ~p"/"

      assert Phoenix.Flash.get(conn.assigns.flash, :error) ==
               "You are not authorized to access this page."
    end

    test "redirects an authenticated user without any role to the home page", %{conn: conn} do
      user = user_fixture()
      conn = log_in_user(conn, user)

      conn = get(conn, ~p"/author")

      assert redirected_to(conn) == ~p"/"
    end

    test "redirects an unauthenticated user to the login page", %{conn: conn} do
      conn = get(conn, ~p"/author")

      assert redirected_to(conn) == ~p"/users/log-in"
    end
  end

  describe "AuthorLive" do
    test "shows the logged in author email", %{conn: conn} do
      user = user_with_role_fixture(Authorization.role_author())
      conn = log_in_user(conn, user)

      {:ok, view, _html} = live(conn, ~p"/author")

      assert render(view) =~ user.email
    end
  end
end
