defmodule Adventofcode.Day07TheTreacheryOfWhales do
  use Adventofcode

  alias __MODULE__.{Parser, Part1}

  def part_1(input) do
    input
    |> Parser.parse()
    |> Part1.solve()
  end

  defmodule Part1 do
    def solve(crabs) do
      crabs
      |> Enum.map(&align(&1, crabs))
      |> Enum.min_by(&elem(&1, 1))
      |> elem(1)
    end

    defp align(crab, crabs) do
      {crab, crabs |> Enum.map(&abs(&1 - crab)) |> Enum.sum()}
    end
  end

  defmodule Parser do
    def parse(input) do
      input
      |> String.trim()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
    end
  end
end
