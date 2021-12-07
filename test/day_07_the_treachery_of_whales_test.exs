defmodule Adventofcode.Day07TheTreacheryOfWhalesTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day07TheTreacheryOfWhales

  alias Adventofcode.Day07TheTreacheryOfWhales.{Parser}

  @example """
  16,1,2,0,4,2,7,1,2,14
  """

  describe "part_1/1" do
    test "how much fuel needed to align" do
      assert 37 = @example |> part_1()
    end

    test_with_puzzle_input do
      assert 325_528 = puzzle_input() |> part_1()
    end
  end

  describe "Parser.parse/1" do
    test "parses input" do
      assert [16, 1, 2, 0, 4, 2, 7, 1, 2, 14] = @example |> Parser.parse()
    end
  end
end
