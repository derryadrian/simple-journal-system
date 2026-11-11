defmodule SimpleJournalSystemWeb.AuthorLive do
  @moduledoc """
  Halaman awal author. Sementara masih kosong; wizard submission
  akan dibangun di sini.
  """
  use SimpleJournalSystemWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <.header>
        Author
        <:subtitle>Halaman ini akan berisi daftar dan wizard submission.</:subtitle>
      </.header>
    </Layouts.app>
    """
  end
end
