defmodule SimpleJournalSystemWeb.UserLive.Registration do
  use SimpleJournalSystemWeb, :live_view

  alias SimpleJournalSystem.Accounts
  alias SimpleJournalSystem.Accounts.User

  @impl true
  def mount(_params, _session, socket) do
    if socket.assigns[:current_scope] && socket.assigns.current_scope.user do
      {:ok, redirect(socket, to: ~p"/")}
    else
      changeset = Accounts.change_user_registration(%User{}, %{})
      form = to_form(changeset, as: "user")
      {:ok, assign(socket, form: form, trigger_submit: false)}
    end
  end

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
            <span class="text-gray-500">Register</span>
          </nav>

          <!-- Title & Subtitle -->
          <h1 class="text-3xl font-bold text-gray-900 mb-2">Register</h1>
          <p class="text-sm text-gray-700 mb-6">
            Required fields are marked with an asterisk: <span class="text-red-600 font-bold">*</span>
          </p>

          <!-- Registration Form -->
          <.form
            :let={f}
            for={@form}
            id="registration_form"
            phx-submit="save"
            phx-change="validate"
            class="max-w-xl space-y-6"
          >
            <!-- SECTION 2: Login Details -->
            <div class="space-y-4 pt-4">
              <h2 class="text-xl font-bold text-gray-900 border-b border-gray-200 pb-2">
                Login Details
              </h2>

              <!-- Username -->
              <div>
                <label class="block text-sm font-medium text-gray-800 mb-1">
                  Username <span class="text-red-600">*</span>
                </label>
                <.input
                  field={f[:username]}
                  type="text"
                  required
                  class="w-full max-w-md px-3 py-1.5 border border-gray-400 rounded-sm text-sm focus:outline-none focus:border-[#1b629b] bg-white text-gray-900"
                />
              </div>

              <!-- Email -->
              <div>
                <label class="block text-sm font-medium text-gray-800 mb-1">
                  Email <span class="text-red-600">*</span>
                </label>
                <.input
                  field={f[:email]}
                  type="email"
                  required
                  class="w-full max-w-md px-3 py-1.5 border border-gray-400 rounded-sm text-sm focus:outline-none focus:border-[#1b629b] bg-white text-gray-900"
                />
              </div>

              <!-- Password -->
              <div>
                <label class="block text-sm font-medium text-gray-800 mb-1">
                  Password <span class="text-red-600">*</span>
                </label>
                <.input
                  field={f[:password]}
                  type="password"
                  required
                  class="w-full max-w-md px-3 py-1.5 border border-gray-400 rounded-sm text-sm focus:outline-none focus:border-[#1b629b] bg-white text-gray-900"
                />
              </div>

              <!-- Password Confirmation -->
              <div>
                <label class="block text-sm font-medium text-gray-800 mb-1">
                  Repeat Password <span class="text-red-600">*</span>
                </label>
                <.input
                  field={f[:password_confirmation]}
                  type="password"
                  required
                  class="w-full max-w-md px-3 py-1.5 border border-gray-400 rounded-sm text-sm focus:outline-none focus:border-[#1b629b] bg-white text-gray-900"
                />
              </div>
            </div>

            <!-- Submit Button -->
            <div class="pt-4">
              <button
                type="submit"
                phx-disable-with="Registering..."
                class="px-6 py-2 bg-[#e0e0e0] hover:bg-[#d0d0d0] text-gray-900 font-semibold text-sm rounded border border-gray-400 shadow-sm transition-colors cursor-pointer"
              >
                Register
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
  def handle_event("save", %{"user" => user_params}, socket) do
    IO.inspect(user_params, label: "📝 REGISTER PARAMS")

    case Accounts.register_user(user_params) do
      {:ok, user} ->
        IO.inspect(user, label: "✅ REGISTER SUCCESS")

        {:noreply,
         socket
         |> put_flash(:info, "Akun berhasil dibuat. Silakan login.")
         |> push_navigate(to: ~p"/users/log-in")}

      {:error, changeset} ->
        IO.inspect(changeset.errors, label: "❌ REGISTER ERROR")
        form = to_form(changeset, as: "user")
        {:noreply, assign(socket, form: form)}
    end
  end

  @impl true
  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset =
      %User{}
      |> Accounts.change_user_registration(user_params)
      |> Map.put(:action, :validate)

    form = to_form(changeset, as: "user")
    {:noreply, assign(socket, form: form)}
  end
end
