defmodule ExploringMarsWeb.FallbackController do
  use Phoenix.Controller

  alias ExploringMarsWeb.ErrorView

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, message}) do
    conn
    |> put_status(200)
    |> put_view(ErrorView)
    |> render("error.json", %{erro: message})
  end
end
