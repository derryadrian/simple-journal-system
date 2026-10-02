defmodule SimpleJournalSystemWeb.AdminLive.UsersLive do
  use SimpleJournalSystemWeb, :live_view

  alias SimpleJournalSystem.Accounts
  alias SimpleJournalSystem.Accounts.Roles
  alias SimpleJournalSystem.Journals

  @impl true
  def mount(params, _session, socket) do
    socket = apply_filters(socket, params)
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    socket = apply_filters(socket, params)
    {:noreply, socket}
  end

  @impl true
  def handle_event("search", params, socket) do
    socket = apply_filters(socket, params)
    {:noreply, push_patch(socket, to: ~p"/admin/users", params: params)}
  end

  @impl true
  def handle_event("export_csv", _params, socket) do
    filters = get_filters(socket.assigns)
    # Pass filters as query params
    query = URI.encode_query(filters)
    {:noreply, push_redirect(socket, to: ~p"/admin/users/export?#{query}")}
  end

  @impl true
  def handle_event("toggle_user", %{"user_id" => user_id, "action" => action}, socket) do
    user_id = String.to_integer(user_id)
    changed_by_id = socket.assigns.current_scope.user.user_id
    
    case action do
      "approve" ->
        Accounts.approve_user(user_id, changed_by_id)
      "reject" ->
        Accounts.reject_user(user_id, "Rejected by admin", changed_by_id)
    end
    
    socket = apply_filters(socket, socket.assigns.filters)
    {:noreply, put_flash(socket, :info, "User #{action}d successfully")}
  end

  @impl true
  def handle_event("save_roles", %{"user_id" => user_id, "role_ids" => role_ids}, socket) do
    user_id = String.to_integer(user_id)
    role_ids = Enum.map(role_ids, &String.to_integer/1)
    changed_by_id = socket.assigns.current_scope.user.user_id
    
    # Get current roles
    current = Accounts.list_user_roles(user_id)
    current_group_ids = Enum.map(current, & &1.group_id)
    
    # Roles to add/remove
    to_add = role_ids -- current_group_ids
    to_remove = current_group_ids -- role_ids
    
    Accounts.update_user_roles(user_id, add: to_add, remove: to_remove, changed_by_id: changed_by_id)
    
    socket = apply_filters(socket, socket.assigns.filters)
    {:noreply, put_flash(socket, :info, "Roles updated successfully")}
  end

  defp apply_filters(socket, params) do
    filters = %{
      search: params["search"] || "",
      role_id: params["role_id"] && String.to_integer(params["role_id"]),
      journal_id: params["journal_id"] && String.to_integer(params["journal_id"]),
      disabled: params["disabled"] && params["disabled"] == "true",
      page: params["page"] && String.to_integer(params["page"]) || 1,
      per_page: 25
    }
    |> Enum.reject(fn {_, v} -> v == "" or v == nil end)
    |> Map.new()

    result = Accounts.list_users(filters)
    journals = Journals.list_enabled_journals()
    roles_list = Roles.all() |> Enum.map(&{Roles.name(&1), &1})

    assign(socket,
      users: result.users,
      pagination: %{
        page: result.page,
        per_page: result.per_page,
        total: result.total,
        total_pages: result.total_pages
      },
      filters: filters,
      journals: journals,
      roles_list: roles_list,
      all_roles: roles_list
    )
  end

  defp get_filters(%{filters: filters}) do
    filters
  end
end