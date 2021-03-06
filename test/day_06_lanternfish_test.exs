defmodule Adventofcode.Day06LanternfishTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day06Lanternfish

  alias Adventofcode.Day06Lanternfish.{Parser}

  @example """
  3,4,3,1,2
  """

  describe "part_1/1" do
    test "how many lanternfish after 80 days" do
      assert 5934 = @example |> part_1()
    end

    test_with_puzzle_input do
      assert 379_414 = puzzle_input() |> part_1()
    end
  end

  describe "part_2/1" do
    test "how many lanternfish after 256 days" do
      assert 26_984_457_539 = @example |> part_2()
    end

    test_with_puzzle_input do
      assert 1_705_008_653_296 = puzzle_input() |> part_2()
    end
  end

  describe "Parser.parse/1" do
    test "parses input" do
      assert %{1 => 1, 2 => 1, 3 => 2, 4 => 1} = @example |> Parser.parse()
    end
  end
end
