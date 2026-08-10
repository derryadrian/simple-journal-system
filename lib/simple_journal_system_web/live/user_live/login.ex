defmodule SimpleJournalSystemWeb.UserLive.Login do
  use SimpleJournalSystemWeb, :live_view

  alias SimpleJournalSystem.Accounts

  @impl true
  def render(assigns) do
    ~H"""
    <div class="min-h-screen bg-white flex flex-col justify-between font-sans text-gray-800">
      <!-- Header / Navbar OJS -->
      <.ojs_header current_scope={@current_scope} />

      <!-- Main Content Area -->
      <main class="flex-grow max-w-5xl w-full mx-auto px-6 py-8">
        <div class="bg-white border-x border-gray-200 min-h-[600px] p-8">
          <!-- Breadcrumb Navigation -->
          <nav class="text-sm text-gray-600 mb-6 flex items-center space-x-2">
            <.link href={~p"/"} class="text-[#1b629b] hover:underline font-medium">Home</.link>
            <span class="text-gray-400">/</span>
            <span class="text-gray-500">Login</span>
          </nav>

          <!-- Title & Subtitle -->
          <h1 class="text-3xl font-bold text-gray-900 mb-4">Login</h1>
          <p class="text-sm text-gray-700 mb-6">
            Required fields are marked with an asterisk: <span class="text-red-600 font-bold">*</span>
          </p>

          <!-- Login Form -->
          <.form :let={f} for={@form} action={~p"/users/log-in"} class="max-w-md space-y-5">
            <!-- Username or Email Input -->
            <div>
              <label for="user_email" class="block text-sm font-medium text-gray-800 mb-1">
                Username or Email <span class="text-red-600">*</span>
              </label>
              <.input
                field={f[:email]}
                type="email"
                required
                class="w-full px-3 py-1.5 border border-gray-400 rounded-sm text-sm focus:outline-none focus:border-[#1b629b] bg-white text-gray-900"
              />
            </div>

            <!-- Password Input -->
            <div>
              <label for="user_password" class="block text-sm font-medium text-gray-800 mb-1">
                Password <span class="text-red-600">*</span>
              </label>
              <.input
                field={f[:password]}
                type="password"
                required
                class="w-full px-3 py-1.5 border border-gray-400 rounded-sm text-sm focus:outline-none focus:border-[#1b629b] bg-white text-gray-900"
              />
              <div class="mt-1">
                <.link href={~p"/users/reset_password"} class="text-xs text-[#1b629b] hover:underline">
                  Forgot your password?
                </.link>
              </div>
            </div>

            <!-- Keep me logged in Checkbox -->
            <div class="flex items-center space-x-2 pt-1">
              <.input
                field={f[:remember_me]}
                type="checkbox"
                class="h-4 w-4 rounded border-gray-300 text-[#1b629b] focus:ring-0"
              />
              <label for="user_remember_me" class="text-sm text-gray-800 select-none">
                Keep me logged in
              </label>
            </div>

            <!-- Action Buttons -->
            <div class="flex items-center space-x-4 pt-4">
              <.link href={~p"/users/register"} class="text-sm text-[#1b629b] hover:underline">
                Register
              </.link>
              <button
                type="submit"
                class="px-5 py-1.5 bg-[#e0e0e0] hover:bg-[#d0d0d0] text-gray-900 font-semibold text-sm rounded border border-gray-400 shadow-sm transition-colors"
              >
                Login
              </button>
            </div>
          </.form>
        </div>
      </main>

      <!-- Footer Section -->
      <.ojs_footer />
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    email =
      Phoenix.Flash.get(socket.assigns.flash, :email) ||
        get_in(socket.assigns, [:current_scope, Access.key(:user), Access.key(:email)])

    form = to_form(%{"email" => email}, as: "user")

    {:ok, assign(socket, form: form, trigger_submit: false)}
  end

  @impl true
  def handle_event("submit_password", _params, socket) do
    {:noreply, assign(socket, :trigger_submit, true)}
  end

  def handle_event("submit_magic", %{"user" => %{"email" => email}}, socket) do
    if user = Accounts.get_user_by_email(email) do
      Accounts.deliver_login_instructions(
        user,
        &url(~p"/users/log-in/#{&1}")
      )
    end

    info =
      "If your email is in our system, you will receive instructions for logging in shortly."

    {:noreply,
     socket
     |> put_flash(:info, info)
     |> push_navigate(to: ~p"/users/log-in")}
  end

  defp local_mail_adapter? do
    Application.get_env(:simple_journal_system, SimpleJournalSystem.Mailer)[:adapter] ==
      Swoosh.Adapters.Local
  end
end
