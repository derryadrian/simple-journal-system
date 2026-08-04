defmodule SimpleJournalSystem.Roles do
  @moduledoc """
  Provides role/group management over the existing OJS `user_groups`,
  `user_group_settings`, and `user_user_groups` tables.

  All reads go against the OJS database. Writes insert new rows into the
  existing tables using manually computed primary keys, since the OJS tables
  have no sequences.
  """
  import Ecto.Query

  alias SimpleJournalSystem.Repo
  alias SimpleJournalSystem.Accounts.User
  alias SimpleJournalSystem.Roles.UserGroup
  alias SimpleJournalSystem.Roles.UserGroupSetting
  alias SimpleJournalSystem.Roles.UserUserGroup

  @role_keys %{
    1 => :site_admin,
    16 => :manager,
    17 => :editor,
    4096 => :reviewer,
    65536 => :author
  }

  @doc "Maps an OJS `role_id` to an application role key (or nil if unknown)."
  def role_id_to_key(role_id) when is_integer(role_id), do: Map.get(@role_keys, role_id)
  def role_id_to_key(_), do: nil

  @doc "Maps an application role key to the OJS `role_id`."
  def key_to_role_id(key) do
    Enum.find_value(@role_keys, fn {id, k} -> if k == key, do: id end)
  end

  @doc "Returns all role keys known by the application."
  def role_keys, do: Map.values(@role_keys)

  @doc """
  Returns the role keys assigned to the given user.

  Queries `user_user_groups` joined to `user_groups` so that any active
  assignment is reflected regardless of whether it was created inside this app.
  """
  def get_user_role_atoms(user_id) when is_integer(user_id) do
    user_id
    |> role_ids_query()
    |> Repo.all()
    |> Enum.map(&role_id_to_key/1)
    |> Enum.reject(&is_nil/1)
    |> Enum.uniq()
  end

  def get_user_role_atoms(_), do: []

  defp role_ids_query(user_id) do
    from uug in UserUserGroup,
      join: ug in assoc(uug, :user_group),
      where: uug.user_id == ^user_id,
      where: is_nil(uug.date_end) or uug.date_end > ^NaiveDateTime.utc_now(),
      select: ug.role_id
  end

  @doc "Returns true if the user has the given role key."
  def has_role?(user_id, role_key) when is_integer(user_id) do
    role_key in get_user_role_atoms(user_id)
  end

  def has_role?(_user_id, _role_key), do: false

  @doc "Returns all user groups (roles), optionally scoped by context."
  def list_user_groups(context_id \\ nil) do
    query = from ug in UserGroup, order_by: [asc: ug.user_group_id]

    query =
      if context_id,
        do: from(ug in query, where: ug.context_id == ^context_id),
        else: query

    Repo.all(query)
  end

  @doc "Returns a user group by its id, raising if not found."
  def get_user_group!(user_group_id), do: Repo.get!(UserGroup, user_group_id)

  @doc "Returns all user group settings for a group, keyed by setting_name."
  def list_user_group_settings(user_group_id) do
    query =
      from ugs in UserGroupSetting,
        where: ugs.user_group_id == ^user_group_id,
        order_by: [asc: ugs.setting_name]

    Repo.all(query)
  end

  @doc "Returns the localized display name for a group, or nil."
  def user_group_name(user_group_id, locale \\ "en") do
    user_group_id
    |> list_user_group_settings()
    |> Enum.find(fn s -> s.setting_name == "name" and (s.locale == locale or s.locale == nil) end)
    |> case do
      nil ->
        case Repo.get(UserGroup, user_group_id) do
          %UserGroup{} = ug -> "Role ##{ug.user_group_id}"
          nil -> nil
        end

      setting ->
        setting.setting_value
    end
  end

  @doc """
  Lists users together with their assigned roles.

  Returns a list of maps `%{id: user_id, user: user, roles: [role_key]}`,
  suitable for LiveView streams. Uses a stream of batch queries to avoid
  loading every user_group for the entire user base at once.
  """
  def list_users_with_groups do
    users = from(u in User, order_by: [asc: u.user_id]) |> Repo.all()

    users
    |> Task.async_stream(
      fn user -> %{id: user.user_id, user: user, roles: get_user_role_atoms(user.user_id)} end,
      timeout: :infinity
    )
    |> Enum.map(fn {:ok, result} -> result end)
  end

  @doc "Returns all assignments (`user_user_groups` rows) for a user."
  def list_user_user_groups(user_id) do
    from(uug in UserUserGroup,
      where: uug.user_id == ^user_id,
      order_by: [asc: uug.user_user_group_id]
    )
    |> Repo.all()
  end

  @doc "Returns the user_group row for the given role key in the given context, if one exists."
  def find_user_group_by_role(context_id, role_key) do
    from(ug in UserGroup,
      where: ug.role_id == ^key_to_role_id(role_key),
      where: ^context_filter(context_id),
      limit: 1
    )
    |> Repo.one()
  end

  @doc "Finds the site-level user group for the given role key (context_id is NULL)."
  def find_site_user_group_by_role(role_key) do
    from(ug in UserGroup,
      where: ug.role_id == ^key_to_role_id(role_key),
      where: is_nil(ug.context_id),
      limit: 1
    )
    |> Repo.one()
  end

  defp context_filter(nil), do: dynamic([ug], is_nil(ug.context_id))
  defp context_filter(context_id), do: dynamic([ug], ug.context_id == ^context_id)

  @doc """
  Computes the next primary key for a table given its module and pk field.
  """
  def next_pk(module, pk_field) do
    (Repo.aggregate(module, :max, pk_field) || 0) + 1
  end

  @doc """
  Assigns a role to a user by inserting a `user_user_groups` row.

  Uses an existing user_group for the given role/context if present,
  otherwise creates the user_group and its default settings first.
  """
  def assign_user_role(user, role_key, context_id \\ nil) do
    user_group =
      find_user_group_by_role(context_id, role_key) || find_site_user_group_by_role(role_key)

    user_group =
      user_group || ensure_user_group(context_id, role_key)

    insert_assignment(user, user_group)
  end

  @doc "Removes a role assignment from a user, leaving history via date_end."
  def remove_user_role(user, role_key, context_id \\ nil) do
    user_group =
      find_user_group_by_role(context_id, role_key) || find_site_user_group_by_role(role_key)

    case user_group do
      nil ->
        {:ok, user}

      %UserGroup{} = ug ->
        Repo.update_all(
          from(uug in UserUserGroup,
            where: uug.user_id == ^user.user_id and uug.user_group_id == ^ug.user_group_id,
            where: is_nil(uug.date_end)
          ),
          set: [date_end: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)]
        )
        |> then(fn _ -> {:ok, user} end)
    end
  end

  defp ensure_user_group(context_id, role_key) do
    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

    user_group_id = next_pk(UserGroup, :user_group_id)

    user_group =
      Repo.insert!(%UserGroup{
        user_group_id: user_group_id,
        context_id: context_id,
        role_id: key_to_role_id(role_key),
        is_default: 1,
        show_title: 1,
        permit_self_registration: 1,
        permit_metadata_edit: 1,
        permit_settings: 0,
        masthead: 1
      })

    seed_user_group_settings(user_group_id, role_key, context_id, now)

    user_group
  end

  defp seed_user_group_settings(user_group_id, role_key, context_id, _now) do
    {name, abbrev} = role_names(role_key)

    settings = [
      {"name", name},
      {"abbrev", abbrev}
    ]

    for {setting_name, setting_value} <- settings do
      setting_id = next_pk(UserGroupSetting, :user_group_setting_id)

      Repo.insert!(%UserGroupSetting{
        user_group_setting_id: setting_id,
        user_group_id: user_group_id,
        locale: "en",
        setting_name: setting_name,
        setting_value: setting_value
      })

      if context_id do
        setting_id = next_pk(UserGroupSetting, :user_group_setting_id)

        Repo.insert!(%UserGroupSetting{
          user_group_setting_id: setting_id,
          user_group_id: user_group_id,
          locale: "id",
          setting_name: setting_name,
          setting_value: setting_value
        })
      end
    end

    :ok
  end

  defp role_names(role_key) do
    case role_key do
      :site_admin -> {"Site Administrator", "SA"}
      :manager -> {"Journal Manager", "JM"}
      :editor -> {"Section Editor", "SE"}
      :reviewer -> {"Reviewer", "REV"}
      :author -> {"Author", "AUTH"}
    end
  end

  defp insert_assignment(user, user_group) do
    if Repo.exists?(
         from(uug in UserUserGroup,
           where:
             uug.user_id == ^user.user_id and uug.user_group_id == ^user_group.user_group_id and
               (is_nil(uug.date_end) or uug.date_end > ^NaiveDateTime.utc_now())
         )
       ) do
      {:ok, user}
    else
      now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

      Repo.insert(%UserUserGroup{
        user_user_group_id: next_pk(UserUserGroup, :user_user_group_id),
        user_group_id: user_group.user_group_id,
        user_id: user.user_id,
        date_start: now,
        date_end: nil,
        masthead: 1
      })
      |> case do
        {:ok, _} -> {:ok, user}
        {:error, changeset} -> {:error, changeset}
      end
    end
  end
end
