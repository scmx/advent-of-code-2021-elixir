defmodule Adventofcode.Day06Lanternfish do
  use Adventofcode

  alias __MODULE__.{Parser, State}

  def part_1(input) do
    input
    |> Parser.parse()
    |> State.new()
    |> State.solve(80)
  end

  def part_2(input) do
    input
    |> Parser.parse()
    |> State.new()
    |> State.solve(256)
  end

  defmodule State do
    @enforce_keys []
    defstruct days: 0, total: 0, fishes: %{}

    def new(fishes), do: %__MODULE__{fishes: fishes} |> update_total

    def solve(state, cycles \\ 256)
    def solve(%State{days: cycles} = state, cycles), do: state.total

    def solve(state, cycles) do
      fishes = cycle(state.fishes)

      %{state | days: state.days + 1, fishes: fishes}
      |> update_total
      |> solve(cycles)
    end

    defp cycle(fishes) do
      {pregnancies, rest} = Map.pop(fishes, 0, 0)

      rest
      |> Enum.map(fn {timer, count} -> {timer - 1, count} end)
      |> Map.new()
      |> Map.update(6, pregnancies, &(&1 + pregnancies))
      |> Map.update(8, pregnancies, &(&1 + pregnancies))
    end

    defp update_total(%State{} = state) do
      %{state | total: state.fishes |> Map.values() |> Enum.sum()}
    end
  end

  defmodule Parser do
    def parse(input) do
      input
      |> String.trim()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> Enum.frequencies()
    end
  end
end
