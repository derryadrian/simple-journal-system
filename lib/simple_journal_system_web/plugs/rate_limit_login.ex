defmodule SimpleJournalSystemWeb.Plugs.RateLimitLogin do
  @moduledoc """
  Plug to rate limit login attempts.
  """

  import Plug.Conn
  alias SimpleJournalSystemWeb.RateLimit

  def init(opts), do: opts

  def call(conn, _opts) do
    identifier = RateLimit.get_identifier_for_email(conn, conn.params["user"] |> Map.get("email", ""))

    case RateLimit.check_login_limit(identifier) do
      {:ok, _remaining} ->
        conn
      {:error, retry_after_ms} ->
        conn
        |> put_resp_header("Retry-After", "#{div(retry_after_ms, 1000)}")
        |> send_resp(429, "Too Many Requests. Please try again later.")
        |> halt()
    end
  end
end