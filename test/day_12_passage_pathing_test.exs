defmodule Adventofcode.Day12PassagePathingTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day12PassagePathing

  alias Adventofcode.Day12PassagePathing.{Parser}

  @example """
  start-b
  start-A
  A-c
  A-b
  b-d
  A-end
  b-end
  """

  @example2 """
  dc-end
  HN-start
  start-kj
  dc-start
  dc-HN
  LN-dc
  HN-end
  kj-sa
  kj-HN
  kj-dc
  """

  @example3 """
  fs-end
  he-DX
  fs-he
  start-DX
  pj-DX
  end-zg
  zg-sl
  zg-pj
  pj-he
  RW-he
  fs-DX
  pj-RW
  zg-RW
  start-pj
  he-WI
  zg-he
  pj-fs
  start-RW
  """

  describe "part_1/1" do
    test "10 paths through" do
      assert 10 = @example |> part_1()
    end

    test "19 paths through" do
      assert 19 = @example2 |> part_1()
    end

    test "226 paths through" do
      assert 226 = @example3 |> part_1()
    end

    test_with_puzzle_input do
      assert 4775 = puzzle_input() |> part_1()
    end
  end

  describe "part_2/1" do
    test "36 paths through" do
      assert 36 = @example |> part_2()
    end

    test "103 paths through" do
      assert 103 = @example2 |> part_2()
    end

    test "3509 paths through" do
      assert 3509 = @example3 |> part_2()
    end

    test_with_puzzle_input do
      assert 152_480 = puzzle_input() |> part_2()
    end
  end

  describe "Parser.parse/1" do
    test "parses input" do
      assert [
               ["start", "b"],
               ["start", "A"],
               ["A", "c"],
               ["c", "A"],
               ["A", "b"],
               ["b", "A"],
               ["b", "d"],
               ["d", "b"],
               ["A", "end"],
               ["b", "end"]
             ] = @example |> Parser.parse()
    end
  end
end
