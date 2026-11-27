defmodule SimpleJournalSystemWeb.Api.RegisterController do
  use SimpleJournalSystemWeb, :controller

  alias SimpleJournalSystem.Accounts

  def create(conn, params) do
    user_params = %{
      "username" => params["username"],
      "email" => params["email"],
      "password" => params["password"],
      "password_confirmation" => params["password"]
    }

    case Accounts.register_user(user_params) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> json(%{
          status: "success",
          message: "User berhasil didaftarkan.",
          data: %{
            user_id: user.user_id,
            username: user.username,
            email: user.email
          }
        })

      {:error, changeset} ->
        # Ambil error langsung dari changeset.errors
        # Formatnya: [email: {"has already been taken", []}, ...]
        formatted_errors =
          Enum.reduce(changeset.errors, %{}, fn {field, {msg, _opts}}, acc ->
            Map.put(acc, field, msg)
          end)

        conn
        |> put_status(:unprocessable_entity)
        |> json(%{status: "error", errors: formatted_errors})
    end
  end
end
