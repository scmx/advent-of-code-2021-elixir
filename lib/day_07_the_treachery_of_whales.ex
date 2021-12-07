defmodule Adventofcode.Day07TheTreacheryOfWhales do
  use Adventofcode

  alias __MODULE__.{Parser, Solver}

  def part_1(input), do: input |> Parser.parse() |> Solver.solve(:part_1)

  def part_2(input), do: input |> Parser.parse() |> Solver.solve(:part_2)

  defmodule Solver do
    def solve(crabs, part) do
      crabs
      |> Enum.map(&do_solve(&1, crabs, part))
      |> Enum.min()
    end

    defp do_solve(pos, crabs, part) do
      crabs
      |> Enum.map(&align(&1, pos, part))
      |> Enum.sum()
    end

    defp align(crab, pos, :part_1), do: abs(crab - pos)

    defp align(crab, pos, :part_2), do: Enum.sum(1..abs(crab - pos - 1))
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
