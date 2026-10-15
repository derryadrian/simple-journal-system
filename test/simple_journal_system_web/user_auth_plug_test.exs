defmodule SimpleJournalSystemWeb.UserAuthPlugTest do
  use SimpleJournalSystemWeb.ConnCase

  import SimpleJournalSystem.AccountsFixtures

  alias SimpleJournalSystem.Accounts
  alias SimpleJournalSystem.Accounts.Roles
  alias SimpleJournalSystem.Accounts.Scope
  alias SimpleJournalSystem.Accounts.User
  alias SimpleJournalSystem.Repo
  alias SimpleJournalSystemWeb.UserAuth

  describe "role plugs (dipanggil langsung)" do
    setup %{conn: conn} do
      conn =
        conn
        |> init_test_session(%{})
        |> Phoenix.Controller.fetch_flash([])

      %{conn: conn}
    end

    test "require_author meloloskan user dengan role author", %{conn: conn} do
      user = enrolled_user(Roles.author(), 1)
      conn = conn |> with_scope(user) |> UserAuth.require_author([])
      refute conn.halted
    end

    test "require_editor meloloskan user dengan role editor", %{conn: conn} do
      user = enrolled_user(Roles.editor(), 1)
      conn = conn |> with_scope(user) |> UserAuth.require_editor([])
      refute conn.halted
    end

    test "require_manager meloloskan user dengan role manager", %{conn: conn} do
      user = enrolled_user(Roles.manager(), 1)
      conn = conn |> with_scope(user) |> UserAuth.require_manager([])
      refute conn.halted
    end

    test "require_admin meloloskan user dengan role site admin", %{conn: conn} do
      user = enrolled_user(Roles.site_admin(), nil)
      conn = conn |> with_scope(user) |> UserAuth.require_admin([])
      refute conn.halted
    end

    test "require_reviewer meloloskan user dengan role reviewer", %{conn: conn} do
      user = enrolled_user(Roles.reviewer(), 1)
      conn = conn |> with_scope(user) |> UserAuth.require_reviewer([])
      refute conn.halted
    end

    test "require_author menolak user yang hanya punya role editor", %{conn: conn} do
      user = enrolled_user(Roles.editor(), 1)
      conn = conn |> with_scope(user) |> UserAuth.require_author([])

      assert conn.halted
      assert redirected_to(conn) == ~p"/"
      assert Phoenix.Flash.get(conn.assigns.flash, :error) == "You are not authorized to access this page."
    end

    test "require_author menolak user tanpa role apa pun", %{conn: conn} do
      user = user_fixture() |> Repo.preload(user_user_groups: :user_group)
      conn = conn |> with_scope(user) |> UserAuth.require_author([])

      assert conn.halted
      assert redirected_to(conn) == ~p"/"
    end

    test "require_role mengarahkan ke login kalau belum login", %{conn: conn} do
      conn = UserAuth.require_author(conn, [])

      assert conn.halted
      assert redirected_to(conn) == ~p"/users/log-in"
    end
  end

  describe "lewat router" do
    test "user tanpa role author ditolak dan diarahkan ke halaman utama", %{conn: conn} do
      user = user_fixture()
      conn = conn |> login_via_form(user) |> get(~p"/author")

      assert redirected_to(conn) == ~p"/"
    end

    test "belum login diarahkan ke halaman login", %{conn: conn} do
      conn = get(conn, ~p"/author")

      assert redirected_to(conn) == ~p"/users/log-in"
    end
  end

  defp enrolled_user(role_id, context_id) do
    user = user_fixture()

    {:ok, group} =
      Accounts.create_user_group(%{context_id: context_id, role_id: role_id, is_default: 0})

    {:ok, :enrolled} = Accounts.enroll_user(user.user_id, group.user_group_id, user.user_id)

    User
    |> Repo.get!(user.user_id)
    |> Repo.preload(user_user_groups: :user_group)
  end

  defp with_scope(conn, user), do: assign(conn, :current_scope, Scope.for_user(user))

  defp login_via_form(conn, user) do
    post(conn, ~p"/users/log-in", user: %{email: user.email, password: "password123"})
  end
end
