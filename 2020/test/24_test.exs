defmodule AOC.Day24Test do
  use ExUnit.Case
  doctest AOC.Day24

  test "day 24 - test input" do
    {:ok, input} = File.read("resources/24_test.txt")
    assert AOC.Day24.part_1(parse(input)) == 10
  end

  test "day 24" do
    {:ok, input} = File.read("resources/24.txt")
    assert AOC.Day24.part_1(parse(input)) == 293
  end

  defp parse(input) do
    String.split(input, "\n", trim: true)
  end

end
