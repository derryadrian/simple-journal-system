defmodule SimpleJournalSystemWeb.OjsComponents do
  use Phoenix.Component

  attr :current_scope, :any, default: nil
  attr :current_journal, :any, default: nil
  attr :user_journals, :list, default: []

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
        <!-- Journal Switcher (CSS-only dropdown with click-away hook) -->
        <%= if @user_journals && length(@user_journals) > 0 do %>
          <div class="relative" phx-hook="JournalDropdown" id="journal-dropdown">
            <!-- Hidden checkbox for CSS-only toggle -->
            <input 
              type="checkbox" 
              id="journal-dropdown-toggle" 
              class="peer hidden" 
              phx-hook="ToggleJournalDropdown"
            />
            
            <label 
              for="journal-dropdown-toggle"
              class="flex items-center gap-2 px-3 py-2 bg-white/10 hover:bg-white/20 rounded-lg transition-colors cursor-pointer"
            >
              <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 7h18M3 12h18M3 17h18" />
              </svg>
              <span class="font-medium">
                <%= @current_journal?.path || "Select Journal" %>
              </span>
              <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
              </svg>
            </label>

            <!-- Dropdown menu (CSS-only, shown when checkbox is checked) -->
            <div class="peer-checked:block hidden absolute right-0 mt-2 w-56 bg-white rounded-lg shadow-lg border border-gray-200 z-50 animate-fade-in">
              <div class="py-1">
                <%= for journal <- @user_journals do %>
                  <%= is_current = @current_journal && @current_journal.journal_id == journal.journal_id %>
                  <a 
                    href={"/journal/switch/" <> to_string(journal.journal_id)}
                    class={"block px-4 py-2 text-sm hover:bg-gray-100 " <> if is_current, do: "bg-blue-50 text-blue-700 font-medium", else: ""}
                  >
                    <div class="flex items-center justify-between">
                      <span><%= journal.path %></span>
                      <%= if @current_journal && @current_journal.journal_id == journal.journal_id do %>
                        <svg class="w-4 h-4 text-blue-600" fill="currentColor" viewBox="0 0 20 20">
                          <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd" />
                        </svg>
                      <% end %>
                    </div>
                  </a>
                <% end %>
              </div>
            </div>
          </div>
        <% end %>

        <%= if @current_scope do %>
          <span class="text-xs opacity-80">{@current_scope.user.email}</span>

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