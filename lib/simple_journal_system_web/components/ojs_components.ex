defmodule SimpleJournalSystemWeb.OjsComponents do
  use Phoenix.Component

  attr :current_scope, :any, default: nil

  def ojs_header(assigns) do
    ~H"""
    <header class="bg-[#1b629b] text-white px-8 py-5 flex justify-between items-center shadow-sm">
      <div class="flex items-center gap-2">
        <a href="/" class="flex items-end gap-2">
          <span class="text-5xl font-serif font-bold leading-none">
            OJS
          </span>

          <div class="border-t border-white/80 pt-0.5 text-[10px] uppercase tracking-widest leading-none">
            OPEN JOURNAL SYSTEMS
          </div>
        </a>
      </div>

      <nav class="flex items-center gap-6 text-sm font-medium">
        <%= if @current_scope do %>
          <span>{@current_scope.user.email}</span>
          <a href="/users/settings" class="hover:underline">
            Settings
          </a>

          <a
            href="/users/log-out"
            data-method="delete"
            class="hover:underline"
          >
            Log out
          </a>
        <% else %>
          <a href="/users/register" class="hover:underline">
            Register
          </a>

          <a href="/users/log-in" class="hover:underline">
            Login
          </a>
        <% end %>
      </nav>
    </header>
    """
  end

  def ojs_footer(assigns) do
    ~H"""
    <footer class="bg-[#dcdcdc] border-t border-gray-300 py-10 px-8">
      <div class="max-w-6xl mx-auto flex justify-end">
        <div class="text-right text-gray-800">
          <p class="text-xl font-serif italic">Platform &</p>

          <p class="text-xl font-serif italic">workflow by</p>

          <p class="text-2xl font-serif font-bold">OJS / PKP</p>
        </div>
      </div>
    </footer>
    """
  end
end
