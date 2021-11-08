defmodule ExploringMarsWeb.ProbeController do
  use ExploringMarsWeb, :controller

  # def create(conn, %{"movimentos" => coordenadas}) do
  def create(conn, %{}) do
    send_resp(conn, :created, Jason.encode!(%{response: "Sonda inicializada!"}))
  end
  def create(conn, _), do: send_resp(conn, :bad_request, Jason.encode!(%{response: "Ooopppss, os objetos desse JSON não corretos"}))

  def move(conn, %{"movimentos" => coordenadas}) do
    result =
      coordenadas
      |> ExploringMars.process()
      |> handle_result()

    send_resp(conn, :ok, Jason.encode!(result))
  end
end
