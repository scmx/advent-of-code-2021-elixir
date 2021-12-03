defmodule Adventofcode.Day03BinaryDiagnostic do
  use Adventofcode

  alias __MODULE__.{Parser, Part1}

  def part_1(input) do
    input
    |> Parser.parse()
    |> Part1.solve()
  end

  defmodule Part1 do
    def solve(list) do
      gamma_rate(list) * epsilon_rate(list)
    end

    def gamma_rate(list) do
      list
      |> List.zip()
      |> Enum.map(&Enum.join(Tuple.to_list(&1)))
      |> Enum.map(&do_gamma_rate_most_common/1)
      |> Enum.join()
      |> String.to_integer(2)
    end

    defp do_gamma_rate_most_common(binary) do
      if String.length(String.replace(binary, "0", "")) * 2 < String.length(binary) do
        0
      else
        1
      end
    end

    defp epsilon_rate(list) do
      list
      |> List.zip()
      |> Enum.map(&Enum.join(Tuple.to_list(&1)))
      |> Enum.map(&do_epsilon_rate_least_common/1)
      |> Enum.join()
      |> String.to_integer(2)
    end

    defp do_epsilon_rate_least_common(binary) do
      if String.length(String.replace(binary, "0", "")) * 2 < String.length(binary) do
        1
      else
        0
      end
    end
  end

  defmodule Parser do
    def parse(input) do
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&parse_line/1)
    end

    defp parse_line(line) do
      line
      |> String.to_charlist()
      |> Enum.map(&(&1 - ?0))
    end
  end
end
