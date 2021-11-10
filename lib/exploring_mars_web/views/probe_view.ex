defmodule ExploringMarsWeb.ProbeView do
  use ExploringMarsWeb, :view

  def render("show.json", %{probe: probe}) do
    %{data: render_one(probe, __MODULE__, "probe.json")}
  end

  def render("probe.json", %{probe: {{x, y}, face}}) do
    %{
      x: x,
      y: y,
      face: face
    }
  end

  def render("error.json", %{erro: erro}) do
    %{erro: erro}
  end
end
