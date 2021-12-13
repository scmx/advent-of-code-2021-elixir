defmodule Adventofcode.Day13TransparentOrigami do
  use Adventofcode

  alias __MODULE__.{Parser, Part1, Part2, Printer, State}

  def part_1(input) do
    input
    |> Parser.parse()
    |> Part1.solve()
  end

  def part_2(input) do
    input
    |> Parser.parse()
    |> Part2.solve()
    |> Printer.to_s()
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
      |> Enum.uniq()
      |> length
    end

    def fold({:y, y_fold}, {x, y}) when y <= y_fold, do: [{x, y}]
    def fold({:x, x_fold}, {x, y}) when x <= x_fold, do: [{x, y}]
    def fold({:y, y_fold}, {x, y}), do: [{x, (y - y_fold) * -1 + y_fold}]
    def fold({:x, x_fold}, {x, y}), do: [{(x - x_fold) * -1 + x_fold, y}]
  end

  defmodule Part2 do
    def solve(%{folds: []} = state), do: state

    def solve(%{folds: [fold | rest]} = state) do
      state.grid
      |> Enum.flat_map(fn {x, y} -> fold(fold, {x, y}) end)
      |> Enum.uniq()
      |> (fn grid -> solve(%{state | folds: rest, grid: grid}) end).()
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

  defmodule Printer do
    def print(%State{} = state) do
      state
      |> to_s
      |> IO.puts()
    end

    def to_s(%State{} = state) do
      x_min = state.grid |> Enum.map(&elem(&1, 0)) |> Enum.min()
      x_max = state.grid |> Enum.map(&elem(&1, 0)) |> Enum.max()
      y_min = state.grid |> Enum.map(&elem(&1, 1)) |> Enum.min()
      y_max = state.grid |> Enum.map(&elem(&1, 1)) |> Enum.max()
      grid = MapSet.new(state.grid)

      Enum.map_join(y_min..y_max, "\n", fn y ->
        Enum.map_join(x_min..x_max, "", fn x ->
          if {x, y} in grid, do: "#", else: " "
        end)
      end)
    end
  end
end
