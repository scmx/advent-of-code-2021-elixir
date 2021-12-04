defmodule Adventofcode.Day04GiantSquid do
  use Adventofcode

  alias __MODULE__.{Parser, Part1, State}

  def part_1(input) do
    input
    |> Parser.parse()
    |> State.new()
    |> Part1.solve()
  end

  defmodule Board do
    @enforce_keys [:grid]
    defstruct grid: nil,
              marked:
                {nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,
                 nil, nil, nil, nil, nil, nil, nil, nil, nil}

    def new(grid), do: %__MODULE__{grid: grid}

    @bingo_cases [
      [0, 1, 2, 3, 4],
      [5, 6, 7, 8, 9],
      [10, 11, 12, 13, 14],
      [15, 16, 17, 18, 19],
      [20, 21, 22, 23, 24],
      [0, 5, 10, 15, 20],
      [1, 6, 11, 16, 21],
      [2, 7, 12, 17, 22],
      [3, 8, 13, 18, 23],
      [4, 9, 14, 19, 24]
    ]

    def bingo?(%Board{marked: marked}) do
      Enum.any?(@bingo_cases, fn row ->
        Enum.all?(row, &elem(marked, &1))
      end)
    end

    def mark(board, number) when is_number(number), do: mark(board, [number])

    def mark(%Board{} = board, numbers) when is_list(numbers) do
      Enum.reduce(numbers, board, fn num, acc ->
        %{acc | marked: do_mark(acc, num)}
      end)
    end

    defp do_mark(%Board{grid: grid, marked: marked}, num) do
      Enum.reduce(0..24, marked, fn
        i, acc when elem(grid, i) == num -> put_elem(acc, i, true)
        _, acc -> acc
      end)
    end
  end

  defmodule State do
    @enforce_keys [:boards, :random_order]
    defstruct boards: [], random_order: []

    def new({random_order, boards}) do
      %__MODULE__{random_order: random_order, boards: Enum.map(boards, &Board.new/1)}
    end
  end

  defmodule Part1 do
    def solve(state) do
      state.random_order
      |> Enum.reduce_while(state, &do_solve/2)
      |> print_bingo
    end

    defp do_solve(num, acc) do
      boards = acc.boards |> Enum.map(&Board.mark(&1, [num]))

      if Enum.any?(boards, &Board.bingo?/1) do
        {:halt, %{acc | boards: boards}}
      else
        {:cont, %{acc | boards: boards, random_order: tl(acc.random_order)}}
      end
    end

    defp print_bingo(state) do
      state.boards
      |> Enum.with_index()
      |> Enum.map(fn {board, index} -> {board, index + 1} end)
      |> Enum.find(&Board.bingo?(elem(&1, 0)))
      |> elem(0)
      |> sum_unmarked_numbers(state)
    end

    def sum_unmarked_numbers(%Board{grid: grid, marked: marked}, %State{} = state) do
      sum =
        0..24
        |> Enum.map(fn
          index when elem(marked, index) == true -> 0
          index -> elem(grid, index)
        end)
        |> Enum.sum()

      sum * hd(state.random_order)
    end
  end

  defmodule Parser do
    def parse(input) do
      input
      |> String.trim()
      |> String.split("\n\n")
      |> do_parse
    end

    defp do_parse([random_order | boards]) do
      {parse_random_order(random_order), parse_boards(boards)}
    end

    defp parse_random_order(line) do
      line
      |> String.trim()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
    end

    defp parse_boards(boards) do
      ~r/-?\d+/
      |> Regex.scan(Enum.join(boards, " "))
      |> List.flatten()
      |> Enum.map(&String.to_integer/1)
      |> Enum.chunk_every(25)
      |> Enum.map(&List.to_tuple/1)
    end
  end
end
