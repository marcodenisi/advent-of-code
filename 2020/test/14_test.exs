defmodule AOC.Day14Test do
  use ExUnit.Case
  doctest AOC.Day14

  test "day 14 - test input" do
    content =
      "mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
      mem[8] = 11
      mem[7] = 101
      mem[8] = 0"
      assert AOC.Day14.part_1(parse(content)) == 165
  end

  test "day 14 - real input" do
    {:ok, content} = File.read("resources/14.txt")
    assert AOC.Day14.part_1(parse(content)) == 14722016054794
    assert AOC.Day14.part_2("resources/14.txt") == 3618217244644
  end

  defp parse(content) do
    content
    |> String.split("mask = ", trim: true)
    |> Enum.map(&String.split(&1, "\n", trim: true))
    |> Enum.map(fn [mask | instr] ->
      %{
        :mask => mask,
        :instructions => instr |> Enum.map(&parse_instruction/1)
      }
    end)
  end

  defp parse_instruction(instruction) do
    [memory, value] = String.split(instruction, " = ", trim: true)
    memory = ~r/mem\[(.+)\]/
    |> Regex.run(memory)
    |> Enum.at(1)
    %{
      :memory => String.to_integer(memory),
      :value => String.to_integer(value) |> Integer.to_string(2) |> String.pad_leading(36, "0")
    }
  end

end
