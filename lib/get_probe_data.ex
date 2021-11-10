defmodule ExploringMars.GetProbeData do
  use Agent

  def start_link(name \\ __MODULE__) do
    Agent.start_link(fn -> {{0, 0}, "D"} end, name)
  end

  def get do
    Agent.get(__MODULE__, & &1)
  end

  def update(coordenate) do
    Agent.update(__MODULE__, fn _ ->
      coordenate
    end)
  end

  def reset do
    Agent.update(__MODULE__, fn _ ->
      {{0, 0}, "D"}
    end)
  end
end
