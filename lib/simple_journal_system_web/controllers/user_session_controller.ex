defmodule SimpleJournalSystemWeb.UserSessionController do
  use SimpleJournalSystemWeb, :controller

  alias SimpleJournalSystem.Accounts
  alias SimpleJournalSystemWeb.UserAuth

  # Login menggunakan email/username + password (flow OJS)
  def create(conn, %{"user" => user_params}) do
    %{
      "email" => email,
      "password" => password
    } = user_params

    if user = Accounts.get_user_by_email_and_password(email, password) do
      conn
      |> put_flash(:info, "Welcome back!")
      |> UserAuth.log_in_user(user, user_params)
    else
      conn
      |> put_flash(:error, "Invalid email or password")
      |> redirect(to: ~p"/users/log-in")
    end
  end

  # Logout
  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully.")
    |> UserAuth.log_out_user()
  end
end
