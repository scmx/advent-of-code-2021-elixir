defmodule Adventofcode.Day09SmokeBasinTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day09SmokeBasin

  alias Adventofcode.Day09SmokeBasin.{Parser}

  @example """
  2199943210
  3987894921
  9856789892
  8767896789
  9899965678
  """

  describe "part_1/1" do
    test "sum of the risk levels of all low points on your heightmap" do
      assert 15 = @example |> part_1()
    end

    test_with_puzzle_input do
      assert 575 = puzzle_input() |> part_1()
    end
  end

  describe "part_2/1" do
    test "multiply together the sizes of the three largest basins" do
      assert 1134 = @example |> part_2()
    end

    test_with_puzzle_input do
      assert 1_019_700 = puzzle_input() |> part_2()
    end
  end

  describe "Parser.parse/1" do
    test "parses input" do
      assert %{
               {3, 3} => 7,
               {4, 0} => 9,
               {2, 1} => 8
               # ...
             } = @example |> Parser.parse()
    end
  end
end
