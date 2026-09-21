defmodule SimpleJournalSystemWeb.AuthorLive do
  @moduledoc """
  Halaman sementara untuk area Author.

  Minimal placeholder agar route /author dapat dirender.
  Fitur author sebenarnya dikerjakan terpisah.
  """
  use SimpleJournalSystemWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <div class="mx-auto max-w-3xl space-y-4">
        <.header>
          Author Dashboard
          <:subtitle>Area khusus Author</:subtitle>
        </.header>
        <p class="text-sm text-zinc-500">
          Login sebagai {@current_scope.user.email}. Fitur author akan dikerjakan terpisah.
        </p>
      </div>
    </Layouts.app>
    """
  end
end
