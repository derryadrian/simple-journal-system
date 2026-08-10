defmodule SimpleJournalSystemWeb.ErrorJSONTest do
  use SimpleJournalSystemWeb.ConnCase, async: true

  test "renders 404" do
    assert SimpleJournalSystemWeb.ErrorJSON.render("404.json", %{}) == %{
             errors: %{detail: "Not Found"}
           }
  end

  test "renders 500" do
    assert SimpleJournalSystemWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
