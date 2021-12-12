defmodule Adventofcode.Day12PassagePathing do
  use Adventofcode

  alias __MODULE__.{CaveSystem, Parser}

  def part_1(input) do
    input
    |> Parser.parse()
    |> CaveSystem.new(:part_1)
    |> CaveSystem.explore()
  end

  def part_2(input) do
    input
    |> Parser.parse()
    |> CaveSystem.new(:part_2)
    |> CaveSystem.explore()
  end

  defmodule CaveSystem do
    @enforce_keys [:all_paths]
    defstruct path_taken: ["start"],
              small_caves_visited: %{},
              all_paths: [],
              part: :part_1

    def new(paths, part) do
      %__MODULE__{all_paths: paths, part: part}
    end

    def explore(graph) do
      graph
      |> do_explore
      |> Enum.map(&(&1.path_taken |> Enum.reverse() |> Enum.join(",")))
      |> Enum.sort()
      |> length
    end

    def do_explore(%__MODULE__{path_taken: ["end" | _]} = state), do: [state]

    def do_explore(%__MODULE__{path_taken: [from | _]} = state) do
      state.all_paths
      |> Enum.filter(fn
        [^from, to] ->
          max_visits = state.small_caves_visited |> Map.values() |> Enum.max(fn -> 0 end)
          allowed = if(max_visits < 2 and state.part == :part_2, do: 2, else: 1)
          Map.get(state.small_caves_visited, to, 0) < allowed

        _ ->
          false
      end)
      |> Enum.map(fn [_from, to] ->
        visited =
          if to in ["end", String.upcase(to)],
            do: state.small_caves_visited,
            else: Map.update(state.small_caves_visited, to, 1, &(&1 + 1))

        %{state | path_taken: [to | state.path_taken], small_caves_visited: visited}
      end)
      |> Enum.flat_map(&do_explore/1)
    end
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
