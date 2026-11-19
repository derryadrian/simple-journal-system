defmodule SimpleJournalSystem.PublicationGalleySettingTest do
  use SimpleJournalSystem.DataCase, async: true

  alias SimpleJournalSystem.Submissions.PublicationGalleySetting

  describe "changeset/2" do
    test "menerima setting galley dengan data valid" do
      changeset =
        PublicationGalleySetting.changeset(%PublicationGalleySetting{}, %{
          galley_id: 1,
          locale: "id",
          setting_name: "label",
          setting_value: "PDF"
        })

      assert changeset.valid?
    end

    test "menolak setting tanpa galley_id" do
      changeset =
        PublicationGalleySetting.changeset(%PublicationGalleySetting{}, %{
          locale: "id",
          setting_name: "label"
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).galley_id
    end

    test "menolak setting tanpa setting_name" do
      changeset =
        PublicationGalleySetting.changeset(%PublicationGalleySetting{}, %{
          galley_id: 1,
          locale: "id"
        })

      refute changeset.valid?
      assert "can't be blank" in errors_on(changeset).setting_name
    end

    test "default locale adalah string kosong" do
      setting = %PublicationGalleySetting{}

      assert setting.locale == ""
    end

    test "mengizinkan setting_value bernilai nil" do
      changeset =
        PublicationGalleySetting.changeset(%PublicationGalleySetting{}, %{
          galley_id: 1,
          locale: "id",
          setting_name: "label",
          setting_value: nil
        })

      assert changeset.valid?
    end
  end
end
