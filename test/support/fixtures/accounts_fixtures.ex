defmodule SimpleJournalSystem.AccountsFixtures do
  @moduledoc """
  Test fixtures for Accounts context.
  """

  import Ecto.Query
  alias SimpleJournalSystem.Accounts
  alias SimpleJournalSystem.Accounts.User
  alias SimpleJournalSystem.Accounts.UserGroup
  alias SimpleJournalSystem.Accounts.UserUserGroup
  alias SimpleJournalSystem.Accounts.Roles
  alias SimpleJournalSystem.Journals.Journal
  alias SimpleJournalSystem.Repo

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def valid_user_password, do: "password123"

  @doc """
  Creates a user with Bcrypt password.
  """
  def user_fixture(attrs \\ %{}) do
    attrs = Enum.merge(%{
      username: "user#{System.unique_integer()}",
      email: unique_user_email(),
      password: valid_user_password(),
      password_confirmation: valid_user_password()
    }, attrs)

    {:ok, user} = Accounts.register_user(attrs)
    user
  end

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
    
    Repo.update!(%User{user | hashed_password: legacy_hash})
    user
  end

  @doc """
  Creates a Site Admin user.
  """
  def site_admin_fixture(attrs \\ %{}) do
    user = user_fixture(attrs)
    
    # Create site admin group (context_id = nil, role_id = 16)
    {:ok, group} = Accounts.create_user_group(%{
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
    user = user_fixture(attrs)
    
    {:ok, group} = Accounts.create_user_group(%{
      context_id: journal_id,
      role_id: Roles.journal_manager(),
      is_default: 1
    })
    
    Accounts.enroll_user(user.user_id, group.user_group_id, user.user_id)
    user
  end

  @doc """
  Creates an Author user for a specific journal.
  """
  def author_fixture(journal_id, attrs \\ %{}) do
    user = user_fixture(attrs)
    
    {:ok, group} = Accounts.create_user_group(%{
      context_id: journal_id,
      role_id: Roles.author(),
      is_default: 1
    })
    
    Accounts.enroll_user(user.user_id, group.user_group_id, user.user_id)
    user
  end

  @doc """
  Creates an Editor user for a specific journal.
  """
  def editor_fixture(journal_id, attrs \\ %{}) do
    user = user_fixture(attrs)
    
    {:ok, group} = Accounts.create_user_group(%{
      context_id: journal_id,
      role_id: Roles.editor(),
      is_default: 0
    })
    
    Accounts.enroll_user(user.user_id, group.user_group_id, user.user_id)
    user
  end

  @doc """
  Creates a Reviewer user for a specific journal.
  """
  def reviewer_fixture(journal_id, attrs \\ %{}) do
    user = user_fixture(attrs)
    
    {:ok, group} = Accounts.create_user_group(%{
      context_id: journal_id,
      role_id: Roles.reviewer(),
      is_default: 0
    })
    
    Accounts.enroll_user(user.user_id, group.user_group_id, user.user_id)
    user
  end

  @doc """
  Creates a user with multiple roles across journals.
  """
  def multi_role_user_fixture(attrs \\ %{}) do
    user = user_fixture(attrs)
    
    # Get journals
    journals = Repo.all(from j in Journal, where: j.enabled == 1)
    
    # Author in first journal
    if journal = List.first(journals) do
      {:ok, group} = Accounts.create_user_group(%{
        context_id: journal.journal_id,
        role_id: Roles.author(),
        is_default: 1
      })
      Accounts.enroll_user(user.user_id, group.user_group_id, user.user_id)
    end
    
    # Editor in second journal
    if journal = List.first(List.delete_at(journals, 0)) do
      {:ok, group} = Accounts.create_user_group(%{
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
end