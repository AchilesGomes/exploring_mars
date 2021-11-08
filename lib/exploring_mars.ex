defmodule ExploringMars do
  @moduledoc """
  ExploringMars keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  @directions ~w[C D B E]

  @spec generate_matrix(list()) :: list()
  def generate_matrix([x, y] = z) when is_list(z) do
    for i <- x..0, do: for j <- 0..y, do: {j, i}
  end

  @spec process(map()) :: tuple()
  def process(coords) do
    search(coords, "D", {0, 0})
  end

  def search(cmds, direction, initial_position) do
    do_search(cmds, direction, initial_position, [])
  end

  def do_search([], _direction, _position, sum) do
    sum
  end
  def do_search(cmds, direction, position, sum) when is_list(cmds) do
    [cmd | cmds] = cmds
    new_direction = find_direction(direction, cmd)
    new_position = move(position, new_direction, cmd)
    sum = {new_position, new_direction}
    do_search(cmds, new_direction, new_position, sum)
  end
  def do_search([_h | t], direction, position, sum) do
    do_search(t, direction, position, sum)
  end
  def do_search(_, _, _, _), do: :error

  def find_direction(direction, coord) when direction in(@directions) and coord in(~w[GE GD]) do
    case {direction, coord} do
      {"C", "GE"} -> "E"
      {"C", "GD"} -> "D"
      {"D", "GE"} -> "C"
      {"D", "GD"} -> "B"
      {"B", "GE"} -> "D"
      {"B", "GD"} -> "E"
      {"E", "GE"} -> "B"
      {"E", "GD"} -> "C"
    end
  end
  def find_direction(direction, _), do: direction

  def move({x, y}, new_direction, "M") when new_direction in(@directions) do
    case new_direction do
      "C" -> {x, y + 1}
      "D" -> {x + 1, y}
      "B" -> {x, y - 1}
      "E" -> {x - 1, y}
    end
  end
  def move({x, y}, _, _), do: {x, y}
end
