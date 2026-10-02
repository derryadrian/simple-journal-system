defmodule SimpleJournalSystem.Audit do
  @moduledoc """
  Audit logging for role changes and user management actions.
  """

  import Ecto.Query
  alias SimpleJournalSystem.Repo
  alias SimpleJournalSystem.Audit.RoleChangeLog
  alias SimpleJournalSystem.Accounts.UserGroup

  @doc """
  Logs a role change event.
  """
  def log_role_change(attrs) do
    %RoleChangeLog{}
    |> RoleChangeLog.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Logs user enrollment in a role.
  """
  def log_enroll(user_id, changed_by_id, user_group_id, context_id, conn \\ nil) do
    log_role_change(%{
      user_id: user_id,
      changed_by_id: changed_by_id,
      action: "enroll",
      new_role_id: get_role_id(user_group_id),
      user_group_id: user_group_id,
      context_id: context_id,
      metadata: build_metadata(conn)
    })
  end

  @doc """
  Logs user unenrollment from a role.
  """
  def log_unenroll(user_id, changed_by_id, user_group_id, context_id, conn \\ nil) do
    log_role_change(%{
      user_id: user_id,
      changed_by_id: changed_by_id,
      action: "unenroll",
      old_role_id: get_role_id(user_group_id),
      user_group_id: user_group_id,
      context_id: context_id,
      metadata: build_metadata(conn)
    })
  end

  @doc """
  Logs role change (user moved from one role to another).
  """
  def log_role_change_action(user_id, changed_by_id, old_group_id, new_group_id, context_id, conn \\ nil) do
    log_role_change(%{
      user_id: user_id,
      changed_by_id: changed_by_id,
      action: "role_change",
      old_role_id: get_role_id(old_group_id),
      new_role_id: get_role_id(new_group_id),
      user_group_id: new_group_id,
      context_id: context_id,
      metadata: build_metadata(conn)
    })
  end

  @doc """
  Logs user approval.
  """
  def log_approve(user_id, changed_by_id, conn \\ nil) do
    log_role_change(%{
      user_id: user_id,
      changed_by_id: changed_by_id,
      action: "approve",
      metadata: build_metadata(conn)
    })
  end

  @doc """
  Logs user rejection/disable.
  """
  def log_reject(user_id, changed_by_id, reason, conn \\ nil) do
    log_role_change(%{
      user_id: user_id,
      changed_by_id: changed_by_id,
      action: "reject",
      metadata: build_metadata(conn) |> Map.put(:reason, reason)
    })
  end

  @doc """
  Gets audit logs for a user.
  """
  def get_user_logs(user_id, limit \\ 50) do
    Repo.all(
      from log in RoleChangeLog,
      where: log.user_id == ^user_id,
      order_by: [desc: log.inserted_at],
      limit: ^limit
    )
  end

  @doc """
  Gets audit logs by admin.
  """
  def get_admin_logs(changed_by_id, limit \\ 50) do
    Repo.all(
      from log in RoleChangeLog,
      where: log.changed_by_id == ^changed_by_id,
      order_by: [desc: log.inserted_at],
      limit: ^limit
    )
  end

  @doc """
  Gets audit logs for a journal/context.
  """
  def get_context_logs(context_id, limit \\ 50) do
    Repo.all(
      from log in RoleChangeLog,
      where: log.context_id == ^context_id,
      order_by: [desc: log.inserted_at],
      limit: ^limit
    )
  end

  defp get_role_id(user_group_id) do
    Repo.one(from ug in UserGroup, where: ug.user_group_id == ^user_group_id, select: ug.role_id)
  end

  defp build_metadata(conn) do
    %{
      ip: conn |> get_client_ip(),
      user_agent: conn |> get_user_agent(),
      timestamp: DateTime.utc_now()
    }
  end

  defp get_client_ip(conn) do
    case conn.req_headers do
      [{"x-forwarded-for", ip} | _] -> ip
      [{"x-real-ip", ip} | _] -> ip
      _ ->
        case conn.remote_ip do
          {_, _, _, _} = ip_tuple -> ip_tuple |> Tuple.to_list() |> Enum.join(".")
          ip when is_binary(ip) -> ip
          _ -> "unknown"
        end
    end
  end

  defp get_user_agent(conn) do
    case conn.req_headers do
      [{"user-agent", ua} | _] -> ua
      _ -> "unknown"
    end
  end
end