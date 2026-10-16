#!/usr/bin/env bash
# Jalankan dari folder project (yang ada mix.exs):  bash apply_fix2.sh

cd "$(dirname "$0")" || exit 1
if [ ! -f mix.exs ]; then
  echo "File ini harus ada di folder project (yang ada mix.exs)."
  exit 1
fi

echo "== 1. export_users_csv: results sudah berupa list"
sed -i 's#Enum.map(results.users, fn user ->#Enum.map(results, fn user ->#' lib/simple_journal_system/accounts.ex

echo "== 2. controller update_password: login langsung setelah ganti password"
C=lib/simple_journal_system_web/controllers/user_session_controller.ex
sed -i 's#def update_password(conn, %{"user" => user_params} = params) do#def update_password(conn, %{"user" => user_params}) do#' $C
sed -i 's#{:ok, _user} ->#{:ok, user} ->#' $C
sed -i 's#^        |> create(params, "Password updated successfully!")#        |> put_flash(:info, "Password updated successfully!")\n        |> UserAuth.log_in_user(user)#' $C
grep -n "log_in_user(user)" $C

echo "== 3. registration.ex: buang debug yang mencetak password ke log"
R=lib/simple_journal_system_web/live/user_live/registration.ex
sed -i '/IO\.inspect(.*label: "[^"]*REGISTER/d' $R
sed -i 's#{:ok, user} ->#{:ok, _user} ->#' $R
grep -c "IO.inspect" $R

echo "== 4. login_test.exs"
cat > test/simple_journal_system_web/live/user_live/login_test.exs <<'EOF_LOGIN'
defmodule SimpleJournalSystemWeb.UserLive.LoginTest do
  use SimpleJournalSystemWeb.ConnCase

  import Phoenix.LiveViewTest
  import SimpleJournalSystem.AccountsFixtures

  describe "login page" do
    test "renders login page", %{conn: conn} do
      {:ok, _lv, html} = live(conn, ~p"/users/log-in")

      assert html =~ "Login"
      assert html =~ "Register"
      assert html =~ "Keep me logged in"
    end

    test "has a link to the registration page", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/users/log-in")

      assert has_element?(lv, ~s(main a[href="/users/register"]), "Register")
    end
  end

  describe "user login - password" do
    test "redirects if user logs in with valid credentials", %{conn: conn} do
      user = user_fixture()

      {:ok, lv, _html} = live(conn, ~p"/users/log-in")

      form =
        form(lv, "#login_form",
          user: %{email: user.email, password: valid_user_password(), remember_me: true}
        )

      conn = submit_form(form, conn)

      assert redirected_to(conn) == ~p"/"
    end

    test "redirects to login page with a flash error if credentials are invalid", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/users/log-in")

      form = form(lv, "#login_form", user: %{email: "test@email.com", password: "123456"})

      render_submit(form)

      conn = follow_trigger_action(form, conn)
      assert Phoenix.Flash.get(conn.assigns.flash, :error) == "Invalid email or password"
      assert redirected_to(conn) == ~p"/users/log-in"
    end
  end
end
EOF_LOGIN

echo "== 5. registration_test.exs"
cat > test/simple_journal_system_web/live/user_live/registration_test.exs <<'EOF_REG'
defmodule SimpleJournalSystemWeb.UserLive.RegistrationTest do
  use SimpleJournalSystemWeb.ConnCase

  import Phoenix.LiveViewTest
  import SimpleJournalSystem.AccountsFixtures

  alias SimpleJournalSystem.Accounts

  describe "Registration page" do
    test "renders registration page", %{conn: conn} do
      {:ok, _lv, html} = live(conn, ~p"/users/register")

      assert html =~ "Register"
      assert html =~ "Username"
      assert html =~ "Email"
    end

    test "redirects if already logged in", %{conn: conn} do
      result =
        conn
        |> log_in_user(user_fixture())
        |> live(~p"/users/register")
        |> follow_redirect(conn, ~p"/")

      assert {:ok, _conn} = result
    end

    test "renders errors for invalid data", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/users/register")

      result =
        lv
        |> element("#registration_form")
        |> render_change(user: %{"email" => "with spaces"})

      assert result =~ "format email tidak valid"
    end

    test "has a link to the login page", %{conn: conn} do
      {:ok, _lv, html} = live(conn, ~p"/users/register")

      assert html =~ "/users/log-in"
    end
  end

  describe "register user" do
    test "creates account and redirects to the login page", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/users/register")

      email = unique_user_email()
      form = form(lv, "#registration_form", user: valid_user_attributes(email: email))

      {:ok, _lv, _html} =
        render_submit(form)
        |> follow_redirect(conn, ~p"/users/log-in")

      assert Accounts.get_user_by_email(email)
    end

    test "renders errors for duplicated email", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/users/register")

      user = user_fixture()

      result =
        lv
        |> form("#registration_form", user: valid_user_attributes(email: user.email))
        |> render_submit()

      assert result =~ "has already been taken"
    end
  end
end
EOF_REG

echo "== Perubahan:"
git --no-pager diff --stat
echo
echo "== Sisa IO.inspect / IO.puts di lib (debug yang mungkin tertinggal):"
grep -rn "IO\.inspect\|IO\.puts" lib | tr -d '\r' | cut -c1-140

echo
echo "== Menjalankan test (agak lama)..."
mix test > hasil_test.txt 2>&1
grep -E "tests,|failures|\*\* \(Compile" hasil_test.txt
echo
echo "Selesai. Tempel semua tulisan di atas ke chat."
