defmodule SimpleJournalSystem.Issues.IssueGalleySettingTest do
  use SimpleJournalSystem.DataCase, async: true

  alias SimpleJournalSystem.Issues.IssueGalleySetting

  describe "changeset/2" do
    test "menerima setting galley dengan data valid" do
      changeset =
        IssueGalleySetting.changeset(%IssueGalleySetting{}, %{
          galley_id: 1,
          locale: "id",
          setting_name: "label",
          setting_value: "PDF",
          setting_type: "string"
        })

      assert changeset.valid?
    end

    test "menolak setting tanpa galley_id" do
      changeset =
        IssueGalleySetting.changeset(%IssueGalleySetting{}, %{
          locale: "id",
          setting_name: "label",
          setting_type: "string"
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).galley_id
    end

    test "menolak setting tanpa setting_type" do
      changeset =
        IssueGalleySetting.changeset(%IssueGalleySetting{}, %{
          galley_id: 1,
          locale: "id",
          setting_name: "label"
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).setting_type
    end

    test "default locale adalah string kosong" do
      setting = %IssueGalleySetting{}

      assert setting.locale == ""
    end

    test "mengizinkan setting_value bernilai nil" do
      changeset =
        IssueGalleySetting.changeset(%IssueGalleySetting{}, %{
          galley_id: 1,
          locale: "id",
          setting_name: "label",
          setting_value: nil,
          setting_type: "string"
        })

      assert changeset.valid?
    end
  end
end
