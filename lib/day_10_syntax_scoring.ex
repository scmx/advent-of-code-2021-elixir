defmodule Adventofcode.Day10SyntaxScoring do
  use Adventofcode

  alias __MODULE__.{Parser, Part1, Part2}

  def part_1(input) do
    input
    |> Parser.parse()
    |> Part1.solve()
  end

  defmodule Part1 do
    def solve(lines) do
      lines
      |> Enum.map(&analyze/1)
      |> Enum.map(&elem(&1, 1))
      |> Enum.sum()
    end

    defp analyze(line) do
      Enum.reduce_while(line, {[], 0}, fn
        ?(, {level, score} -> {:cont, {[?( | level], score}}
        ?[, {level, score} -> {:cont, {[?[ | level], score}}
        ?{, {level, score} -> {:cont, {[?{ | level], score}}
        ?<, {level, score} -> {:cont, {[?< | level], score}}
        ?), {[?( | level], score} -> {:cont, {level, score}}
        ?], {[?[ | level], score} -> {:cont, {level, score}}
        ?}, {[?{ | level], score} -> {:cont, {level, score}}
        ?>, {[?< | level], score} -> {:cont, {level, score}}
        ?), {level, score} -> {:halt, {level, score + 3}}
        ?], {level, score} -> {:halt, {level, score + 57}}
        ?}, {level, score} -> {:halt, {level, score + 1197}}
        ?>, {level, score} -> {:halt, {level, score + 25137}}
      end)
    end
  end

  defmodule Parser do
    def parse(input) do
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&to_charlist/1)
    end
  end
end
