defmodule AOC.Day1Test do
  use ExUnit.Case
  doctest AOC.Day1

  test "day 1 - test input" do
    expenses = [
      1721,
      979,
      366,
      299,
      675,
      1456
    ]

    assert AOC.Day1.fix_expenses_2(expenses, 2020) == 514579
  end

  test "day 1.1 - real input" do
    {:ok, content} = File.read("resources/01.txt")
    expenses = content
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    assert AOC.Day1.fix_expenses_2(expenses, 2020) == 1010884
  end

  test "day 1.2 - real input" do
    {:ok, content} = File.read("resources/01.txt")
    expenses = content
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    assert AOC.Day1.fix_expenses_3(expenses, 2020) == 253928438
  end
end
