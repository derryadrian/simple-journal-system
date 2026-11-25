defmodule SimpleJournalSystemWeb.Api.RegisterController do
  use SimpleJournalSystemWeb, :controller

  def create(conn, params) do
    email = params["email"]
    device_id = params["device_id"]

    if email && device_id do
      conn
      |> put_status(:ok)
      |> json(%{
        status: "success",
        message: "Endpoint API SJS berhasil dihubungi!",
        data: %{email: email, device_id: device_id}
      })
    else
      conn
      |> put_status(:bad_request)
      |> json(%{error: "Data tidak lengkap"})
    end
  end
end
