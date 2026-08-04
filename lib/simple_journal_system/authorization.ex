defmodule SimpleJournalSystem.Authorization do
  @moduledoc """
  Authorization helper berdasarkan struktur role OJS.
  """

  # ==========================================================
  # OJS Role Constants
  # ==========================================================

  @manager 1
  @site_admin 16
  @author 256
  @editor 512
  @reviewer 4096
  @assistant 8192
  @reader 65536

  # ==========================================================
  # Role Getters
  def role_manager, do: @manager
  def role_admin, do: @site_admin
  def role_author, do: @author
  def role_editor, do: @editor
  def role_reviewer, do: @reviewer
  def role_assistant, do: @assistant
  def role_reader, do: @reader
  # ==========================================================

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
  # OJS Helper Functions
  # ==========================================================

  def is_manager?(user),
    do: has_role?(user, @manager)

  def is_site_admin?(user),
    do: has_role?(user, @site_admin)

  def is_author?(user),
    do: has_role?(user, @author)

  def is_editor?(user),
    do: has_role?(user, @editor)

  def is_reviewer?(user),
    do: has_role?(user, @reviewer)

  def is_assistant?(user),
    do: has_role?(user, @assistant)

  def is_reader?(user),
    do: has_role?(user, @reader)
end
