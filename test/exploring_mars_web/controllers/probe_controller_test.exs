defmodule ExploringMarsWeb.ProbeControllerTest do
  use ExploringMarsWeb.ConnCase

  describe "get_positin/2" do
    test "get a current position from probe", %{conn: conn} do
      conn
      |> put_resp_content_type("application/json")
      |> delete(Routes.probe_path(conn, :reset), %{})

      conn =
        conn
        |> put_resp_content_type("application/json")
        |> get(Routes.probe_path(conn, :get_position), %{})

      body = json_response(conn, 200)

      assert conn.status == 200
      assert body == %{"face" => "D", "x" => 0, "y" => 0}
    end
  end

  describe "execute/2" do
    test "execute commands when data is valid in a single request", %{conn: conn} do
      conn
      |> put_resp_content_type("application/json")
      |> delete(Routes.probe_path(conn, :reset), %{})

      conn =
        conn
        |> put_resp_content_type("application/json")
        |> post(Routes.probe_path(conn, :execute), %{
          "movimentos" => ["GE", "M", "M", "M", "GD", "M", "M"]
        })

      body = json_response(conn, 201)

      assert conn.status == 201
      assert body == %{"face" => "D", "x" => 2, "y" => 3}
    end

    test "execute commands when data is valid in a multiple request without reset", %{conn: conn} do
      conn
      |> put_resp_content_type("application/json")
      |> delete(Routes.probe_path(conn, :reset), %{})

      response =
        conn
        |> put_resp_content_type("application/json")
        |> post(Routes.probe_path(conn, :execute), %{
          "movimentos" => ["GE", "M", "M", "M", "GD", "M", "M"]
        })

      body = json_response(response, 201)

      assert response.status == 201
      assert body == %{"face" => "D", "x" => 2, "y" => 3}

      response_two =
        conn
        |> put_resp_content_type("application/json")
        |> post(Routes.probe_path(conn, :execute), %{
          "movimentos" => ["M", "M", "GD", "M"]
        })

      body = json_response(response_two, 201)

      assert response_two.status == 201
      assert body == %{"face" => "B", "x" => 4, "y" => 2}
    end

    test "execute commands when data from axis X is invalid", %{conn: conn} do
      conn
      |> put_resp_content_type("application/json")
      |> delete(Routes.probe_path(conn, :reset), %{})

      conn =
        conn
        |> put_resp_content_type("application/json")
        |> post(Routes.probe_path(conn, :execute), %{
          "movimentos" => ["M", "M", "M", "M", "M"]
        })

      body = json_response(conn, 200)

      assert conn.status == 200

      assert body == %{
               "erro" =>
                 "Um movimento inválido foi detectado no comando 5 do eixo X, a posição de destino era eixo x: 5 e eixo y: 0 com a face para D."
             }
    end

    test "execute commands when data from axis Y is invalid", %{conn: conn} do
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

  describe "reset/2" do
    test "reset probe position", %{conn: conn} do
      conn =
        conn
        |> put_resp_content_type("application/json")
        |> delete(Routes.probe_path(conn, :reset), %{})

      assert conn.status == 204
    end
  end
end
