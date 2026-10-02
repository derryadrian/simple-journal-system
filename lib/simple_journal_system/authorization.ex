defmodule SimpleJournalSystem.Authorization do
  @moduledoc """
  Authorization helper berdasarkan struktur role OJS.
  Uses role IDs from SimpleJournalSystem.Accounts.Roles.
  """

  alias SimpleJournalSystem.Accounts.Roles

  @doc """
  Mengambil seluruh role_id milik user.
  """
  def get_roles(nil), do: []

  def get_roles(user) do
    user.user_user_groups
    |> Enum.map(& &1.user_group.role_id)
    |> Enum.uniq()
  end

  # ==========================================================
  # Generic Authorization
  # ==========================================================

  @doc """
  Mengecek apakah user memiliki satu role tertentu.
  """
  def has_role?(user, role_id) do
    role_id in get_roles(user)
  end

  @doc """
  Mengecek apakah user memiliki minimal satu role
  dari daftar role yang diizinkan.
  """
  def has_any_role?(user, allowed_role_ids)
      when is_list(allowed_role_ids) do
    user_roles = get_roles(user)

    Enum.any?(allowed_role_ids, &(&1 in user_roles))
  end

  @doc """
  Mengecek apakah user memiliki SEMUA role
  dari daftar role yang diberikan.
  """
  def has_all_roles?(user, required_role_ids)
      when is_list(required_role_ids) do
    user_roles = get_roles(user)

    Enum.all?(required_role_ids, &(&1 in user_roles))
  end

  # ==========================================================
  # OJS Helper Functions (delegated to Roles module)
  # ==========================================================

  def is_manager?(user),
    do: has_role?(user, Roles.manager())

  def is_site_admin?(user),
    do: has_role?(user, Roles.site_admin())

  def is_journal_manager?(user),
    do: has_role?(user, Roles.journal_manager())

  def is_author?(user),
    do: has_role?(user, Roles.author())

  def is_editor?(user),
    do: has_role?(user, Roles.editor())

  def is_reviewer?(user),
    do: has_role?(user, Roles.reviewer())

  def is_assistant?(user),
    do: has_role?(user, Roles.assistant())

  def is_reader?(user),
    do: has_role?(user, Roles.reader())

  def is_subscription_manager?(user),
    do: has_role?(user, Roles.subscription_manager())
end