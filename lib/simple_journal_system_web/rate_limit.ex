defmodule SimpleJournalSystemWeb.RateLimit do
  @moduledoc """
  Rate limiting untuk percobaan login, memakai Hammer 7 (backend ETS).

  Aturan: maksimal 5 percobaan gagal per 15 menit untuk setiap
  kombinasi IP + email.

  Modul ini harus dijalankan di supervision tree (lihat application.ex).
  """

  use Hammer, backend: :ets

  @max_attempts 5
  @window_ms 15 * 60 * 1000

  def check_login_limit(identifier) do
    count = get(key(identifier), @window_ms)

    if count >= @max_attempts do
      {:error, @window_ms}
    else
      {:ok, @max_attempts - count}
    end
  end

  def increment_login_attempt(identifier) do
    inc(key(identifier), @window_ms)
  end

  def reset_login_attempts(identifier) do
    set(key(identifier), @window_ms, 0)
  end

  def get_identifier_for_email(conn, email) do
    ip = get_client_ip(conn)
    "#{ip}:#{String.downcase(email)}"
  end

  defp key(identifier), do: "login:#{identifier}"

  defp get_client_ip(conn) do
    case conn.req_headers do
      [{"x-forwarded-for", ip} | _] -> ip
      [{"x-real-ip", ip} | _] -> ip
      _ ->
        case conn.remote_ip do
          {_, _, _, _} = ip_tuple ->
            ip_tuple |> Tuple.to_list() |> Enum.join(".")

          ip when is_binary(ip) ->
            ip

          _ ->
            "unknown"
        end
    end
  end
end
