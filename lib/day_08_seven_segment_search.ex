defmodule Adventofcode.Day08SevenSegmentSearch do
  use Adventofcode

  alias __MODULE__.{Parser, Part1}

  def part_1(input) do
    input
    |> Parser.parse()
    |> Part1.solve()
  end

  defmodule Part1 do
    def solve(values), do: values |> Enum.map(&do_solve/1) |> Enum.sum()

    defp do_solve({_, output_values}) do
      Enum.count(output_values, &(String.length(&1) in [2, 3, 4, 7]))
    end
  end

  defmodule Parser do
    def parse(input) do
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.split(&1, " | "))
      |> Enum.map(&parse_line/1)
    end

    defp parse_line([signal_pattern, output_value]) do
      {String.split(signal_pattern, " "), String.split(output_value, " ")}
    end
  end
end
