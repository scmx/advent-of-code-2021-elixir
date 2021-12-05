defmodule Adventofcode.Day05HydrothermalVentureTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day05HydrothermalVenture

  alias Adventofcode.Day05HydrothermalVenture.{Parser}

  @example """
  0,9 -> 5,9
  8,0 -> 0,8
  9,4 -> 3,4
  2,2 -> 2,1
  7,0 -> 7,4
  6,4 -> 2,0
  0,9 -> 2,9
  3,4 -> 1,4
  0,0 -> 8,8
  5,5 -> 8,2
  """

  describe "part_1/1" do
    test "" do
      assert 5 = @example |> part_1()
    end

    test_with_puzzle_input do
      assert 6710 = puzzle_input() |> part_1()
    end
  end

  describe "Parser.parse/1" do
    test "parses input" do
      assert [
               {0..2, 9..9},
               {0..5, 9..9},
               {0..8, 0..8},
               {0..8, 0..8},
               {1..3, 4..4},
               {2..2, 1..2},
               {2..6, 0..4},
               {3..9, 4..4},
               {5..8, 2..5},
               {7..7, 0..4}
             ] = @example |> Parser.parse()
    end
  end
end
