defmodule SimpleJournalSystem.Authorization do
  @moduledoc """
  Authorization helper berdasarkan struktur role OJS.
  """

  def get_roles(user) do
    user.user_user_groups
    |> Enum.map(fn relation ->
      relation.user_group.role_id
    end)
  end

  def has_role?(user, role_id) do
    role_id in get_roles(user)
  end
end
