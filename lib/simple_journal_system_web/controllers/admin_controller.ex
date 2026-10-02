defmodule SimpleJournalSystemWeb.AdminController do
  use SimpleJournalSystemWeb, :controller

  alias SimpleJournalSystem.Accounts

  def export_users(conn, params) do
    # Filters come from query params
    filters = Enum.into(params, %{})
    csv = Accounts.export_users_csv(filters)
    
    conn
    |> put_resp_header("content-type", "text/csv")
    |> put_resp_header("content-disposition", "attachment; filename=users_export.csv")
    |> send_resp(200, csv)
  end
end