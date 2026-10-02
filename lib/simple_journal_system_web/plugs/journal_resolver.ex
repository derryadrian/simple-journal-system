defmodule SimpleJournalSystemWeb.Plugs.JournalResolver do
  @moduledoc """
  Resolves the current journal from the request path.
  
  OJS-style: /journal-path/... -> resolves journal by path
  Site Admin bypass: users with site_admin role skip journal requirement
  """

  import Plug.Conn
  alias SimpleJournalSystem.Journals
  alias SimpleJournalSystem.Accounts.Roles
  alias SimpleJournalSystem.Authorization

  def init(opts), do: opts

  def call(conn, _opts) do
    # Get journal from path
    journal = resolve_journal_from_path(conn)
    
    # Store in assigns for easy access in controllers/views
    conn = assign(conn, :current_journal, journal)
    
    # Also store in session for persistence across requests
    if journal do
      conn = put_session(conn, :current_journal_id, journal.journal_id)
      conn = put_session(conn, :current_journal_path, journal.path)
    end
    
    conn
  end

  defp resolve_journal_from_path(conn) do
    # Extract first path segment as potential journal path
    path_info = conn.request_path
    first_segment = path_info |> String.trim_leading("/") |> String.split("/") |> List.first()
    
    # Skip non-journal paths
    if is_special_path?(first_segment) do
      get_journal_from_session(conn)
    else
      case Journals.get_journal_by_path(first_segment) do
        %{} = journal -> journal
        nil -> get_journal_from_session(conn)
      end
    end
  end

  defp is_special_path?(segment) do
    special_paths = [
      "users", "admin", "author", "editor", "reviewer", 
      "manager", "dev", "api", "assets", "images", "css", "js",
      "live", "websocket", "favicon.ico", "robots.txt"
    ]
    segment in special_paths
  end

  defp get_journal_from_session(conn) do
    journal_id = get_session(conn, :current_journal_id)
    
    if journal_id do
      Journals.get_journal!(journal_id)
    else
      # Fallback: first enabled journal
      Journals.list_enabled_journals() |> List.first()
    end
  end

  @doc """
  Checks if current user is Site Admin (bypasses journal restriction).
  """
  def site_admin_bypass?(conn) do
    case conn.assigns[:current_scope] do
      %{user: user} when not is_nil(user) ->
        Authorization.is_site_admin?(user)
      _ ->
        false
    end
  end

  @doc """
  Gets current journal for the connection.
  """
  def current_journal(conn) do
    conn.assigns[:current_journal]
  end

  @doc """
  Sets current journal (for journal switching).
  """
  def put_current_journal(conn, journal) do
    conn
    |> assign(:current_journal, journal)
    |> put_session(:current_journal_id, journal.journal_id)
    |> put_session(:current_journal_path, journal.path)
  end
end