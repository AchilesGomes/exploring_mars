defmodule ExploringMars.HelperTest do
  use ExploringMarsWeb.ConnCase
  alias ExploringMars.Helper

  describe "handle_result/1" do
    test "handle result when X is lower than 0" do
      result = Helper.handle_result({{-1, 2}, "C"})

      assert result.erro == "Um movimento inválido foi detectado no eixo X, infelizmente a sonda ainda não possui a habilidade de executar esse movimento."
    end

    test "handle result when X is upper than 5" do
      result = Helper.handle_result({{6, 2}, "B"})

      assert result.erro == "Um movimento inválido foi detectado no eixo X, infelizmente a sonda ainda não possui a habilidade de executar esse movimento."
    end

    test "handle result when Y is lower than 0" do
      result = Helper.handle_result({{1, -1}, "E"})

      assert result.erro == "Um movimento inválido foi detectado no eixo Y, infelizmente a sonda ainda não possui a habilidade de executar esse movimento."
    end

    test "handle result when Y is upper than 5" do
      result = Helper.handle_result({{1, 6}, "D"})

      assert result.erro == "Um movimento inválido foi detectado no eixo Y, infelizmente a sonda ainda não possui a habilidade de executar esse movimento."
    end

    test "handle result when X, Y is correct" do
      result = Helper.handle_result({{1, 4}, "D"})

      assert result == %{
        x: result.x,
        y: result.y,
        face: result.face
      }
    end
  end
end
