defmodule ExploringMarsWeb.ProbeControllerTest do
  use ExploringMarsWeb.ConnCase

  describe "reset/2" do
    test "reset probe position", %{conn: conn} do
      conn = post(conn, Routes.probe_path(conn, :reset), %{})

      assert conn.status == 200
      assert conn.resp_body =~ "Probe position reseted"
    end
  end

  describe "send_probe_to_endpoint/2" do
    test "send a probe to the endpoint", %{conn: conn} do
      conn =
        conn
        |> put_resp_content_type("application/json")
        |> post(Routes.probe_path(conn, :send_probe_to_endpoint), %{
          "movimentos" => ["GE", "M", "M", "M", "GD", "M", "M"]
        })

      body = json_response(conn, 200)

      assert conn.status == 200
      assert body == %{
        "x" => 2,
        "y" => 3,
        "face" => "D"
      }
    end
  end
end
