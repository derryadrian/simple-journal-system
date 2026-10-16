defmodule SimpleJournalSystemWeb.UserLive.Settings do
  use SimpleJournalSystemWeb, :live_view

  alias SimpleJournalSystem.Accounts
  alias SimpleJournalSystem.Accounts.User

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <div class="text-center">
        <.header>
          Account Settings
          <:subtitle>Manage your account password</:subtitle>
        </.header>
      </div>

      <p class="mt-4 text-sm text-center">Signed in as <strong>{@current_email}</strong></p>

      <.form
        for={@password_form}
        id="password_form"
        action={~p"/users/update-password"}
        method="post"
        phx-change="validate_password"
        phx-submit="update_password"
        phx-trigger-action={@trigger_submit}
      >
        <input type="hidden" name={@password_form[:email].name} value={@current_email} />
        <.input
          field={@password_form[:current_password]}
          type="password"
          label="Current password"
          autocomplete="current-password"
          required
        />
        <.input
          field={@password_form[:password]}
          type="password"
          label="New password"
          autocomplete="new-password"
          required
        />
        <.input
          field={@password_form[:password_confirmation]}
          type="password"
          label="Confirm new password"
          autocomplete="new-password"
        />
        <.button variant="primary" phx-disable-with="Saving...">Save Password</.button>
      </.form>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    user = socket.assigns.current_scope.user
    changeset = Accounts.change_user_password(user, %{}, hash_password: false)

    socket =
      socket
      |> assign(:current_email, user.email)
      |> assign(:password_form, to_form(changeset))
      |> assign(:trigger_submit, false)

    {:ok, socket}
  end

  @impl true
  def handle_event("validate_password", %{"user" => user_params}, socket) do
    form =
      socket.assigns.current_scope.user
      |> Accounts.change_user_password(user_params, hash_password: false)
      |> Map.put(:action, :validate)
      |> to_form()

    {:noreply, assign(socket, password_form: form)}
  end

  def handle_event("update_password", %{"user" => user_params}, socket) do
    user = socket.assigns.current_scope.user

    changeset =
      user
      |> Accounts.change_user_password(user_params, hash_password: false)
      |> User.validate_current_password(user_params["current_password"])

    case Ecto.Changeset.apply_action(changeset, :update) do
      {:ok, _user} ->
        {:noreply, assign(socket, trigger_submit: true)}

      {:error, changeset} ->
        {:noreply, assign(socket, password_form: to_form(changeset))}
    end
  end
end
