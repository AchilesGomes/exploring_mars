defmodule ExploringMarsTest do
  use ExploringMarsWeb.ConnCase

  alias ExploringMars.GetProbeData

  describe "execute_commands/1" do
    test "executes a single command" do
      GetProbeData.reset()
      result = ExploringMars.execute_commands(["M"])

      assert result == {:ok, {{1, 0}, "D"}}
    end

    test "executes commands" do
      GetProbeData.reset()

      assert ExploringMars.execute_commands(["GE", "M", "M", "M", "GD", "M", "M"]) ==
               {:ok, {{2, 3}, "D"}}
    end

    test "executes commands separately in a multiple executions" do
      GetProbeData.reset()

      assert ExploringMars.execute_commands(["M", "GE", "M"]) == {:ok, {{1, 1}, "C"}}
      assert ExploringMars.execute_commands(["GE", "M"]) == {:ok, {{0, 1}, "E"}}
      assert ExploringMars.execute_commands(["GD", "M", "GD", "M", "M"]) == {:ok, {{2, 2}, "D"}}
    end

    test "executes commands when have invalid coordinates on x axis" do
      GetProbeData.reset()

      {error, message} = ExploringMars.execute_commands(["GE", "GE", "M"])

      assert message =~ "Um movimento inválido foi detectado no comando 3 do eixo X"
    end

    test "executes commands when have invalid coordinates on y axis" do
      GetProbeData.reset()

      {error, message} = ExploringMars.execute_commands(["GD", "M"])

      assert message =~ "Um movimento inválido foi detectado no comando 2 do eixo Y"
    end

    test "handle error when commands is malformed" do
      GetProbeData.reset()

      {error, message} = ExploringMars.execute_commands("M")

      assert message =~ "Comando(s) inválido(s), por gentileza consulte a documentação."
    end
  end
end
