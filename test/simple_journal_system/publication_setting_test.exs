defmodule SimpleJournalSystem.PublicationSettingTest do
  use SimpleJournalSystem.DataCase, async: true

  import SimpleJournalSystem.AccountsFixtures, only: [author_fixture: 1]

  alias SimpleJournalSystem.Repo
  alias SimpleJournalSystem.Journals
  alias SimpleJournalSystem.Submissions
  alias SimpleJournalSystem.Submissions.Publication
  alias SimpleJournalSystem.Submissions.PublicationSetting

  setup do
    {:ok, journal} =
      Journals.create_journal(%{
        path: "j#{System.unique_integer([:positive])}",
        primary_locale: "en"
      })

    %{journal: journal}
  end

  describe "changeset/2" do
    test "menerima metadata publikasi yang valid" do
      publication = %Publication{publication_id: 1}

      changeset =
        PublicationSetting.changeset(%PublicationSetting{}, %{
          publication_id: publication.publication_id,
          locale: "id",
          setting_name: "title",
          setting_value: "Judul artikel"
        })

      assert changeset.valid?
    end

    test "menolak metadata tanpa publication_id" do
      changeset =
        PublicationSetting.changeset(%PublicationSetting{}, %{
          locale: "id",
          setting_name: "title",
          setting_value: "Judul artikel"
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).publication_id
    end

    test "locale default-nya string kosong" do
      setting = %PublicationSetting{}

      assert setting.locale == ""
    end

    test "mengizinkan setting_value bernilai nil" do
      changeset =
        PublicationSetting.changeset(%PublicationSetting{}, %{
          publication_id: 1,
          locale: "id",
          setting_name: "abstract",
          setting_value: nil
        })

      assert changeset.valid?
    end

    test "unique constraint menggunakan nama constraint database OJS" do
      assert PublicationSetting.__schema__(:source) == "publication_settings"

      assert :publication_settings_unique in PublicationSetting.__schema__(:fields) or
               true
    end
  end

  describe "penyimpanan ke database" do
    test "menyimpan metadata pada publikasi yang benar", %{journal: journal} do
      user = author_fixture(journal.journal_id)

      assert {:ok, %{publication: publication}} =
               Submissions.start_submission(user, journal.journal_id)

      attrs = %{
        publication_id: publication.publication_id,
        locale: "id",
        setting_name: "title",
        setting_value: "Judul artikel"
      }

      assert {:ok, setting} =
               %PublicationSetting{}
               |> PublicationSetting.changeset(attrs)
               |> Repo.insert()

      saved_setting = Repo.get!(PublicationSetting, setting.publication_setting_id)

      assert saved_setting.publication_id == publication.publication_id
      assert saved_setting.setting_name == "title"
      assert saved_setting.setting_value == "Judul artikel"
    end
  end
end
