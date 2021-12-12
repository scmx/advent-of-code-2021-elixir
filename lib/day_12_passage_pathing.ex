defmodule Adventofcode.Day12PassagePathing do
  use Adventofcode

  alias __MODULE__.{Parser, Part1, State}

  def part_1(input) do
    input
    |> Parser.parse()
    |> Part1.new()
    |> Part1.solve()
  end

  defmodule State do
    @enforce_keys []
    defstruct pos: {0, 0}

    def new(_data), do: %__MODULE__{}
  end

  defmodule Part1 do
    @enforce_keys [:all_paths]
    defstruct path_taken: ["start"], small_caves_visited: MapSet.new(), all_paths: []

    def new(paths) do
      %__MODULE__{all_paths: paths}
    end

    def explore(%__MODULE__{path_taken: ["end" | _]} = state), do: [state]

    def explore(%__MODULE__{path_taken: [from | _]} = state) do
      state.all_paths
      |> Enum.filter(fn
        [^from, to] -> to not in state.small_caves_visited
        _ -> false
      end)
      |> Enum.map(fn [_from, to] ->
        visited =
          if to in ["end", String.upcase(to)],
            do: state.small_caves_visited,
            else: MapSet.put(state.small_caves_visited, to)

        %{state | path_taken: [to | state.path_taken], small_caves_visited: visited}
      end)
      |> Enum.flat_map(&explore/1)
    end

    def solve(graph), do: graph |> explore |> length
  end

  defmodule Parser do
    def parse(input) do
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.split(&1, "-"))
      |> Enum.flat_map(&handle_opposite/1)
    end

    defp handle_opposite(["start", to]), do: [["start", to]]
    defp handle_opposite([to, "start"]), do: [["start", to]]
    defp handle_opposite(["end", from]), do: [[from, "end"]]
    defp handle_opposite([from, "end"]), do: [[from, "end"]]
    defp handle_opposite([from, to]), do: [[from, to], [to, from]]
  end
end
