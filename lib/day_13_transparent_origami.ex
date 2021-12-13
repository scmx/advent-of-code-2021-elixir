defmodule Adventofcode.Day13TransparentOrigami do
  use Adventofcode

  alias __MODULE__.{Parser, Part1, State}

  def part_1(input) do
    input
    |> Parser.parse()
    |> Part1.solve()
  end

  defmodule State do
    @enforce_keys []
    defstruct grid: [], folds: []

    def new({grid, folds}), do: struct(__MODULE__, grid: grid, folds: folds)
  end

  defmodule Part1 do
    def solve(%{folds: [fold | _rest]} = state) do
      state.grid
      |> Enum.flat_map(fn {x, y} -> fold(fold, {x, y}) end)
      |> Enum.frequencies()
      |> Enum.count()
    end

    def fold({:y, y_fold}, {x, y}) when y <= y_fold, do: [{x, y}]
    def fold({:x, x_fold}, {x, y}) when x <= x_fold, do: [{x, y}]
    def fold({:y, y_fold}, {x, y}), do: [{x, (y - y_fold) * -1 + y_fold}]
    def fold({:x, x_fold}, {x, y}), do: [{(x - x_fold) * -1 + x_fold, y}]
  end

  defmodule Parser do
    def parse(input) do
      input
      |> String.trim()
      |> String.split("\n\n")
      |> (fn [grid, folds] -> {parse_grid(grid), parse_folds(folds)} end).()
      |> State.new()
    end

    defp parse_grid(input) do
      input
      |> String.split("\n")
      |> Enum.map(&parse_grid_line/1)
    end

    defp parse_grid_line(line) do
      line
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()
    end

    defp parse_folds(input) do
      input
      |> String.split("\n")
      |> Enum.map(&parse_fold_line/1)
    end

    defp parse_fold_line("fold along " <> fold) do
      fold
      |> String.split("=")
      |> (fn [dir, pos] -> {String.to_atom(dir), String.to_integer(pos)} end).()
    end
  end
end
