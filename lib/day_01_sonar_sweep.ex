defmodule Adventofcode.Day01SonarSweep do
  use Adventofcode

  alias __MODULE__.{Parser, Part1, Part2}

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

  defmodule Part1 do
    def solve(lines) do
      lines
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.count(fn [a, b] -> a < b end)
    end
  end

  defmodule Part2 do
    def solve(lines) do
      lines
      |> Enum.chunk_every(3, 1, :discard)
      |> Enum.map(&Enum.sum/1)
      |> Part1.solve()
    end
  end

  defmodule Parser do
    def parse(input) do
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.to_integer/1)
    end
  end
end
