defmodule Adventofcode.Day02Dive do
  use Adventofcode

  alias __MODULE__.{Parser, Part1, State}

  def part_1(input) do
    input
    |> Parser.parse()
    |> State.new()
    |> Part1.solve()
    |> State.sum()
  end

  defmodule State do
    @enforce_keys []
    defstruct pos: {0, 0}, commands: []

    def new(commands), do: %__MODULE__{commands: commands}

    def sum(%{pos: {x, y}}), do: x * y
  end

  defmodule Part1 do
    def solve(%{commands: []} = state), do: state

    def solve(%{pos: {x, y}, commands: [{command, num} | commands]} = state) do
      solve(%{state | pos: move({command, num}, {x, y}), commands: commands})
    end

    defp move({:forward, num}, {x, y}), do: {x + num, y}
    defp move({:down, num}, {x, y}), do: {x, y + num}
    defp move({:up, num}, {x, y}), do: {x, y - num}
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
