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
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <div class="mx-auto max-w-sm">
        <div class="text-center">
          <.header>
            Daftar Akun Baru
            <:subtitle>
              Sudah punya akun?
              <.link navigate={~p"/users/log-in"} class="font-semibold text-brand hover:underline">
                Login
              </.link>
            </:subtitle>
          </.header>
        </div>

        <.form
          for={@form}
          id="registration_form"
          phx-submit="save"
          phx-change="validate"
          class="space-y-4"
        >
          <.input
            field={@form[:username]}
            type="text"
            label="Username"
            placeholder="Username"
            required
            phx-mounted={JS.focus()}
          />

          <.input
            field={@form[:email]}
            type="email"
            label="Email"
            placeholder="Email"
            required
          />

          <.input
            field={@form[:password]}
            type="password"
            label="Password"
            placeholder="Minimal 6 karakter"
            required
          />

          <.input
            field={@form[:password_confirmation]}
            type="password"
            label="Konfirmasi Password"
            placeholder="Ulangi password"
            required
          />

          <.button phx-disable-with="Mendaftar..." class="btn btn-primary w-full">
            Daftar
          </.button>
        </.form>
      </div>
    </Layouts.app>
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