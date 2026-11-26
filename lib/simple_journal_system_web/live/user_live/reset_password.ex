defmodule SimpleJournalSystemWeb.UserLive.ResetPassword do
  use SimpleJournalSystemWeb, :live_view

  alias SimpleJournalSystem.Accounts

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <div class="mx-auto max-w-sm">
        <div class="text-center">
          <.header>
            Reset Password
            <:subtitle>Enter your email to receive reset instructions</:subtitle>
          </.header>
        </div>

        <.form
          :if={@action == :new}
          for={@request_form}
          id="request_reset_form"
          phx-submit="request_reset"
          class="mt-8 space-y-4"
        >
          <.input
            field={@request_form[:email]}
            type="email"
            label="Email"
            autocomplete="username"
            spellcheck="false"
            required
          />
          <.button variant="primary" phx-disable-with="Sending..." class="w-full">
            Send Reset Instructions
          </.button>
        </.form>

        <.form
          :if={@action == :edit}
          for={@reset_form}
          id="reset_password_form"
          phx-submit="reset_password"
          class="mt-8 space-y-4"
        >
          <.input
            field={@reset_form[:password]}
            type="password"
            label="New password"
            autocomplete="new-password"
            spellcheck="false"
            required
          />
          <.input
            field={@reset_form[:password_confirmation]}
            type="password"
            label="Confirm new password"
            autocomplete="new-password"
            spellcheck="false"
          />
          <.button variant="primary" phx-disable-with="Resetting..." class="w-full">
            Reset Password
          </.button>
        </.form>

        <p class="mt-4 text-center">
          <.link href={~p"/users/log-in"}>Back to login</.link>
        </p>
      </div>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"token" => token}, _session, socket) do
    case Accounts.get_user_by_reset_password_token(token) do
      %Accounts.User{} = user ->
        reset_form = to_form(%{}, as: "user")

        {:ok,
         socket
         |> assign(:action, :edit)
         |> assign(:token, token)
         |> assign(:user, user)
         |> assign(:request_form, to_form(%{"email" => user.email}, as: "user"))
         |> assign(:reset_form, reset_form)}

      nil ->
        {:ok,
         socket
         |> put_flash(:error, "Reset password link is invalid or it has expired.")
         |> push_navigate(to: ~p"/users/log-in")}
    end
  end

  def mount(_params, _session, socket) do
    request_form = to_form(%{"email" => ""}, as: "user")
    reset_form = to_form(%{}, as: "user")

    {:ok,
     socket
     |> assign(:action, :new)
     |> assign(:request_form, request_form)
     |> assign(:reset_form, reset_form)}
  end

  @impl true
  def handle_event("request_reset", %{"user" => %{"email" => email}}, socket) do
    if user = Accounts.get_user_by_email(email) do
      Accounts.deliver_user_reset_password_instructions(user)
    end

    info =
      "If your email is in our system, you will receive instructions for resetting your password shortly."

    {:noreply,
     socket
     |> put_flash(:info, info)
     |> push_navigate(to: ~p"/users/log-in")}
  end

  def handle_event("reset_password", %{"user" => user_params}, socket) do
    token = socket.assigns[:token]

    case Accounts.reset_user_password(token, user_params) do
      {:ok, _user} ->
        {:noreply,
         socket
         |> put_flash(:info, "Password has been reset successfully.")
         |> push_navigate(to: ~p"/users/log-in")}

      {:error, _} ->
        {:noreply,
         socket
         |> put_flash(:error, "Password reset failed. Please check your input.")
         |> assign(:reset_form, to_form(user_params, as: "user"))}
    end
  end
end
