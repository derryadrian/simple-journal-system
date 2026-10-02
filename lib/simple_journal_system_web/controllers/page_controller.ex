defmodule SimpleJournalSystemWeb.PageController do
  use SimpleJournalSystemWeb, :controller

  alias SimpleJournalSystem.Journals
  alias SimpleJournalSystemWeb.Plugs.JournalResolver

  def home(conn, _params) do
    current_journal = JournalResolver.current_journal(conn)
    user_journals = if conn.assigns[:current_scope] && conn.assigns.current_scope.user do
      Journals.list_user_journals(conn.assigns.current_scope.user.user_id)
    else
      Journals.list_enabled_journals()
    end

    render(conn, :home, current_journal: current_journal, user_journals: user_journals)
  end
end
