defmodule Adventofcode.Day01SonarSweepTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day01SonarSweep

  alias Adventofcode.Day01SonarSweep.{Parser}

  @example """
  199
  200
  208
  210
  200
  207
  240
  269
  260
  263
  """

  describe "part_1/1" do
    test "counts larger measurements" do
      assert 7 = @example |> part_1
    end

    test_with_puzzle_input do
      assert 1692 = puzzle_input() |> part_1()
    end
  end

  describe "part_2/1" do
    test "counts larger three sum measurements" do
      assert 5 = @example |> part_2()
    end

    test_with_puzzle_input do
      assert 1724 = puzzle_input() |> part_2()
    end
  end
end
