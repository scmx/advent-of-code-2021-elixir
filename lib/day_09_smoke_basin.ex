defmodule Adventofcode.Day09SmokeBasin do
  use Adventofcode

  alias __MODULE__.{Parser, Part1}

  def part_1(input) do
    input
    |> Parser.parse()
    |> Part1.solve()
  end


  defmodule Part1 do
    def solve(state) do
      state
      |> Enum.filter(&low_point?(&1, state))
      |> Enum.map(fn {_, height} -> height + 1 end)
      |> Enum.sum()
    end

    defp low_point?({{x, y}, height}, state) do
      {x, y}
      |> neighbours()
      |> Enum.map(&Map.get(state, &1))
      |> Enum.filter(& &1)
      |> Enum.all?(&(height < &1))
    end

    @neighbours [
      {0, 1},
      {1, 0},
      {0, -1},
      {-1, 0}
    ]
    def neighbours({x, y}) do
      Enum.map(@neighbours, fn {dx, dy} -> {x + dx, y + dy} end)
    end
  end

  defmodule Parser do
    def parse(input) do
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.with_index()
      |> Enum.flat_map(&parse_line/1)
      |> Map.new()
    end

    defp parse_line({row, y}) do
      row
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)
      |> Enum.with_index()
      |> Enum.map(fn {cell, x} -> {{x, y}, cell} end)
    end
  end
end
