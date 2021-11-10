defmodule ExploringMarsWeb.ProbeController do
  use ExploringMarsWeb, :controller

  alias ExploringMars.GetProbeData

  def execute(conn, %{"movimentos" => coordenadas}) do
    with {:ok, data} <- ExploringMars.execute_commands(coordenadas) do
      conn
      |> put_status(:ok)
      |> render("show.json", %{probe: data})
    else
      {:error, error} ->
        conn
        |> put_status(:ok)
        |> render("error.json", %{erro: error})
    end
  end

  def get_position(conn, _) do
    data = GetProbeData.get()

    conn
    |> put_status(:ok)
    |> render("show.json", %{probe: data})
  end

  def reset(conn, %{}) do
    GetProbeData.reset()

    send_resp(conn, :no_content, "")
  end
end
