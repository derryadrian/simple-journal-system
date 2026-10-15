defmodule SimpleJournalSystem.AccountsFixtures do
  @moduledoc """
  Test fixtures for the Accounts context.

  Berisi dua kelompok:
    1. Fixture role/OJS (buatan AI): user_fixture, site_admin_fixture, dst.
    2. Helper bawaan Phoenix (phx.gen.auth): set_password, extract_user_token,
       override_token_authenticated_at, dst. Dikembalikan supaya test bawaan
       dan ConnCase bisa di-compile lagi.
  """

  import Ecto.Query
  alias SimpleJournalSystem.Accounts
  alias SimpleJournalSystem.Accounts.Scope
  alias SimpleJournalSystem.Accounts.User
  alias SimpleJournalSystem.Accounts.Roles
  alias SimpleJournalSystem.Journals.Journal
  alias SimpleJournalSystem.Repo

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "password123"

  def valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      username: "user#{System.unique_integer([:positive])}",
      email: unique_user_email(),
      password: valid_user_password(),
      password_confirmation: valid_user_password()
    })
  end

  # ============================================================
  # Fixture user (versi OJS)
  # ============================================================

  @doc """
  Creates a user with Bcrypt password.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> valid_user_attributes()
      |> Accounts.register_user()

    user
  end

  @doc """
  Di model OJS tidak ada konfirmasi email, jadi sama dengan user_fixture/1.
  Dipertahankan karena test bawaan Phoenix masih memanggilnya.
  """
  def unconfirmed_user_fixture(attrs \\ %{}), do: user_fixture(attrs)

  @doc """
  Creates a user with legacy SHA1 password (for testing fallback).
  """
  def user_fixture_legacy_sha1(attrs \\ %{}) do
    user = user_fixture(attrs)

    # Override with SHA1 hash (sha1$salt$hash)
    salt = "testsalt123"
    password = attrs[:password] || valid_user_password()
    sha1_hash = :crypto.hash(:sha, salt <> password) |> Base.encode16(case: :lower)
    legacy_hash = "sha1$#{salt}$#{sha1_hash}"

    user |> Ecto.Changeset.change(hashed_password: legacy_hash) |> Repo.update!()
    user
  end

  # ============================================================
  # Fixture role
  # ============================================================

  @doc """
  Creates a Site Admin user.
  """
  def site_admin_fixture(attrs \\ %{}) do
    user = user_fixture(attrs)

    # Create site admin group (context_id = nil, role_id = 16)
    {:ok, group} =
      Accounts.create_user_group(%{
        context_id: nil,
        role_id: Roles.site_admin(),
        is_default: 0
      })

    Accounts.enroll_user(user.user_id, group.user_group_id, user.user_id)
    user
  end

  @doc """
  Creates a Journal Manager user for a specific journal.
  """
  def journal_manager_fixture(journal_id, attrs \\ %{}) do
    role_user_fixture(journal_id, Roles.journal_manager(), 1, attrs)
  end

  @doc """
  Creates an Author user for a specific journal.
  """
  def author_fixture(journal_id, attrs \\ %{}) do
    role_user_fixture(journal_id, Roles.author(), 1, attrs)
  end

  @doc """
  Creates an Editor user for a specific journal.
  """
  def editor_fixture(journal_id, attrs \\ %{}) do
    role_user_fixture(journal_id, Roles.editor(), 0, attrs)
  end

  @doc """
  Creates a Reviewer user for a specific journal.
  """
  def reviewer_fixture(journal_id, attrs \\ %{}) do
    role_user_fixture(journal_id, Roles.reviewer(), 0, attrs)
  end

  defp role_user_fixture(journal_id, role_id, is_default, attrs) do
    user = user_fixture(attrs)

    {:ok, group} =
      Accounts.create_user_group(%{
        context_id: journal_id,
        role_id: role_id,
        is_default: is_default
      })

    Accounts.enroll_user(user.user_id, group.user_group_id, user.user_id)
    user
  end

  @doc """
  Creates a user with multiple roles across journals.
  """
  def multi_role_user_fixture(attrs \\ %{}) do
    user = user_fixture(attrs)

    journals = Repo.all(from j in Journal, where: j.enabled == 1)

    # Author in first journal
    if journal = Enum.at(journals, 0) do
      {:ok, group} =
        Accounts.create_user_group(%{
          context_id: journal.journal_id,
          role_id: Roles.author(),
          is_default: 1
        })

      Accounts.enroll_user(user.user_id, group.user_group_id, user.user_id)
    end

    # Editor in second journal
    if journal = Enum.at(journals, 1) do
      {:ok, group} =
        Accounts.create_user_group(%{
          context_id: journal.journal_id,
          role_id: Roles.editor(),
          is_default: 0
        })

      Accounts.enroll_user(user.user_id, group.user_group_id, user.user_id)
    end

    user
  end

  @doc """
  Creates a disabled user.
  """
  def disabled_user_fixture(attrs \\ %{}) do
    user = user_fixture(attrs)
    Accounts.suspend_user(user, "Test suspension")
  end

  # ============================================================
  # Helper bawaan Phoenix (dikembalikan dari main)
  # ============================================================

  def user_scope_fixture do
    user = user_fixture()
    user_scope_fixture(user)
  end

  def user_scope_fixture(user) do
    Scope.for_user(user)
  end

  @doc """
  user_fixture/1 sudah mengisi password, jadi tidak ada yang perlu diubah.
  """
  def set_password(user), do: user

  def extract_user_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end

  def override_token_authenticated_at(token, authenticated_at) when is_binary(token) do
    Repo.update_all(
      from(t in Accounts.UserToken,
        where: t.token == ^token
      ),
      set: [authenticated_at: authenticated_at]
    )
  end

  def generate_user_magic_link_token(user) do
    {encoded_token, user_token} = Accounts.UserToken.build_email_token(user, "login")
    Repo.insert!(user_token)
    {encoded_token, user_token.token}
  end

  def offset_user_token(token, amount_to_add, unit) do
    dt = DateTime.add(DateTime.utc_now(:second), amount_to_add, unit)

    Repo.update_all(
      from(ut in Accounts.UserToken, where: ut.token == ^token),
      set: [inserted_at: dt, authenticated_at: dt]
    )
  end
end