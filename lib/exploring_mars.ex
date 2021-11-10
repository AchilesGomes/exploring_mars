defmodule ExploringMars do

  alias ExploringMars.GetProbeData

  @spec execute_commands(list()) :: {{integer(), integer()}, binary()} | {:error, binary()}
  def execute_commands(commands) when is_list(commands) do
    :global.set_lock({__MODULE__, 1})

    commands
    |> Enum.with_index()
    |> Enum.map_reduce(GetProbeData.get(), fn {command, idx}, current_state ->
      command
      |> try_command(idx, current_state)
      |> case do
        {:ok, state} ->
          {command, state}

        {:error, error} ->
          throw(error)
      end
    end)
    |> execute_command()

    {:ok, GetProbeData.get()}
  catch
    error -> {:error, error}
  after
    :global.del_lock({__MODULE__, 1})
  end

  defp try_command(command, _idx, {coordinates, current_direction}) when command in ~w[GE GD] do
    new_direction =
      case {current_direction, command} do
        {"C", "GE"} -> "E"
        {"C", "GD"} -> "D"
        {"D", "GE"} -> "C"
        {"D", "GD"} -> "B"
        {"B", "GE"} -> "D"
        {"B", "GD"} -> "E"
        {"E", "GE"} -> "B"
        {"E", "GD"} -> "C"
      end

    {:ok, {coordinates, new_direction}}
  end

  defp try_command("M", idx, {{x, y}, current_direction}) do()
    current_direction
    |> case do
      "C" -> {{x, y + 1}, "C"}
      "D" -> {{x + 1, y}, "D"}
      "B" -> {{x, y - 1}, "B"}
      "E" -> {{x - 1, y}, "E"}
    end
    |> handle_result(idx)
  end

  defp execute_command({command, state}) do
    ExploringMars.GetProbeData.update(state)
  end

  defp handle_result({{x, y}, face} = state, idx) do
    case {x, y} do
      {x, _} when x > 4 or x < 0 ->
        {:error, "Um movimento inválido foi detectado no comando #{idx + 1} do eixo X, a posição de destino era eixo x: #{x} e eixo y: #{y} com a face para #{face}."}

      {_, y} when y > 4 or y < 0 ->
        {:error, "Um movimento inválido foi detectado no comando #{idx + 1} do eixo Y, a posição de destino era eixo x: #{x} e eixo y: #{y} com a face para #{face}."}

      _ ->
       {:ok, state}
    end
  end
end
