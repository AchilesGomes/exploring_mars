defmodule ExploringMarsTest do
  use ExploringMarsWeb.ConnCase

  alias ExploringMars.GetProbeData

  describe "execute_commands/1" do
    test "execute a single command" do
      GetProbeData.reset()
      result = ExploringMars.execute_commands(["M"])

      assert result == {:ok, {{1, 0}, "D"}}
    end

    test "execute a commands in a single execution" do
      GetProbeData.reset()
      assert ExploringMars.execute_commands(["GE", "M", "M", "M", "GD", "M", "M"]) == {:ok, {{2, 3}, "D"}}
    end

    test "execute a commands separately in a multiple executions" do
      GetProbeData.reset()
      assert ExploringMars.execute_commands(["M", "GE", "M"]) == {:ok, {{1, 1}, "C"}}
      assert ExploringMars.execute_commands(["GE", "M"]) == {:ok, {{0, 1}, "E"}}
      assert ExploringMars.execute_commands(["GD", "M", "GD", "M", "M"]) == {:ok, {{2, 2}, "D"}}
    end
  end

end
