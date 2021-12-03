defmodule Adventofcode.Day03BinaryDiagnostic do
  use Adventofcode

  alias __MODULE__.{MinMax, Parser, Part1, Part2}

  def part_1(input) do
    input
    |> Parser.parse_part_1()
    |> Part1.solve()
  end

  def part_2(input) do
    input
    |> Parser.parse_part_2()
    |> Part2.solve()
  end

  defmodule Part1 do
    def solve(list) do
      rating(list, :min) * rating(list, :max)
    end

    def rating(list, type) do
      list
      |> Enum.map(&do_rating(&1, type))
      |> Enum.join()
      |> String.to_integer(2)
    end

    defp do_rating(binary, type) do
      binary
      |> String.graphemes()
      |> Enum.frequencies()
      |> MinMax.get(type, &elem(&1, 1))
      |> elem(0)
    end
  end

  defmodule Part2 do
    def solve(list), do: rating(list, :min) * rating(list, :max)

    defp rating(list, _type, index \\ 0)
    defp rating([result], _type, _index), do: String.to_integer(result, 2)

    defp rating(list, type, index) do
      list
      |> Enum.group_by(&String.at(&1, index))
      |> MinMax.get(type, &length(elem(&1, 1)))
      |> elem(1)
      |> rating(type, index + 1)
    end
  end

  defmodule MinMax do
    def get(groups, :max, fun), do: Enum.max_by(groups, fun, &>/2)
    def get(groups, :min, fun), do: Enum.min_by(groups, fun)
  end

  defmodule Parser do
    def parse_part_2(input) do
      input
      |> String.trim()
      |> String.split("\n")
    end

    def parse_part_1(input) do
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&parse_line/1)
      |> List.zip()
      |> Enum.map(&Enum.join(Tuple.to_list(&1)))
    end

    defp parse_line(line) do
      line
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)
    end
  end
end
