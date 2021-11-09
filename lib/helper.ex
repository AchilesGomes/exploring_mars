defmodule ExploringMars.Helper do

  @spec handle_result({{integer(), integer()}, binary()}) :: %{erro: binary()} | %{x: integer(), y: integer(), face: binary()}
  def handle_result({values, face}) do
    case values do
      {x, _} when x > 5 or x < 0 ->
        %{"erro":
          "Um movimento inválido foi detectado no eixo X, infelizmente a sonda ainda não possui a habilidade de executar esse movimento."}

      {_, y} when y > 5 or y < 0 ->
        %{"erro":
          "Um movimento inválido foi detectado no eixo Y, infelizmente a sonda ainda não possui a habilidade de executar esse movimento."}

      {x, y} ->
        %{
          x: x,
          y: y,
          face: face
        }
    end
  end
end
