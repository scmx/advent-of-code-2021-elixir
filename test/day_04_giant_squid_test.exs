defmodule Adventofcode.Day04GiantSquidTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day04GiantSquid

  alias Adventofcode.Day04GiantSquid.{Board, Parser}

  @example """
  7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

  22 13 17 11  0
   8  2 23  4 24
  21  9 14 16  7
   6 10  3 18  5
   1 12 20 15 19

   3 15  0  2 22
   9 18 13 17  5
  19  8  7 25 23
  20 11 10 24  4
  14 21 16 12  6

  14 21 17 24  4
  10 16 15  9 19
  18  8 23 26 20
  22 11 13  6  5
   2  0 12  3  7
  """

  describe "part_1/1" do
    test "board 3 will win and get score" do
      assert 4512 = @example |> part_1()
    end
  end

  @grid1 {22, 13, 17, 11, 0, 8, 2, 23, 4, 24, 21, 9, 14, 16, 7, 6, 10, 3, 18, 5, 1, 12, 20, 15,
          19}

  @grid2 {3, 15, 0, 2, 22, 9, 18, 13, 17, 5, 19, 8, 7, 25, 23, 20, 11, 10, 24, 4, 14, 21, 16, 12,
          6}

  @grid3 {14, 21, 17, 24, 4, 10, 16, 15, 9, 19, 18, 8, 23, 26, 20, 22, 11, 13, 6, 5, 2, 0, 12, 3,
          7}

  describe "Board.bingo?/1" do
    test "detects bingo in first row" do
      import Board
      assert @grid1 |> new() |> mark([22, 13, 17, 11, 0]) |> bingo?()
    end

    test "detects bingo in second row" do
      import Board
      assert @grid1 |> new() |> mark([8, 2, 23, 4, 24]) |> bingo?()
    end

    test "does not detect invalid bingo in second row" do
      import Board
      refute @grid1 |> new() |> mark([8, 2, 4, 24]) |> bingo?()
    end

    test "detects bingo in first column" do
      import Board
      assert @grid1 |> new() |> mark([22, 8, 21, 6, 1]) |> bingo?()
    end

    @tag :skip
    test "detects bingo in diagonal" do
      import Board
      assert @grid1 |> new() |> mark([22, 2, 14, 18, 19]) |> bingo?()
    end

    @tag :skip
    test "detects bingo in other diagonal" do
      import Board
      assert @grid1 |> new() |> mark([0, 4, 14, 10, 1]) |> bingo?()
    end
  end

  describe "Parser.parse/1" do
    test "parses input" do
      random_order = ~i[
        7 4 9 5 11 17 23 2 0 14 21 24 10 16 13 6 15 25 12 22 18 20 8 19 3 26 1]

      assert {^random_order, [@grid1, @grid2, @grid3]} = @example |> Parser.parse()
    end
  end
end
