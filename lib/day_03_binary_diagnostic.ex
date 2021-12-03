defmodule Adventofcode.Day03BinaryDiagnostic do
  use Adventofcode

  alias __MODULE__.{Binary, Parser, Part1, Part2}

  def part_1(input) do
    input
    |> Parser.parse_part_1()
    |> Part1.solve()
  end

  def part_2(input) do
    input
    |> Parser.parse_part_2()
    |> Part2.solve()
  end

  defmodule Part1 do
    def solve(list) do
      gamma_rate(list) * epsilon_rate(list)
    end

    def gamma_rate(list) do
      list
      |> List.zip()
      |> Enum.map(&Enum.join(Tuple.to_list(&1)))
      |> Enum.map(&Binary.most_common_bit_value/1)
      |> Enum.join()
      |> String.to_integer(2)
    end

    defp epsilon_rate(list) do
      list
      |> List.zip()
      |> Enum.map(&Enum.join(Tuple.to_list(&1)))
      |> Enum.map(&Binary.least_common_bit_value/1)
      |> Enum.join()
      |> String.to_integer(2)
    end
  end

  defmodule Part2 do
    def solve(list) do
      oxygen_generator_rating(list) * co2_scrubber_rating(list)
    end

    def oxygen_generator_rating(list, index \\ 0)

    def oxygen_generator_rating([result], _index) do
      String.to_integer(result, 2)
    end

    def oxygen_generator_rating(list, index) do
      most_common = Binary.most_common_bit_value(Enum.map_join(list, &String.at(&1, index)))

      list
      |> Enum.filter(&(String.to_integer(String.at(&1, index)) == most_common))
      |> oxygen_generator_rating(index + 1)
    end

    def co2_scrubber_rating(list, index \\ 0)

    def co2_scrubber_rating([result], _index) do
      String.to_integer(result, 2)
    end

    def co2_scrubber_rating(list, index) do
      least_common = Binary.least_common_bit_value(Enum.map_join(list, &String.at(&1, index)))

      list
      |> Enum.filter(&(String.to_integer(String.at(&1, index)) == least_common))
      |> co2_scrubber_rating(index + 1)
    end
  end

  defmodule Binary do
    def most_common_bit_value(binary) do
      if String.length(String.replace(binary, "0", "")) * 2 < String.length(binary) do
        0
      else
        1
      end
    end

    def least_common_bit_value(binary) do
      if String.length(String.replace(binary, "0", "")) * 2 < String.length(binary) do
        1
      else
        0
      end
    end
  end

  defmodule Parser do
    def parse_part_2(input) do
      input
      |> String.trim()
      |> String.split("\n")
    end

    def parse_part_1(input) do
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
