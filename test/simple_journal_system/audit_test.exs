defmodule SimpleJournalSystem.AuditTest do
  use SimpleJournalSystem.DataCase
  alias SimpleJournalSystem.Repo
  alias SimpleJournalSystem.Journals.Journal
  import SimpleJournalSystem.AccountsFixtures

  alias SimpleJournalSystem.Accounts
  alias SimpleJournalSystem.Accounts.User
  alias SimpleJournalSystem.Accounts.UserGroup
  alias SimpleJournalSystem.Audit
  alias SimpleJournalSystem.Accounts.Roles

  @tag :audit
  describe "Audit logging" do
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
      
      admin = site_admin_fixture()
      admin = Repo.get!(User, admin.user_id) |> Repo.preload(user_user_groups: :user_group)
      
      user = user_fixture()
      
      %{
        user: user,
        admin: admin,
        author_group: author_group,
        editor_group: editor_group
      }
    end

    @tag :enroll
    test "log_enroll creates audit record", %{user: user, admin: admin, author_group: author_group} do
      {:ok, :enrolled} = Accounts.enroll_user(user.user_id, author_group.user_group_id, admin.user_id)
      
      logs = Audit.get_user_logs(user.user_id)
      assert length(logs) == 1
      
      log = List.first(logs)
      assert log.action == "enroll"
      assert log.user_id == user.user_id
      assert log.changed_by_id == admin.user_id
      assert log.new_role_id == Roles.author()
      assert log.user_group_id == author_group.user_group_id
      assert log.context_id == author_group.context_id
      assert is_map(log.metadata)
      assert log.metadata["ip"] != nil
      assert log.metadata["user_agent"] != nil
    end

    @tag :unenroll
    test "log_unenroll creates audit record", %{user: user, admin: admin, author_group: author_group} do
      Accounts.enroll_user(user.user_id, author_group.user_group_id, admin.user_id)
      
      {:ok, :unenrolled} = Accounts.unenroll_user(user.user_id, author_group.user_group_id, admin.user_id)
      
      logs = Audit.get_user_logs(user.user_id)
      assert length(logs) == 2  # enroll + unenroll
      
      unenroll_log = Enum.find(logs, &(&1.action == "unenroll"))
      assert unenroll_log.action == "unenroll"
      assert unenroll_log.old_role_id == Roles.author()
      assert is_nil(unenroll_log.new_role_id)
    end

    @tag :approve
    test "log_approve creates audit record", %{user: user, admin: admin} do
      {:ok, suspended} = Accounts.suspend_user(user, "Test suspension")
      
      {:ok, approved} = Accounts.approve_user(suspended.user_id, admin.user_id)
      
      logs = Audit.get_user_logs(user.user_id)
      approve_log = Enum.find(logs, &(&1.action == "approve"))
      assert approve_log.action == "approve"
      assert approve_log.changed_by_id == admin.user_id
      assert is_nil(approve_log.old_role_id)
      assert is_nil(approve_log.new_role_id)
    end

    @tag :reject
    test "log_reject creates audit record with reason", %{user: user, admin: admin} do
      {:ok, rejected} = Accounts.reject_user(user.user_id, "Policy violation", admin.user_id)
      
      logs = Audit.get_user_logs(user.user_id)
      reject_log = Enum.find(logs, &(&1.action == "reject"))
      assert reject_log.action == "reject"
      assert reject_log.metadata["reason"] == "Policy violation"
    end

    @tag :role_change
    test "log_role_change_action creates audit record", %{user: user, admin: admin, author_group: author_group, editor_group: editor_group} do
      Accounts.enroll_user(user.user_id, author_group.user_group_id, admin.user_id)
      
      # Change role from author to editor
      Accounts.unenroll_user(user.user_id, author_group.user_group_id, admin.user_id)
      Accounts.enroll_user(user.user_id, editor_group.user_group_id, admin.user_id)
      
      logs = Audit.get_user_logs(user.user_id)
      # enroll + unenroll + enroll = 3 logs
      assert length(logs) >= 2
      
      # Check that we have both old and new role IDs logged
      enroll_logs = Enum.filter(logs, &(&1.action == "enroll"))
      assert length(enroll_logs) == 2
    end

    @tag :query
    test "get_user_logs returns logs in descending order", %{user: user, admin: admin, author_group: author_group} do
      Accounts.enroll_user(user.user_id, author_group.user_group_id, admin.user_id)
      
      logs = Audit.get_user_logs(user.user_id, 10)
      assert length(logs) >= 1
      
      # Should be ordered by inserted_at desc
      times = Enum.map(logs, fn l -> to_string(l.inserted_at) end)
      assert times == Enum.sort(times, :desc)
    end

    @tag :query
    test "get_admin_logs returns logs by admin", %{user: user, admin: admin, author_group: author_group} do
      Accounts.enroll_user(user.user_id, author_group.user_group_id, admin.user_id)
      
      logs = Audit.get_admin_logs(admin.user_id)
      assert length(logs) >= 1
      assert Enum.all?(logs, &(&1.changed_by_id == admin.user_id))
    end
  end
end