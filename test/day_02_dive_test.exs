defmodule Adventofcode.Day02DiveTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day02Dive

  alias Adventofcode.Day02Dive.{Parser}

  @example """
  forward 5
  down 5
  forward 8
  up 3
  down 8
  forward 2
  """

  describe "part_1/1" do
    test "multiplying horiz pos and depth" do
      assert 150 = @example |> part_1()
    end

    test_with_puzzle_input do
      assert 1_855_814 = puzzle_input() |> part_1()
    end
  end

  describe "Parser.parse/1" do
    test "parses input" do
      assert [{:forward, 5}, {:down, 5}, {:forward, 8}, {:up, 3}, {:down, 8}, {:forward, 2}] = @example |> Parser.parse()
    end
  end
end
