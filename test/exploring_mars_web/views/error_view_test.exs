defmodule ExploringMarsWeb.ErrorViewTest do
  use ExploringMarsWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.json" do
    assert render(ExploringMarsWeb.ErrorView, "404.json", []) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500.json" do
    assert render(ExploringMarsWeb.ErrorView, "500.json", []) ==
             %{errors: %{detail: "Internal Server Error"}}
  end

  test "renders errors" do
    assert render(ExploringMarsWeb.ErrorView, "error.json", %{erro: "error"}) == %{erro: "error"}
  end
end
