defmodule Adventofcode.Day10SyntaxScoringTest do
  use Adventofcode.FancyCase

  import Adventofcode.Day10SyntaxScoring

  alias Adventofcode.Day10SyntaxScoring.{Parser}

  @example """
  [({(<(())[]>[[{[]{<()<>>
  [(()[<>])]({[<{<<[]>>(
  {([(<{}[<>[]}>{[]{[(<()>
  (((({<>}<{<{<>}{[]{[]{}
  [[<[([]))<([[{}[[()]]]
  [{[{({}]{}}([{[{{{}}([]
  {<[[]]>}<{[{[{[]{()[[[]
  [<(<(<(<{}))><([]([]()
  <{([([[(<>()){}]>(<<{{
  <{([{{}}[<[[[<>{}]]]>[]]
  """

  describe "part_1/1" do
    test "total syntax error score for those errors" do
      assert 26397 = @example |> part_1()
    end

    test_with_puzzle_input do
      assert 344_193 = puzzle_input() |> part_1()
    end
  end

  describe "Parser.parse/1" do
    test "parses input" do
      assert [
               '[({(<(())[]>[[{[]{<()<>>',
               '[(()[<>])]({[<{<<[]>>(',
               '{([(<{}[<>[]}>{[]{[(<()>',
               '(((({<>}<{<{<>}{[]{[]{}',
               '[[<[([]))<([[{}[[()]]]',
               '[{[{({}]{}}([{[{{{}}([]',
               '{<[[]]>}<{[{[{[]{()[[[]',
               '[<(<(<(<{}))><([]([]()',
               '<{([([[(<>()){}]>(<<{{',
               '<{([{{}}[<[[[<>{}]]]>[]]'
             ] = @example |> Parser.parse()
    end
  end
end
