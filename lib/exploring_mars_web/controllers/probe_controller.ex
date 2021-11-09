defmodule ExploringMarsWeb.ProbeController do
  use ExploringMarsWeb, :controller

  def reset(conn, %{}) do
    send_resp(conn, :ok, Jason.encode!(%{response: "Probe position reseted"}))
  end

  def send_probe_to_endpoint(conn, %{"movimentos" => coordenadas}) do
    result =
      coordenadas
      |> ExploringMars.process()
      |> handle_result()

    send_resp(conn, :ok, Jason.encode!(result))
  end
end
