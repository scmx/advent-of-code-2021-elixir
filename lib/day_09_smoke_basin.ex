defmodule Adventofcode.Day09SmokeBasin do
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
    def solve(state) do
      state
      |> Enum.filter(&low_point?(&1, state))
      |> Enum.map(fn {_, height} -> height + 1 end)
      |> Enum.sum()
    end

    def low_point?({{x, y}, height}, state) do
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

  defmodule Part2 do
    def solve(state) do
      state
      |> Enum.filter(&Part1.low_point?(&1, state))
      |> Enum.map(&scan_basin([&1], state))
      |> Enum.sort(:desc)
      |> Enum.take(3)
      |> Enum.reduce(1, &(&1 * &2))
    end

    defp scan_basin(basin, state) do
      case basin
           |> Enum.flat_map(&do_scan_basin(&1, state))
           |> Enum.uniq() do
        ^basin -> basin |> Enum.map(&elem(&1, 1)) |> Enum.count()
        basin -> scan_basin(basin, state)
      end
    end

    defp do_scan_basin({{x, y}, height}, state) do
      {x, y}
      |> Part1.neighbours()
      |> Enum.map(&{&1, Map.get(state, &1)})
      |> Enum.filter(&elem(&1, 1))
      |> Enum.filter(fn {_, h} -> h != 9 and h > height end)
      |> Enum.concat([{{x, y}, height}])
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
