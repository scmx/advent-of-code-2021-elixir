defmodule Adventofcode.Day13TransparentOrigamiTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day13TransparentOrigami

  alias Adventofcode.Day13TransparentOrigami.{Parser, State}

  @example """
  6,10
  0,14
  9,10
  0,3
  10,4
  4,11
  6,0
  6,12
  4,1
  0,13
  10,12
  3,4
  3,0
  8,4
  1,10
  2,14
  8,10
  9,0

  fold along y=7
  fold along x=5
  """

  describe "Parser.parse/1" do
    test "parses input" do
      assert %State{
               folds: [y: 7, x: 5],
               grid: [
                 {6, 10},
                 {0, 14},
                 {9, 10},
                 {0, 3},
                 {10, 4},
                 {4, 11},
                 {6, 0},
                 {6, 12},
                 {4, 1},
                 {0, 13},
                 {10, 12},
                 {3, 4},
                 {3, 0},
                 {8, 4},
                 {1, 10},
                 {2, 14},
                 {8, 10},
                 {9, 0}
               ]
             } = @example |> Parser.parse()
    end
  end

  # @example2"""
  # """

  describe "part_1/1" do
    test "17 dots are visible after first fold" do
      assert 17 = @example |> part_1()
    end

    # test "" do
    #   assert 1337 = @example2 |> part_1()
    # end

    test_with_puzzle_input do
      assert 781 = puzzle_input() |> part_1()
    end
  end

  describe "part_2/1" do
    @expected """
              #####
              #   #
              #   #
              #   #
              #####
              """
              |> String.trim()
    test "result after all folds" do
      assert @expected ==
               @example
               |> part_2()
               |> String.split("\n")
               |> Enum.map_join("\n", &String.trim_trailing/1)
    end

    @expected """
              ###  #### ###   ##   ##    ## ###  ###
              #  # #    #  # #  # #  #    # #  # #  #
              #  # ###  #  # #    #       # #  # ###
              ###  #    ###  #    # ##    # ###  #  #
              #    #    # #  #  # #  # #  # #    #  #
              #    #### #  #  ##   ###  ##  #    ###
              """
              |> String.trim()
    test_with_puzzle_input do
      assert @expected ==
               puzzle_input()
               |> part_2()
               |> String.split("\n")
               |> Enum.map_join("\n", &String.trim_trailing/1)
    end
  end
end
