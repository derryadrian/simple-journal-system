defmodule SimpleJournalSystemWeb.RateLimit do
  @moduledoc """
  Rate limiting for login attempts using Hammer.
  """

  use Hammer,
    backend: :ets,
    expiry_ms: 15 * 60 * 1000 # 15 minutes

  @doc """
  Checks rate limit for login attempts.
  Returns {:ok, remaining} or {:error, retry_after_ms}
  """
  def check_login_limit(identifier) do
    case Hammer.check_rate(__MODULE__, "login:#{identifier}", 5, 15 * 60) do
      {:allow, count, _} ->
        {:ok, 5 - count}
      {:deny, _count, retry_after} ->
        {:error, retry_after}
    end
  end

  @doc """
  Increments login attempt counter.
  """
  def increment_login_attempt(identifier) do
    Hammer.increment(__MODULE__, "login:#{identifier}")
  end

  @doc """
  Resets login attempts on successful login.
  """
  def reset_login_attempts(identifier) do
    Hammer.delete(__MODULE__, "login:#{identifier}")
  end

  @doc """
  Gets rate limit identifier for email login.
  """
  def get_identifier_for_email(conn, email) do
    ip = get_client_ip(conn)
    "#{ip}:#{String.downcase(email)}"
  end

  defp get_client_ip(conn) do
    case conn.req_headers do
      [{"x-forwarded-for", ip} | _] -> ip
      [{"x-real-ip", ip} | _] -> ip
      _ ->
        case conn.remote_ip do
          {_, _, _, _} = ip_tuple ->
            ip_tuple |> Tuple.to_list() |> Enum.join(".")
          ip when is_binary(ip) -> ip
          _ -> "unknown"
        end
    end
  end
end