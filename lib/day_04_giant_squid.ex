defmodule Adventofcode.Day04GiantSquid do
  use Adventofcode

  alias __MODULE__.{Parser, Part1, Part2, State}

  def part_1(input) do
    input
    |> Parser.parse()
    |> State.new()
    |> Part1.solve()
  end

  def part_2(input) do
    input
    |> Parser.parse()
    |> State.new()
    |> Part2.solve()
  end

  defmodule Board do
    @enforce_keys [:grid]
    defstruct bingo?: false,
              grid: nil,
              marked:
                {nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,
                 nil, nil, nil, nil, nil, nil, nil, nil, nil}

    def new(grid), do: %__MODULE__{grid: grid}

    def mark(board, number) when is_number(number), do: mark(board, [number])

    def mark(%Board{} = board, numbers) when is_list(numbers) do
      Enum.reduce(numbers, board, fn num, acc ->
        acc = %{acc | marked: do_mark(acc, num)}
        %{acc | bingo?: bingo?(acc)}
      end)
    end

    defp do_mark(%Board{grid: grid, marked: marked}, num) do
      Enum.reduce(0..24, marked, fn
        i, acc when elem(grid, i) == num -> put_elem(acc, i, true)
        _, acc -> acc
      end)
    end

    defp bingo?(%Board{marked: marked}) do
      for({xf, yf} <- [{5, 1}, {1, 5}], x <- 0..4, y <- 0..4, do: x * xf + y * yf)
      |> Enum.chunk_every(5)
      |> Enum.any?(fn row -> Enum.all?(row, &elem(marked, &1)) end)
    end
  end

  defmodule State do
    @enforce_keys [:boards, :random_order]
    defstruct boards: [], random_order: []

    def new({random_order, boards}) do
      %__MODULE__{random_order: random_order, boards: Enum.map(boards, &Board.new/1)}
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

  defmodule Part1 do
    def solve(state) do
      state.random_order
      |> Enum.reduce_while(state, &do_solve/2)
      |> print_bingo
    end

    defp do_solve(num, acc) do
      boards = acc.boards |> Enum.map(&Board.mark(&1, [num]))

      if Enum.any?(boards, & &1.bingo?) do
        {:halt, %{acc | boards: boards}}
      else
        {:cont, %{acc | boards: boards, random_order: tl(acc.random_order)}}
      end
    end

    defp print_bingo(state) do
      state.boards
      |> Enum.find(& &1.bingo?)
      |> State.sum_unmarked_numbers(state)
    end
  end

  defmodule Part2 do
    def solve(state) do
      state.random_order
      |> Enum.reduce_while(state, &do_solve/2)
      |> print_bingo
    end

    defp do_solve(num, acc) do
      boards = acc.boards |> Enum.reject(& &1.bingo?) |> Enum.map(&Board.mark(&1, [num]))

      if Enum.all?(boards, & &1.bingo?) do
        {:halt, %{acc | boards: boards}}
      else
        {:cont, %{acc | boards: boards, random_order: tl(acc.random_order)}}
      end
    end

    defp print_bingo(state) do
      state.boards
      |> Enum.find(& &1.bingo?)
      |> State.sum_unmarked_numbers(state)
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
