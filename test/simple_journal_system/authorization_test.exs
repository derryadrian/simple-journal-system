defmodule SimpleJournalSystem.AuthorizationTest do
  use SimpleJournalSystem.DataCase

  import SimpleJournalSystem.AccountsFixtures

  alias SimpleJournalSystem.Accounts
  alias SimpleJournalSystem.Accounts.User
  alias SimpleJournalSystem.Accounts.UserGroup
  alias SimpleJournalSystem.Accounts.UserUserGroup
  alias SimpleJournalSystem.Authorization
  alias SimpleJournalSystem.Accounts.Roles
  alias SimpleJournalSystem.Journals.Journal

  @tag :authorization
  describe "get_roles/1" do
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
      
      {:ok, reviewer_group} = Accounts.create_user_group(%{
        context_id: journal.journal_id,
        role_id: Roles.reviewer(),
        is_default: 0
      })
      
      user = user_fixture()
      Accounts.enroll_user(user.user_id, author_group.user_group_id, user.user_id)
      Accounts.enroll_user(user.user_id, editor_group.user_group_id, user.user_id)
      
      user = Repo.get!(User, user.user_id) |> Repo.preload(user_user_groups: :user_group)
      %{
        user: user,
        author_group: author_group,
        editor_group: editor_group,
        reviewer_group: reviewer_group
      }
    end

    @tag :get_roles
    test "returns all role_ids for user", %{user: user} do
      roles = Authorization.get_roles(user)
      assert length(roles) == 2
      assert Roles.author() in roles
      assert Roles.editor() in roles
    end

    @tag :get_roles
    test "returns empty list for user without roles" do
      user = user_fixture() |> Repo.preload(user_user_groups: :user_group)
      assert Authorization.get_roles(user) == []
    end

    @tag :get_roles
    test "returns empty list for nil" do
      assert Authorization.get_roles(nil) == []
    end
  end

  describe "has_role?/2" do
    setup do
      journal = Repo.get!(Journal, 1)
      {:ok, author_group} = Accounts.create_user_group(%{
        context_id: journal.journal_id,
        role_id: Roles.author(),
        is_default: 1
      })
      
      user = user_fixture()
      Accounts.enroll_user(user.user_id, author_group.user_group_id, user.user_id)
      user = Repo.get!(User, user.user_id) |> Repo.preload(user_user_groups: :user_group)
      
      %{
        user: user,
        author_group: author_group
      }
    end

    @tag :has_role
    test "returns true when user has the role", %{user: user} do
      assert Authorization.has_role?(user, Roles.author())
    end

    @tag :has_role
    test "returns false when user doesn't have the role", %{user: user} do
      refute Authorization.has_role?(user, Roles.editor())
    end

    @tag :has_role
    test "returns false for nil user" do
      refute Authorization.has_role?(nil, Roles.author())
    end
  end

  describe "has_any_role?/2" do
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
      
      user = user_fixture()
      Accounts.enroll_user(user.user_id, author_group.user_group_id, user.user_id)
      user = Repo.get!(User, user.user_id) |> Repo.preload(user_user_groups: :user_group)
      
      %{
        user: user,
        author_group: author_group,
        editor_group: editor_group
      }
    end

    @tag :has_any_role
    test "returns true when user has at least one role", %{user: user} do
      assert Authorization.has_any_role?(user, [Roles.author(), Roles.editor()])
      assert Authorization.has_any_role?(user, [Roles.manager(), Roles.author()])
    end

    @tag :has_any_role
    test "returns false when user has none of the roles", %{user: user} do
      refute Authorization.has_any_role?(user, [Roles.editor(), Roles.reviewer()])
    end
  end

  describe "has_all_roles?/2" do
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
      
      user = user_fixture()
      Accounts.enroll_user(user.user_id, author_group.user_group_id, user.user_id)
      Accounts.enroll_user(user.user_id, editor_group.user_group_id, user.user_id)
      user = Repo.get!(User, user.user_id) |> Repo.preload(user_user_groups: :user_group)
      
      %{
        user: user,
        author_group: author_group,
        editor_group: editor_group
      }
    end

    @tag :has_all_roles
    test "returns true when user has all roles", %{user: user} do
      assert Authorization.has_all_roles?(user, [Roles.author(), Roles.editor()])
    end

    @tag :has_all_roles
    test "returns false when user is missing any role", %{user: user} do
      refute Authorization.has_all_roles?(user, [Roles.author(), Roles.editor(), Roles.reviewer()])
    end
  end

  describe "helper functions" do
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
      
      user = user_fixture()
      Accounts.enroll_user(user.user_id, author_group.user_group_id, user.user_id)
      Accounts.enroll_user(user.user_id, editor_group.user_group_id, user.user_id)
      user = Repo.get!(User, user.user_id) |> Repo.preload(user_user_groups: :user_group)
      
      %{
        user: user,
        author_group: author_group,
        editor_group: editor_group
      }
    end

    @tag :helpers
    test "is_author?", %{user: user} do
      assert Authorization.is_author?(user)
    end

    @tag :helpers
    test "is_editor?", %{user: user} do
      assert Authorization.is_editor?(user)
    end

    @tag :helpers
    test "is_reviewer?", %{user: user} do
      refute Authorization.is_reviewer?(user)
    end

    @tag :helpers
    test "is_site_admin?" do
      admin = site_admin_fixture()
      admin = Repo.get!(User, admin.user_id) |> Repo.preload(user_user_groups: :user_group)
      assert Authorization.is_site_admin?(admin)
    end

    @tag :helpers
    test "is_journal_manager?" do
      journal = Repo.get!(Journal, 1)
      jm = journal_manager_fixture(journal.journal_id)
      jm = Repo.get!(User, jm.user_id) |> Repo.preload(user_user_groups: :user_group)
      assert Authorization.is_journal_manager?(jm)
    end
  end

  describe "multi-journal roles" do
    setup do
      journal1 = Repo.get!(Journal, 1)
      journal2 = Repo.get!(Journal, 2)
      
      {:ok, author_group} = Accounts.create_user_group(%{
        context_id: journal1.journal_id,
        role_id: Roles.author(),
        is_default: 1
      })
      
      {:ok, editor_group} = Accounts.create_user_group(%{
        context_id: journal2.journal_id,
        role_id: Roles.editor(),
        is_default: 0
      })
      
      user = user_fixture()
      Accounts.enroll_user(user.user_id, author_group.user_group_id, user.user_id)
      Accounts.enroll_user(user.user_id, editor_group.user_group_id, user.user_id)
      user = Repo.get!(User, user.user_id) |> Repo.preload(user_user_groups: :user_group)
      
      %{
        user: user,
        journal1: journal1,
        journal2: journal2
      }
    end

    @tag :multi_journal
    test "user has different roles in different journals", %{user: user, journal1: j1, journal2: j2} do
      roles_j1 = Accounts.list_user_roles_in_journal(user.user_id, j1.journal_id)
      roles_j2 = Accounts.list_user_roles_in_journal(user.user_id, j2.journal_id)
      
      assert Enum.any?(roles_j1, &(&1.role_id == Roles.author()))
      assert Enum.any?(roles_j2, &(&1.role_id == Roles.editor()))
    end

    @tag :multi_journal
    test "get_roles returns all roles across journals", %{user: user} do
      roles = Authorization.get_roles(user)
      assert Roles.author() in roles
      assert Roles.editor() in roles
    end
  end
end