defmodule Adventofcode.Day02Dive do
  use Adventofcode

  alias __MODULE__.{Parser, Part1, Part2}

  def part_1(input) do
    input
    |> Parser.parse()
    |> Enum.reduce({0, 0, 0}, &Part1.move/2)
    |> sum
  end

  def part_2(input) do
    input
    |> Parser.parse()
    |> Enum.reduce({0, 0, 0}, &Part2.move/2)
    |> sum
  end

  defp sum({x, y, _}), do: x * y

  defmodule Part1 do
    def move({:forward, num}, {x, y, z}), do: {x + num, y, z}
    def move({:down, num}, {x, y, z}), do: {x, y + num, z}
    def move({:up, num}, {x, y, z}), do: {x, y - num, z}
  end

  defmodule Part2 do
    def move({:forward, num}, {x, y, z}), do: {x + num, y + z * num, z}
    def move({:down, num}, {x, y, z}), do: {x, y, z + num}
    def move({:up, num}, {x, y, z}), do: {x, y, z - num}
  end

  defmodule Parser do
    def parse(input) do
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&parse_line/1)
    end

    defp parse_line(line) do
      [command, num] = String.split(line, " ")
      {String.to_atom(command), String.to_integer(num)}
    end
  end
end
