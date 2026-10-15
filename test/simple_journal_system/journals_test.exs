defmodule SimpleJournalSystem.JournalsTest do
  use SimpleJournalSystem.DataCase
  import SimpleJournalSystem.AccountsFixtures

  alias SimpleJournalSystem.Journals
  alias SimpleJournalSystem.Journals.Journal
  alias SimpleJournalSystem.Accounts
  alias SimpleJournalSystem.Accounts.User
  alias SimpleJournalSystem.Accounts.UserGroup
  alias SimpleJournalSystem.Accounts.Roles

  @tag :journals
  describe "Journals context" do
    setup do
      journals = Repo.all(Journal)
      {:ok, journals: journals}
    end

    @tag :list
    test "list_journals returns all journals", %{journals: journals} do
      result = Journals.list_journals()
      assert length(result) >= 2
      assert Enum.any?(result, &(&1.path == "ojs"))
      assert Enum.any?(result, &(&1.path == "ojs2"))
    end

    @tag :list
    test "list_enabled_journals returns only enabled", %{journals: journals} do
      enabled = Journals.list_enabled_journals()
      assert Enum.all?(enabled, &(&1.enabled == 1))
    end

    @tag :get
    test "get_journal! returns journal by id" do
      journal = Repo.get!(Journal, 1)
      assert journal.path == "ojs"
    end

    @tag :get
    test "get_journal_by_path returns journal by path" do
      journal = Journals.get_journal_by_path("ojs")
      assert journal.path == "ojs"
      assert journal.journal_id == 1
    end

    @tag :get
    test "get_journal_by_path returns nil for invalid path" do
      refute Journals.get_journal_by_path("nonexistent")
    end

    @tag :crud
    test "create_journal creates new journal" do
      {:ok, journal} = Journals.create_journal(%{
        path: "testjournal#{System.unique_integer()}",
        seq: 10.0,
        primary_locale: "en",
        enabled: 1
      })
      
      assert journal.path != nil
      assert journal.enabled == 1
    end

    @tag :crud
    test "update_journal updates journal" do
      journal = Repo.get!(Journal, 1)
      {:ok, updated} = Journals.update_journal(journal, %{enabled: 0})
      
      assert updated.enabled == 0
    end

    @tag :crud
    test "delete_journal deletes journal" do
      {:ok, journal} = Journals.create_journal(%{
        path: "delete#{System.unique_integer()}",
        seq: 1.0,
        primary_locale: "en",
        enabled: 1
      })
      
      {:ok, _} = Journals.delete_journal(journal)
      refute Repo.get(Journal, journal.journal_id)
    end
  end

  describe "User-Journal relationships" do
    setup do
      journal = Repo.get!(Journal, 1)
      {:ok, author_group} = Accounts.create_user_group(%{
        context_id: journal.journal_id,
        role_id: Roles.author(),
        is_default: 1
      })
      
      user = user_fixture()
      Accounts.enroll_user(user.user_id, author_group.user_group_id, user.user_id)
      
      {:ok, user: user, journal: journal, author_group: author_group}
    end

    @tag :user_journals
    test "list_user_journals returns journals where user has role", %{user: user, journal: journal} do
      journals = Journals.list_user_journals(user.user_id)
      assert Enum.any?(journals, &(&1.journal_id == journal.journal_id))
    end

    @tag :user_journals
    test "switch_journal succeeds when user has role", %{user: user, journal: journal} do
      {:ok, switched} = Journals.switch_journal(user.user_id, journal.journal_id)
      assert switched.journal_id == journal.journal_id
    end

    @tag :user_journals
    test "switch_journal fails when user lacks role", %{user: user} do
      journal2 = Repo.get!(Journal, 2)
      {:error, :no_access} = Journals.switch_journal(user.user_id, journal2.journal_id)
    end

    @tag :user_journals
    test "get_user_default_journal returns journal with default role", %{user: user, journal: journal} do
      default = Journals.get_user_default_journal(user.user_id)
      assert default.journal_id == journal.journal_id
    end
  end
end