defmodule SimpleJournalSystemWeb.PageController do
  use SimpleJournalSystemWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
