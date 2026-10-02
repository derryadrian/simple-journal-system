defmodule SimpleJournalSystemWeb.JournalController do
  use SimpleJournalSystemWeb, :controller

  alias SimpleJournalSystem.Journals
  alias SimpleJournalSystemWeb.Plugs.JournalResolver

  def switch(conn, %{"journal_id" => journal_id}) do
    user = conn.assigns.current_scope.user
    
    case Journals.switch_journal(user.user_id, String.to_integer(journal_id)) do
      {:ok, journal} ->
        conn
        |> JournalResolver.put_current_journal(journal)
        |> put_flash(:info, "Switched to #{journal.path}")
        |> redirect(to: ~p"/")
      
      {:error, :no_access} ->
        conn
        |> put_flash(:error, "You don't have access to this journal")
        |> redirect(to: ~p"/")
    end
  end

  def list(conn, _params) do
    user = conn.assigns.current_scope.user
    journals = Journals.list_user_journals(user.user_id)
    current_journal = conn.assigns[:current_journal]
    
    render(conn, "list.html", journals: journals, current_journal: current_journal)
  end
end