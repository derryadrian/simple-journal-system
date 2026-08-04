defmodule SimpleJournalSystemWeb.RoleManagementLive do
  use SimpleJournalSystemWeb, :live_view

  on_mount {SimpleJournalSystemWeb.UserAuth, :require_authenticated}

  alias SimpleJournalSystem.Roles
  alias SimpleJournalSystemWeb.Authorize

  @roles [:site_admin, :manager, :editor, :reviewer, :author]

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <div class="mx-auto max-w-4xl space-y-6">
        <.header>
          Role Management
          <:subtitle>Assign and revoke roles for users</:subtitle>
        </.header>

        <div class="card bg-base-200 overflow-x-auto">
          <table class="table">
            <thead>
              <tr>
                <th>User</th>
                <th>Email</th>
                <th :for={role <- @roles}>{role_label(role)}</th>
              </tr>
            </thead>
            <tbody id="users-roles" phx-update="stream">
              <tr :for={{id, entry} <- @streams.users_roles} id={id}>
                <td>{entry.user.username}</td>
                <td>{entry.user.email}</td>
                <td :for={role <- @roles}>
                  <input
                    type="checkbox"
                    id={"role-#{id}-#{role}"}
                    checked={role in entry.roles}
                    phx-click="toggle_role"
                    phx-value-user_id={entry.user.user_id}
                    phx-value-role={role}
                  />
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        <div class="text-sm text-base-content/60">
          Roles: SA = Site Administrator, JM = Journal Manager, SE = Section Editor, REV = Reviewer, AUTH = Author
        </div>
      </div>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    if Authorize.admin?(socket.assigns.current_scope) do
      socket =
        socket
        |> assign(:roles, @roles)
        |> stream(:users_roles, Roles.list_users_with_groups(), reset: true)

      {:ok, socket}
    else
      {:ok, push_navigate(socket, to: ~p"/")}
    end
  end

  @impl true
  def handle_event("toggle_role", %{"user_id" => user_id, "role" => role}, socket) do
    user_id = String.to_integer(user_id)
    role = String.to_existing_atom(role)

    user = SimpleJournalSystem.Repo.get(SimpleJournalSystem.Accounts.User, user_id)
    currently_assigned? = role in Roles.get_user_role_atoms(user_id)
    current_user_id = socket.assigns.current_scope.user.user_id

    cond do
      currently_assigned? and role == :site_admin and user_id == current_user_id ->
        socket = put_flash(socket, :error, "You cannot revoke your own Site Administrator role.")
        {:noreply, socket}

      currently_assigned? and role == :site_admin and
          Enum.count(Roles.list_users_with_groups(), &(&1.roles |> Enum.member?(:site_admin))) <=
            1 ->
        socket = put_flash(socket, :error, "At least one Site Administrator must remain.")
        {:noreply, socket}

      currently_assigned? ->
        Roles.remove_user_role(user, role)
        reload_roles(socket, role, true)

      true ->
        Roles.assign_user_role(user, role)
        reload_roles(socket, role, false)
    end
  end

  defp reload_roles(socket, role, assigned?) do
    entries = Roles.list_users_with_groups()

    socket =
      socket
      |> stream(:users_roles, entries, reset: true)
      |> put_flash(:info, role_flash(role, assigned?))

    {:noreply, socket}
  end

  defp role_flash(role, assigned?) do
    action = if assigned?, do: "revoked from", else: "assigned to"
    "#{role_label(role)} #{action} the user."
  end

  defp role_label(:site_admin), do: "SA"
  defp role_label(:manager), do: "JM"
  defp role_label(:editor), do: "SE"
  defp role_label(:reviewer), do: "REV"
  defp role_label(:author), do: "AUTH"
end
