defmodule SimpleJournalSystemWeb.AdminLive.UsersLive do
  use SimpleJournalSystemWeb, :live_view

  alias SimpleJournalSystem.Accounts
  alias SimpleJournalSystem.Accounts.Roles
  alias SimpleJournalSystem.Journals

  embed_templates "users_live/*"

  @impl true
  def render(assigns) do
    index(assigns)
  end

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
  def handle_event("search", %{"filters" => params}, socket) do
    query =
      params
      |> Enum.reject(fn {_key, value} -> value in ["", nil] end)
      |> URI.encode_query()

    {:noreply, push_patch(socket, to: ~p"/admin/users?#{query}")}
  end

  @impl true
  def handle_event("export_csv", _params, socket) do
    filters = get_filters(socket.assigns)
    # Pass filters as query params
    query = URI.encode_query(filters)
    {:noreply, redirect(socket, to: ~p"/admin/users/export?#{query}")}
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
  def handle_event("edit_roles", %{"user_id" => user_id}, socket) do
    user_id = String.to_integer(user_id)

    user = Enum.find(socket.assigns.users, &(&1.user_id == user_id))

    current_roles = Accounts.list_user_roles(user_id)

    journal_id =
      case current_roles do
        [%{journal_id: id} | _] ->
          id

        [] ->
          case socket.assigns.journals do
            [%{journal_id: id} | _] -> id
            [] -> nil
          end
      end

    socket =
      socket
      |> assign(
        show_roles_modal: true,
        modal_user: user
      )
      |> load_role_groups(user_id, journal_id)

    {:noreply, socket}
  end

  @impl true
  def handle_event("change_role_journal", %{"journal_id" => journal_id}, socket) do
    journal_id =
      case Integer.parse(journal_id) do
        {id, ""} -> id
        _ -> nil
      end

    user_id = socket.assigns.modal_user.user_id

    {:noreply, load_role_groups(socket, user_id, journal_id)}
  end

  @impl true
  def handle_event("close_modal", _params, socket) do
    {:noreply,
     assign(socket,
       show_roles_modal: false,
       modal_user: nil,
       modal_journal_id: nil,
       modal_groups: [],
       selected_group_ids: []
     )}
  end

  @impl true
  def handle_event("save_roles", params, socket) do
    user_id = String.to_integer(params["user_id"])
    journal_id = socket.assigns.modal_journal_id

    group_ids =
      params
      |> Map.get("group_ids", [])
      |> Enum.map(&String.to_integer/1)

    changed_by_id = socket.assigns.current_scope.user.user_id

    current_roles = Accounts.list_user_roles_in_journal(user_id, journal_id)
    current_group_ids = Enum.map(current_roles, & &1.group_id)

    to_add = group_ids -- current_group_ids
    to_remove = current_group_ids -- group_ids

    case Accounts.update_user_roles(
           user_id,
           [add: to_add, remove: to_remove],
           changed_by_id
         ) do
      {:ok, _roles} ->
        socket =
          socket
          |> assign(show_roles_modal: false, modal_user: nil)
          |> apply_filters(
            Map.new(socket.assigns.filters, fn {key, value} ->
              {to_string(key), value}
            end)
          )
          |> put_flash(:info, "Roles updated successfully")

        {:noreply, socket}

      {:error, reason} ->
        {:noreply, put_flash(socket, :error, "Failed to update roles: #{inspect(reason)}")}
    end
  end

  defp apply_filters(socket, params) do
    filters =
      %{
        search: params["search"] || "",
        role_id: parse_integer(params["role_id"]),
        journal_id: parse_integer(params["journal_id"]),
        disabled: if(params["disabled"] in ["true", true], do: true, else: nil),
        page: parse_integer(params["page"]) || 1,
        per_page: 25
      }
      |> Enum.reject(fn {_, v} -> v == "" or is_nil(v) end)
      |> Map.new()

    result = Accounts.list_users(filters)
    journals = Journals.list_enabled_journals()
    roles_list = Roles.all() |> Enum.map(&{Roles.name(&1), &1})

    users =
      Enum.map(result.users, fn user ->
        data = Accounts.get_user_with_roles(user.user_id)

        user
        |> Map.from_struct()
        |> Map.merge(%{
          roles: data.roles,
          journals: data.journals
        })
      end)

    assign(socket,
      users: users,
      pagination: %{
        page: result.page,
        per_page: result.per_page,
        total: result.total,
        total_pages: result.total_pages
      },
      filters: filters,
      filter_form:
        to_form(
          Map.new(filters, fn {key, value} -> {to_string(key), value} end),
          as: :filters
        ),
      journals: journals,
      roles_list: roles_list,
      all_roles: roles_list,
      show_roles_modal: false,
      modal_user: nil,
      roles_form: to_form(%{})
    )
  end

  defp parse_integer(nil), do: nil
  defp parse_integer(""), do: nil
  defp parse_integer(value) when is_integer(value), do: value

  defp parse_integer(value) when is_binary(value) do
    case Integer.parse(value) do
      {number, ""} -> number
      _ -> nil
    end
  end

  defp load_role_groups(socket, user_id, journal_id) do
    groups =
      if journal_id do
        Accounts.list_user_groups(journal_id)
      else
        []
      end

    selected_group_ids =
      if journal_id do
        Accounts.list_user_roles_in_journal(user_id, journal_id)
        |> Enum.map(& &1.group_id)
      else
        []
      end

    assign(socket,
      modal_journal_id: journal_id,
      modal_groups: groups,
      selected_group_ids: selected_group_ids
    )
  end

  defp get_filters(%{filters: filters}) do
    filters
  end
end
