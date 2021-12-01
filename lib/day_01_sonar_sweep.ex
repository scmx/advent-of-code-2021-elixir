defmodule Adventofcode.Day01SonarSweep do
  use Adventofcode

  alias __MODULE__.{Parser, Part1}

  def part_1(input) do
    input
    |> Parser.parse()
    |> Part1.solve()
  end

  defmodule Part1 do
    def solve(lines) do
      lines
      |> Enum.chunk_every(2, 1)
      |> Enum.filter(fn
        [a, b] -> a < b
        [_] -> false
      end)
      |> Enum.count()
    end
  end

  defmodule Parser do
    def parse(input) do
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&parse_line/1)
    end

    defp parse_line(line) do
      String.to_integer(line)
    end
  end
end
