defmodule Adventofcode.Day06Lanternfish do
  use Adventofcode

  alias __MODULE__.{Parser, Part1, State}

  def part_1(input) do
    input
    |> Parser.parse()
    |> State.new()
    |> Part1.solve()
    |> State.total()
  end

  defmodule State do
    @enforce_keys []
    defstruct days: 0, fishes: [], total: 0

    def new(fishes), do: %__MODULE__{fishes: fishes, total: length(fishes)}

    def total(%State{total: total}), do: total
  end

  defmodule Part1 do
    def solve(state, cycles \\ 80)
    def solve(%State{days: cycles} = state, cycles), do: state

    def solve(state, cycles) do
      fishes = cycle(state.fishes)

      %{state | days: state.days + 1, fishes: fishes, total: length(fishes)}
      |> solve(cycles)
    end

    defp cycle(fishes) when is_list(fishes) do
      Enum.flat_map(fishes, &cycle/1)
    end

    defp cycle(0), do: [6, 8]
    defp cycle(n), do: [n - 1]
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
