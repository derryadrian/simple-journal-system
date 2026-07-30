defmodule SimpleJournalSystemWeb.IssueLive do
  use SimpleJournalSystemWeb, :live_view
  alias SimpleJournalSystem.OjsApi

  def mount(_params, _session, socket) do
    issues = case OjsApi.get_issues() do
      {:ok, data} -> data
      {:error, _} -> []
    end

    {:ok, assign(socket, issues: issues)}
  end

  def render(assigns) do
    ~H"""
    <div class="p-8 max-w-5xl mx-auto">
      <h2 class="text-3xl font-extrabold text-gray-900 mb-6">Arsip Terbitan Jurnal</h2>

      <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
        <div :for={issue <- @issues} class="border rounded-lg p-5 shadow-sm bg-white">
          <h3 class="font-bold text-lg text-blue-600">
            Volume <%= issue["volume"] %>, Nomor <%= issue["number"] %> (<%= issue["year"] %>)
          </h3>
          <p class="text-sm text-gray-600 mt-2 line-clamp-3">
            <%= raw(issue["description"]) %>
          </p>
        </div>
      </div>
    </div>
    """
  end
end
