defmodule SimpleJournalSystemWeb.UserLive.SettingsTest do
  use SimpleJournalSystemWeb.ConnCase

  import Phoenix.LiveViewTest
  import SimpleJournalSystem.AccountsFixtures

  alias SimpleJournalSystem.Accounts

  describe "Settings page" do
    test "renders settings page", %{conn: conn} do
      user = user_fixture()
      {:ok, _lv, html} = conn |> log_in_user(user) |> live(~p"/users/settings")

      assert html =~ "Account Settings"
      assert html =~ user.email
    end

    test "redirects to login if user is not logged in", %{conn: conn} do
      assert {:error, redirect} = live(conn, ~p"/users/settings")
      assert {:redirect, %{to: path}} = redirect
      assert path == ~p"/users/log-in"
    end
  end

  describe "update password form" do
    setup %{conn: conn} do
      user = user_fixture()
      %{conn: log_in_user(conn, user), user: user}
    end

    test "renders errors with invalid data (phx-change)", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/users/settings")

      result =
        lv
        |> element("#password_form")
        |> render_change(%{
          "user" => %{
            "current_password" => "password123",
            "password" => "short",
            "password_confirmation" => "different"
          }
        })

      assert result =~ "at least 6 character"
      assert result =~ "tidak sama dengan password"
    end

    test "renders error when current password is wrong", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/users/settings")

      result =
        lv
        |> form("#password_form", %{
          "user" => %{
            "current_password" => "salah-total",
            "password" => "newpassword123",
            "password_confirmation" => "newpassword123"
          }
        })
        |> render_submit()

      assert result =~ "is not valid"
    end

    test "updates the user password", %{conn: conn, user: user} do
      {:ok, lv, _html} = live(conn, ~p"/users/settings")

      form =
        form(lv, "#password_form", %{
          "user" => %{
            "current_password" => "password123",
            "password" => "newpassword123",
            "password_confirmation" => "newpassword123"
          }
        })

      render_submit(form)
      new_password_conn = follow_trigger_action(form, conn)

      assert redirected_to(new_password_conn) == ~p"/users/settings"
      assert Accounts.get_user_by_email_and_password(user.email, "newpassword123")
    end
  end
end
