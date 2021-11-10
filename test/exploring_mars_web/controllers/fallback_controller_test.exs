defmodule ExploringMars.FallbackControllerTest do
  use ExploringMarsWeb.ConnCase

  test "call/2 {error, message}", %{conn: conn} do
    conn
    |> put_resp_content_type("application/json")
    |> delete(Routes.probe_path(conn, :reset), %{})

    conn =
      conn
      |> put_resp_content_type("application/json")
      |> post(Routes.probe_path(conn, :execute), %{
        "movimentos" => ["GD", "M", "M"]
      })

    body = json_response(conn, 200)

    assert conn.status == 200

    assert body == %{
             "erro" =>
               "Um movimento inválido foi detectado no comando 2 do eixo Y, a posição de destino era eixo x: 0 e eixo y: -1 com a face para B."
           }
  end
end
