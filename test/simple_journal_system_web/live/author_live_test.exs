defmodule SimpleJournalSystemWeb.AuthorLiveTest do
  use SimpleJournalSystemWeb.ConnCase

  import Phoenix.LiveViewTest
  import SimpleJournalSystem.AccountsFixtures

  alias SimpleJournalSystem.Journals
  alias SimpleJournalSystem.Repo
  alias SimpleJournalSystem.Submissions.Submission
  alias SimpleJournalSystem.Submissions.PublicationSetting

  setup %{conn: conn} do
    {:ok, journal} =
      Journals.create_journal(%{
        path: "author-live-#{System.unique_integer([:positive])}",
        primary_locale: "id"
      })

    user = author_fixture(journal.journal_id)
    conn = log_in_user(conn, user)

    %{conn: conn, journal: journal, user: user}
  end

  test "renders the New Submission page with enabled journals", %{conn: conn, journal: journal} do
    {:ok, _view, html} = live(conn, "/author")

    assert html =~ "Make a Submission"
    assert html =~ journal.path
    assert html =~ "Submission Language"
    assert html =~ "Begin Submission"
  end

  test "Begin Submission creates a draft through the OJS submission context", %{
    conn: conn,
    journal: journal
  } do
    {:ok, view, _html} = live(conn, "/author")

    submission_form =
      form(view, "#submission-start-form", %{
        "journal_id" => to_string(journal.journal_id),
        "locale" => "id"
      })

    html = render_submit(submission_form)

    assert html =~ "Submission started"

    submission = Repo.get_by!(Submission, context_id: journal.journal_id)
    assert submission.stage_id == 1
    assert submission.status == 1
    assert submission.submission_progress == "start"
  end

  test "author can save submission metadata through the form", %{
    conn: conn,
    journal: journal
  } do
    {:ok, view, _html} = live(conn, "/author")

    view
    |> form("#submission-start-form", %{
      "journal_id" => to_string(journal.journal_id),
      "locale" => "id"
    })
    |> render_submit()

    metadata_form =
      form(view, "form[phx-submit='save_metadata']", %{
        "title" => "Judul Tes LiveView",
        "abstract" => "Abstrak Tes LiveView"
      })

    html = render_submit(metadata_form)

    assert html =~ "Judul dan abstrak berhasil disimpan."

    submission = Repo.get_by!(Submission, context_id: journal.journal_id)

    title =
      Repo.get_by!(PublicationSetting,
        publication_id: submission.current_publication_id,
        locale: "id",
        setting_name: "title"
      )

    assert title.setting_value == "Judul Tes LiveView"
  end
end
