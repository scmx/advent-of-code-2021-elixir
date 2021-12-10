defmodule Adventofcode.Day10SyntaxScoring do
  use Adventofcode

  alias __MODULE__.{Autocompleter, Parser, Part1, Part2, SyntaxChecker}

  def part_1(input) do
    input
    |> Parser.parse()
    |> Part1.solve()
  end

  def part_2(input) do
    input
    |> Parser.parse()
    |> Part2.solve()
  end

  defmodule SyntaxChecker do
    def analyze(line) do
      line
      |> Enum.reduce_while({[], 0}, fn
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
      |> (fn {level, score} -> {line, level, score} end).()
    end
  end

  defmodule Part1 do
    def solve(lines) do
      lines
      |> Enum.map(&SyntaxChecker.analyze/1)
      |> Enum.map(fn {_, _, score} -> score end)
      |> Enum.sum()
    end
  end

  defmodule Autocompleter do
    def complete({line, level, _}) do
      completion = Enum.map(level, &do_complete/1)

      {line ++ completion, completion_score(completion)}
    end

    def do_complete(?(), do: ?)
    def do_complete(?[), do: ?]
    def do_complete(?{), do: ?}
    def do_complete(?<), do: ?>

    defp completion_score(completion) do
      completion
      |> Enum.reduce(0, &(&2 * 5 + score(&1)))
    end

    defp score(?)), do: 1
    defp score(?]), do: 2
    defp score(?}), do: 3
    defp score(?>), do: 4
  end

  defmodule Part2 do
    def solve(state) do
      state
      |> Enum.map(&SyntaxChecker.analyze/1)
      |> Enum.reject(fn {_, _, score} -> score > 0 end)
      |> Enum.map(&Autocompleter.complete/1)
      |> Enum.map(&elem(&1, 1))
      |> Enum.sort()
      |> (&Enum.at(&1, div(length(&1), 2))).()
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
