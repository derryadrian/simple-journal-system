defmodule SimpleJournalSystemWeb.JournalController do
  use SimpleJournalSystemWeb, :controller

  def index(conn, _params) do
    journals = [%{name: "bebas", slug: "bebas"}, %{name: "bebas2", slug: "bebas2"}]
    
    conn
    |> put_layout(html: {SimpleJournalSystemWeb.Layouts, :app})
    |> render(:index, journals: journals)
  end

  def current(conn, %{"slug" => slug}) do
    conn
    |> assign(:journal_name, slug)
    |> put_layout(html: {SimpleJournalSystemWeb.Layouts, :journal})
    |> render(:current)
  end

  def archive(conn, %{"slug" => slug}) do
    conn
    |> assign(:journal_name, slug)
    |> put_layout(html: {SimpleJournalSystemWeb.Layouts, :journal})
    |> render(:archive)
  end

  def about(conn, %{"slug" => slug}) do
    conn
    |> assign(:journal_name, slug)
    |> put_layout(html: {SimpleJournalSystemWeb.Layouts, :journal})
    |> render(:about)
  end

  def submissions(conn, %{"slug" => slug}) do
    conn
    |> assign(:journal_name, slug)
    |> put_layout(html: {SimpleJournalSystemWeb.Layouts, :journal})
    |> render(:submissions)
  end

  def editorial_team(conn, %{"slug" => slug}) do
    conn
    |> assign(:journal_name, slug)
    |> put_layout(html: {SimpleJournalSystemWeb.Layouts, :journal})
    |> render(:editorial_team)
  end

  def privacy(conn, %{"slug" => slug}) do
    conn
    |> assign(:journal_name, slug)
    |> put_layout(html: {SimpleJournalSystemWeb.Layouts, :journal})
    |> render(:privacy)
  end

  def contact(conn, %{"slug" => slug}) do
  conn
  |> assign(:journal_name, slug)
  |> put_layout(html: {SimpleJournalSystemWeb.Layouts, :journal})
  |> render(:contact)
end
end