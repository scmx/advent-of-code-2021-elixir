defmodule Adventofcode.Day05HydrothermalVenture do
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
    def solve(areas) do
      areas
      |> Enum.reject(fn
        [[x, x], [_, _]] -> false
        [[_, _], [y, y]] -> false
        [[_, _], [_, _]] -> true
      end)
      |> Enum.map(fn [[x1, x2], [y1, y2]] -> {x1..x2, y1..y2} end)
      |> Enum.flat_map(fn {xr, yr} -> for(x <- xr, y <- yr, do: {x, y}) end)
      |> Enum.frequencies()
      |> Enum.filter(&(elem(&1, 1) >= 2))
      |> Enum.count()
    end
  end

  defmodule Part2 do
    def solve(areas) do
      areas
      |> Enum.flat_map(fn
        [[x, x], [y1, y2]] -> for(y <- y1..y2, do: {x, y})
        [[x1, x2], [y, y]] -> for(x <- x1..x2, do: {x, y})
        [[x1, x2], [y1, y2]] -> [x1..x2, y1..y2] |> Enum.map(&Enum.to_list/1) |> Enum.zip()
      end)
      |> Enum.frequencies()
      |> Enum.filter(&(elem(&1, 1) >= 2))
      |> Enum.count()
    end
  end

  defmodule Parser do
    def parse(input) do
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&parse_line/1)
      |> Enum.sort()
    end

    defp parse_line(line) do
      ~r/-?\d+/
      |> Regex.scan(line)
      |> List.flatten()
      |> Enum.map(&String.to_integer/1)
      |> (fn [x1, y1, x2, y2] -> [[x1, x2], [y1, y2]] end).()
    end
  end
end
