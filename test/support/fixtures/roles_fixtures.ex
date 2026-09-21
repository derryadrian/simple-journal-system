defmodule SimpleJournalSystem.RolesFixtures do
  @moduledoc """
  Test helpers khusus Role Management.

  Membuat user, user_group, dan relasi user <-> group (user_user_groups)
  tanpa bergantung pada alur magic-link / Authentication.

  Catatan: `user_fixture/1` di sini TIDAK memakai `AccountsFixtures.user_fixture/1`
  (yang bergantung pada alur magic-link milik Authentication).
  """

  alias SimpleJournalSystem.Accounts
  alias SimpleJournalSystem.Accounts.UserGroup
  alias SimpleJournalSystem.Accounts.UserUserGroup
  alias SimpleJournalSystem.Authorization
  alias SimpleJournalSystem.Repo

  def unique_username, do: "user#{System.unique_integer()}"
  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_password, do: "hello world!"

  def user_attrs(attrs \\ %{}) do
    Enum.into(attrs, %{
      username: unique_username(),
      email: unique_user_email(),
      password: valid_password()
    })
  end

  @doc """
  Membuat user TANPA role sama sekali.

  Memakai `Accounts.register_user/1` (registrasi biasa) sehingga tidak
  bergantung pada alur magic-link. Relasi `user_user_groups: :user_group`
  langsung di-preload agar siap dipakai `Authorization`.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} = attrs |> user_attrs() |> Accounts.register_user()

    Repo.preload(user, user_user_groups: :user_group)
  end

  @doc """
  Membuat user_group dengan `role_id` tertentu.

  Primary key `user_group_id` di-set eksplisit (pola sama seperti
  `User.put_user_id/1`) karena Ecto hanya meng-autogenerate primary key
  yang bernama `:id`, bukan yang bernama kustom seperti `user_group_id`.
  """
  def user_group_fixture(attrs \\ %{}) do
    defaults = %{
      role_id: Authorization.role_reader(),
      context_id: 1,
      is_default: 1,
      show_title: 0,
      permit_self_registration: 1,
      permit_metadata_edit: 1,
      permit_settings: 1,
      masthead: 0
    }

    fields =
      defaults
      |> Map.merge(attrs)
      |> Map.take(UserGroup.__schema__(:fields))
      |> Map.put(:user_group_id, next_id(UserGroup, :user_group_id))

    %UserGroup{}
    |> struct!(fields)
    |> Repo.insert!()
  end

  @doc """
  Membuat relasi user <-> group.

  Primary key `user_user_group_id` di-set eksplisit (lihat `user_group_fixture/1`).
  """
  def user_user_group_fixture(attrs) do
    fields =
      attrs
      |> Map.take(UserUserGroup.__schema__(:fields))
      |> Map.put(:user_user_group_id, next_id(UserUserGroup, :user_user_group_id))

    %UserUserGroup{}
    |> struct!(fields)
    |> Repo.insert!()
  end

  defp next_id(schema, pk) do
    (Repo.aggregate(schema, :max, pk) || 0) + 1
  end

  @doc """
  Menghubungkan user ke satu role dan mengembalikan user dengan
  relasi `user_user_groups: :user_group` ter-preload.

  Dipakai `Repo.reload/1` dulu karena Ecto TIDAK mengulang preload
  pada relasi yang sudah ter-load sebelumnya (akan mengembalikan
  nilai lama/`[]`).
  """
  def with_role(user, role_id) do
    group = user_group_fixture(%{role_id: role_id})

    user_user_group_fixture(%{
      user_id: user.user_id,
      user_group_id: group.user_group_id
    })

    user
    |> Repo.reload()
    |> Repo.preload(user_user_groups: :user_group)
  end

  @doc """
  Membuat user yang memiliki satu role.
  """
  def user_with_role_fixture(role_id, user_attrs \\ %{}) do
    user_fixture(user_attrs) |> with_role(role_id)
  end

  @doc """
  Membuat user yang memiliki beberapa role sekaligus.
  """
  def user_with_roles_fixture(role_ids, user_attrs \\ %{}) do
    Enum.reduce(role_ids, user_fixture(user_attrs), &with_role(&2, &1))
  end
end
