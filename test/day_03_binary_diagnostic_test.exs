defmodule Adventofcode.Day03BinaryDiagnosticTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day03BinaryDiagnostic

  alias Adventofcode.Day03BinaryDiagnostic.{Parser}

  @example """
  00100
  11110
  10110
  10111
  10101
  01111
  00111
  11100
  10000
  11001
  00010
  01010
  """

  describe "part_1/1" do
    test "gamma rate * epsilon rate" do
      assert 198 = @example |> part_1()
    end

    test_with_puzzle_input do
      assert 3_429_254 = puzzle_input() |> part_1()
    end
  end

  describe "part_2/1" do
    test "life support rating of the submarine" do
      assert 230 = @example |> part_2()
    end

    test_with_puzzle_input do
      assert 5_410_338 = puzzle_input() |> part_2()
    end
  end

  describe "Parser.parse_part_1/1" do
    test "parses input" do
      assert [
               [0, 0, 1, 0, 0],
               [1, 1, 1, 1, 0],
               [1, 0, 1, 1, 0],
               [1, 0, 1, 1, 1],
               [1, 0, 1, 0, 1],
               [0, 1, 1, 1, 1],
               [0, 0, 1, 1, 1],
               [1, 1, 1, 0, 0],
               [1, 0, 0, 0, 0],
               [1, 1, 0, 0, 1],
               [0, 0, 0, 1, 0],
               [0, 1, 0, 1, 0]
             ] = @example |> Parser.parse_part_1()
    end
  end

  describe "Parser.parse_part_2/1" do
    test "parses input" do
      assert [
               "00100",
               "11110",
               "10110",
               "10111",
               "10101",
               "01111",
               "00111",
               "11100",
               "10000",
               "11001",
               "00010",
               "01010"
             ] = @example |> Parser.parse_part_2()
    end
  end
end
