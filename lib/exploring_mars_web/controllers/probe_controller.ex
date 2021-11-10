defmodule ExploringMarsWeb.ProbeController do
  use ExploringMarsWeb, :controller

  alias ExploringMars.GetProbeData

  action_fallback ExploringMarsWeb.FallbackController

  def execute(conn, %{"movimentos" => coordenadas}) do
    with {:ok, data} <- ExploringMars.execute_commands(coordenadas) do
      conn
      |> put_status(:created)
      |> render("show.json", %{probe: data})
    end
  end

  def execute(conn, _), do: {:error, "JSON malformado, por gentileza consulte a documentação."}

  def get_position(conn, _) do
    data = GetProbeData.get()

    conn
    |> put_status(:ok)
    |> render("show.json", %{probe: data})
  end

  def reset(conn, _) do
    GetProbeData.reset()

    send_resp(conn, :no_content, "")
  end
end
