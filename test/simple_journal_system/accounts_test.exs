defmodule SimpleJournalSystem.AccountsTest do
  use SimpleJournalSystem.DataCase

  alias SimpleJournalSystem.Accounts
  alias SimpleJournalSystem.Accounts.User
  alias SimpleJournalSystem.Accounts.UserGroup
  alias SimpleJournalSystem.Accounts.UserUserGroup
  alias SimpleJournalSystem.Accounts.Roles
  alias SimpleJournalSystem.Journals.Journal
  alias SimpleJournalSystem.Repo

  import SimpleJournalSystem.AccountsFixtures
  setup do
    %{user: user_fixture()}
  end

  describe "get_user_by_email_and_password/2" do
    @tag :auth
    test "returns user with valid Bcrypt password", %{user: user} do
      assert (Accounts.get_user_by_email_and_password(user.email, "password123")).user_id == user.user_id
    end

    @tag :auth
    test "returns nil with invalid password", %{user: user} do
      refute Accounts.get_user_by_email_and_password(user.email, "wrongpassword")
    end

    @tag :auth
    test "returns nil for non-existent email", %{user: user} do
      refute Accounts.get_user_by_email_and_password("nonexistent@example.com", "password123")
    end

    @tag :auth
    test "works with username instead of email", %{user: user} do
      assert (Accounts.get_user_by_email_and_password(user.username, "password123")).user_id == user.user_id
    end
  end

  describe "SHA1 legacy password fallback" do
    @tag :auth
    test "logs in user with SHA1 legacy password", %{user: user} do
      # Create user with legacy SHA1 password
      {:ok, user} = Accounts.register_user(%{
        username: "legacy#{System.unique_integer()}",
        email: "legacy#{System.unique_integer()}@example.com",
        password: "legacy123",
        password_confirmation: "legacy123"
      })

      # Override with SHA1 hash
      salt = "testsalt123"
      sha1_hash = :crypto.hash(:sha, salt <> "legacy123") |> Base.encode16(case: :lower)
      legacy_hash = "sha1$testsalt123$#{sha1_hash}"
      user |> Ecto.Changeset.change(hashed_password: legacy_hash) |> Repo.update!()

      # Should login with legacy password
      assert (Accounts.get_user_by_email_and_password(user.email, "legacy123")).user_id == user.user_id
      
      # Password should be upgraded to Bcrypt
      updated_user = Repo.get!(User, user.user_id)
      assert String.starts_with?(updated_user.hashed_password, "$2b$")
    end

    @tag :auth
    test "logs in user with plain SHA1 password", %{user: user} do
      {:ok, user} = Accounts.register_user(%{
        username: "plainsha1#{System.unique_integer()}",
        email: "plainsha1#{System.unique_integer()}@example.com",
        password: "plain123",
        password_confirmation: "plain123"
      })

      sha1_hash = :crypto.hash(:sha, "plain123") |> Base.encode16(case: :lower)
      user |> Ecto.Changeset.change(hashed_password: sha1_hash) |> Repo.update!()

      assert (Accounts.get_user_by_email_and_password(user.email, "plain123")).user_id == user.user_id
      
      updated_user = Repo.get!(User, user.user_id)
      assert String.starts_with?(updated_user.hashed_password, "$2b$")
    end

    @tag :auth
    test "logs in user with SHA256 legacy password", %{user: user} do
      {:ok, user} = Accounts.register_user(%{
        username: "sha256#{System.unique_integer()}",
        email: "sha256#{System.unique_integer()}@example.com",
        password: "sha256pass",
        password_confirmation: "sha256pass"
      })

      salt = "salty"
      sha256_hash = :crypto.hash(:sha256, salt <> "sha256pass") |> Base.encode16(case: :lower)
      legacy_hash = "sha256$#{salt}$#{sha256_hash}"
      user |> Ecto.Changeset.change(hashed_password: legacy_hash) |> Repo.update!()

      assert (Accounts.get_user_by_email_and_password(user.email, "sha256pass")).user_id == user.user_id
    end
  end

  describe "register_user/1" do
    test "registers user with valid data" do
      attrs = %{
        username: "newuser#{System.unique_integer()}",
        email: "new#{System.unique_integer()}@example.com",
        password: "password123",
        password_confirmation: "password123"
      }
      
      {:ok, user} = Accounts.register_user(attrs)
      assert user.username == attrs[:username]
      assert user.email == attrs[:email]
      assert String.starts_with?(user.hashed_password, "$2b$")
      assert user.disabled == 0
    end

    test "rejects duplicate username" do
      user = user_fixture()
      attrs = %{
        username: user.username,
        email: "different#{System.unique_integer()}@example.com",
        password: "password123",
        password_confirmation: "password123"
      }
      
      {:error, changeset} = Accounts.register_user(attrs)
      assert "has already been taken" in errors_on(changeset).username
    end

    test "rejects duplicate email" do
      user = user_fixture()
      attrs = %{
        username: "different#{System.unique_integer()}",
        email: user.email,
        password: "password123",
        password_confirmation: "password123"
      }
      
      {:error, changeset} = Accounts.register_user(attrs)
      assert "has already been taken" in errors_on(changeset).email
    end

    test "rejects invalid email format" do
      attrs = %{
        username: "test#{System.unique_integer()}",
        email: "not-an-email",
        password: "password123",
        password_confirmation: "password123"
      }
      
      {:error, changeset} = Accounts.register_user(attrs)
      assert "format email tidak valid" in errors_on(changeset).email
    end

    test "rejects short password" do
      attrs = %{
        username: "test#{System.unique_integer()}",
        email: "test#{System.unique_integer()}@example.com",
        password: "short",
        password_confirmation: "short"
      }
      
      {:error, changeset} = Accounts.register_user(attrs)
      assert "should be at least 6 character(s)" in errors_on(changeset).password
    end

    test "rejects mismatched password confirmation" do
      attrs = %{
        username: "test#{System.unique_integer()}",
        email: "test#{System.unique_integer()}@example.com",
        password: "password123",
        password_confirmation: "different"
      }
      
      {:error, changeset} = Accounts.register_user(attrs)
      assert "tidak sama dengan password" in errors_on(changeset).password_confirmation
    end
  end

  describe "User Settings EAV" do
    setup do
      {:ok, user: user_fixture()}
    end

    @tag :settings
    test "put_setting and get_setting", %{user: user} do
      {:ok, _} = Accounts.put_setting(user, "givenName", "John")
      {:ok, _} = Accounts.put_setting(user, "familyName", "Doe")
      {:ok, _} = Accounts.put_setting(user, "affiliation", "University X")
      
      assert Accounts.get_setting(user, "givenName") == "John"
      assert Accounts.get_setting(user, "familyName") == "Doe"
      assert Accounts.get_setting(user, "affiliation") == "University X"
    end

    @tag :settings
    test "get_setting with fallback locale", %{user: user} do
      Accounts.put_setting(user, "givenName", "John", "en")
      Accounts.put_setting(user, "givenName", "Juan", "es")
      
      assert Accounts.get_setting(user, "givenName", "es") == "Juan"
      assert Accounts.get_setting(user, "givenName", "fr", "en") == "John"
    end

    @tag :settings
    test "get_all_settings", %{user: user} do
      Accounts.put_setting(user, "givenName", "John")
      Accounts.put_setting(user, "familyName", "Doe")
      
      settings = Accounts.get_all_settings(user)
      assert settings["givenName"] == "John"
      assert settings["familyName"] == "Doe"
    end

    @tag :settings
    test "get_profile", %{user: user} do
      Accounts.put_setting(user, "givenName", "John")
      Accounts.put_setting(user, "familyName", "Doe")
      Accounts.put_setting(user, "affiliation", "University X")
      Accounts.put_setting(user, "orcid", "0000-0000-0000-0000")
      
      profile = Accounts.get_profile(user)
      assert profile.given_name == "John"
      assert profile.family_name == "Doe"
      assert profile.affiliation == "University X"
      assert profile.orcid == "0000-0000-0000-0000"
      assert profile.email == user.email
      assert profile.username == user.username
    end

    @tag :settings
    test "update_profile", %{user: user} do
      {:ok, _} = Accounts.update_profile(user, %{
        "givenName" => "Jane",
        "familyName" => "Smith",
        "affiliation" => "New University",
        "email" => "jane.smith@example.com"
      })
      
      updated_user = Repo.get!(User, user.user_id)
      assert updated_user.email == "jane.smith@example.com"
      
      assert Accounts.get_setting(updated_user, "givenName") == "Jane"
      assert Accounts.get_setting(updated_user, "familyName") == "Smith"
      assert Accounts.get_setting(updated_user, "affiliation") == "New University"
    end

    @tag :settings
    test "suspend_user and activate_user", %{user: user} do
      {:ok, suspended} = Accounts.suspend_user(user, "Spam")
      assert suspended.disabled == 1
      assert suspended.disabled_reason == "Spam"
      
      {:ok, activated} = Accounts.activate_user(suspended)
      assert activated.disabled == 0
      assert is_nil(activated.disabled_reason)
    end
  end

  describe "User Group CRUD" do
    setup do
      journal = Repo.get!(Journal, 1)  # ojs journal exists
      {:ok, journal: journal}
    end

    @tag :groups
    test "list_user_groups", %{journal: journal} do
      groups = Accounts.list_user_groups(journal.journal_id)
      assert is_list(groups)
      assert length(groups) > 0
    end

    @tag :groups
    test "create_user_group", %{journal: journal} do
      {:ok, group} = Accounts.create_user_group(%{
        context_id: journal.journal_id,
        role_id: Roles.editor(),
        is_default: 0
      })
      
      assert group.context_id == journal.journal_id
      assert group.role_id == Roles.editor()
      assert group.is_default == 0
    end

    @tag :groups
    test "create_user_group allows several groups with the same role in one journal (as in OJS)", %{journal: journal} do
      {:ok, group1} = Accounts.create_user_group(%{
        context_id: journal.journal_id,
        role_id: Roles.editor(),
        is_default: 0
      })
      
      {:ok, _group2} = Accounts.create_user_group(%{
        context_id: journal.journal_id,
        role_id: Roles.editor(),
        is_default: 0
      })
    end

    @tag :groups
    test "update_user_group", %{journal: journal} do
      {:ok, group} = Accounts.create_user_group(%{
        context_id: journal.journal_id,
        role_id: Roles.author(),
        is_default: 0
      })
      
      {:ok, updated} = Accounts.update_user_group(group, %{
        is_default: 1,
        permit_self_registration: 1
      })
      
      assert updated.is_default == 1
      assert updated.permit_self_registration == 1
    end

    @tag :groups
    test "delete_user_group prevents if users assigned", %{journal: journal} do
      {:ok, group} = Accounts.create_user_group(%{
        context_id: journal.journal_id,
        role_id: Roles.reviewer(),
        is_default: 0
      })
      
      user = user_fixture()
      Accounts.enroll_user(user.user_id, group.user_group_id, user.user_id)
      
      {:error, :has_assigned_users} = Accounts.delete_user_group(group)
    end

    @tag :groups
    test "set_default_group", %{journal: journal} do
      {:ok, group1} = Accounts.create_user_group(%{
        context_id: journal.journal_id,
        role_id: Roles.author(),
        is_default: 1
      })
      
      {:ok, group2} = Accounts.create_user_group(%{
        context_id: journal.journal_id,
        role_id: Roles.editor(),
        is_default: 0
      })
      
      {:ok, _} = Accounts.set_default_group(journal.journal_id, group2.user_group_id)
      
      reloaded1 = Repo.get!(UserGroup, group1.user_group_id)
      reloaded2 = Repo.get!(UserGroup, group2.user_group_id)
      assert reloaded1.is_default == 0
      assert reloaded2.is_default == 1
    end
  end

  describe "Stage Assignment" do
    setup do
      journal = Repo.get!(Journal, 1)
      {:ok, group} = Accounts.create_user_group(%{
        context_id: journal.journal_id,
        role_id: Roles.editor(),
        is_default: 0
      })
      {:ok, journal: journal, group: group}
    end

    @tag :stages
    test "set_stages and stages_for_group_in_journal", %{group: group, journal: journal} do
      {:ok, :stages_updated} = Accounts.set_stages(group.user_group_id, journal.journal_id, [1, 3, 4])
      
      stages = Accounts.stages_for_group_in_journal(group.user_group_id, journal.journal_id)
      assert stages == [1, 3, 4]
    end

    @tag :stages
    test "set_stages replaces existing stages", %{group: group, journal: journal} do
      {:ok, :stages_updated} = Accounts.set_stages(group.user_group_id, journal.journal_id, [1, 3])
      {:ok, :stages_updated} = Accounts.set_stages(group.user_group_id, journal.journal_id, [4, 5])
      
      stages = Accounts.stages_for_group_in_journal(group.user_group_id, journal.journal_id)
      assert stages == [4, 5]
    end
  end

  describe "User Role Assignment" do
    setup do
      journal = Repo.get!(Journal, 1)
      {:ok, author_group} = Accounts.create_user_group(%{
        context_id: journal.journal_id,
        role_id: Roles.author(),
        is_default: 1
      })
      
      {:ok, editor_group} = Accounts.create_user_group(%{
        context_id: journal.journal_id,
        role_id: Roles.editor(),
        is_default: 0
      })
      
      {:ok, journal: journal, author_group: author_group, editor_group: editor_group}
    end

    @tag :enrollment
    test "enroll_user", %{author_group: author_group} do
      user = user_fixture()
      
      {:ok, :enrolled} = Accounts.enroll_user(user.user_id, author_group.user_group_id, user.user_id)
      
      roles = Accounts.list_user_roles(user.user_id)
      assert length(roles) == 1
      assert Enum.any?(roles, &(&1.role_id == Roles.author()))
    end

    @tag :enrollment
    test "enroll_user prevents duplicate", %{author_group: author_group} do
      user = user_fixture()
      Accounts.enroll_user(user.user_id, author_group.user_group_id, user.user_id)
      
      {:error, :already_enrolled} = Accounts.enroll_user(user.user_id, author_group.user_group_id, user.user_id)
    end

    @tag :enrollment
    test "unenroll_user", %{author_group: author_group} do
      user = user_fixture()
      Accounts.enroll_user(user.user_id, author_group.user_group_id, user.user_id)
      
      {:ok, :unenrolled} = Accounts.unenroll_user(user.user_id, author_group.user_group_id, user.user_id)
      
      roles = Accounts.list_user_roles(user.user_id)
      assert roles == []
    end

    @tag :enrollment
    test "list_user_roles across journals", %{author_group: author_group, editor_group: editor_group, journal: journal} do
      user = user_fixture()
      Accounts.enroll_user(user.user_id, author_group.user_group_id, user.user_id)
      
      # Add editor group for another journal
      journal2 = Repo.get!(Journal, 2)
      {:ok, editor_group2} = Accounts.create_user_group(%{
        context_id: journal2.journal_id,
        role_id: Roles.editor(),
        is_default: 0
      })
      Accounts.enroll_user(user.user_id, editor_group2.user_group_id, user.user_id)
      
      roles = Accounts.list_user_roles(user.user_id)
      assert length(roles) == 2
      assert Enum.any?(roles, &(&1.role_id == Roles.author()))
      assert Enum.any?(roles, &(&1.role_id == Roles.editor()))
    end

    @tag :enrollment
    test "bulk_enroll", %{author_group: author_group} do
      users = Enum.map(1..3, fn _ -> user_fixture() end)
      user_ids = Enum.map(users, & &1.user_id)
      
      {:ok, results} = Accounts.bulk_enroll(user_ids, author_group.user_group_id, user_ids |> List.first())
      
      assert length(results) == 3
      assert Enum.all?(results, &match?({:ok, _}, &1))
    end
  end

  describe "Approve/Reject User" do
    @tag :approval
    test "approve_user", %{user: user} do
      {:ok, suspended} = Accounts.suspend_user(user, "Test")
      {:ok, approved} = Accounts.approve_user(suspended.user_id, suspended.user_id)
      
      assert approved.disabled == 0
      assert is_nil(approved.disabled_reason)
    end

    @tag :approval
    test "reject_user", %{user: user} do
      {:ok, rejected} = Accounts.reject_user(user.user_id, "Policy violation", user.user_id)
      
      assert rejected.disabled == 1
      assert rejected.disabled_reason == "Policy violation"
    end
  end

  describe "export_users_csv" do
    setup do
      user1 = user_fixture()
      user2 = user_fixture()
      
      {:ok, group} = Accounts.create_user_group(%{
        context_id: 1,
        role_id: Roles.author(),
        is_default: 1
      })
      
      Accounts.enroll_user(user1.user_id, group.user_group_id, user1.user_id)
      Accounts.enroll_user(user2.user_id, group.user_group_id, user2.user_id)
      
      :ok
    end

    @tag :csv
    test "exports users with all columns", _ do
      csv = Accounts.export_users_csv(%{})
      
      lines = String.split(csv, "\n", trim: true)
      assert length(lines) >= 2  # header + data
      
      header = lines[0]
      assert "User ID" in header
      assert "Username" in header
      assert "Email" in header
      assert "Roles" in header
      assert "Journals" in header
    end
  end
end