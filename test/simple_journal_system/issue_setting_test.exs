defmodule SimpleJournalSystem.Issues.IssueSettingTest do
  use SimpleJournalSystem.DataCase, async: true

  alias SimpleJournalSystem.Issues.IssueSetting

  describe "changeset/2" do
    test "menerima setting issue dengan data valid" do
      changeset =
        IssueSetting.changeset(%IssueSetting{}, %{
          issue_id: 1,
          locale: "id",
          setting_name: "title",
          setting_value: "Edisi Pertama"
        })

      assert changeset.valid?
    end

    test "menolak setting tanpa issue_id" do
      changeset =
        IssueSetting.changeset(%IssueSetting{}, %{
          locale: "id",
          setting_name: "title"
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).issue_id
    end

    test "menolak setting tanpa setting_name" do
      changeset =
        IssueSetting.changeset(%IssueSetting{}, %{
          issue_id: 1,
          locale: "id"
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).setting_name
    end

    test "default locale adalah string kosong" do
      setting = %IssueSetting{}

      assert setting.locale == ""
    end

    test "mengizinkan setting_value bernilai nil" do
      changeset =
        IssueSetting.changeset(%IssueSetting{}, %{
          issue_id: 1,
          locale: "id",
          setting_name: "title",
          setting_value: nil
        })

      assert changeset.valid?
    end
  end
end
