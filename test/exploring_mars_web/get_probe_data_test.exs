defmodule ExploringMars.GetProbeDataTest do
  use ExploringMarsWeb.ConnCase, async: true

  alias ExploringMars.GetProbeData

  test "get a value" do
    GetProbeData.reset()

    assert GetProbeData.get() == {{0, 0}, "D"}
  end

  test "update a value" do
    GetProbeData.reset()
    GetProbeData.update({{1, 1}, "E"})

    assert GetProbeData.get() == {{1, 1}, "E"}
  end

  test "reset a value" do
    GetProbeData.update({{1, 1}, "E"})

    assert GetProbeData.get() == {{1, 1}, "E"}

    GetProbeData.reset()

    assert GetProbeData.get() == {{0, 0}, "D"}
  end
end
