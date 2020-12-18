defmodule AOC.Day18Test do
  use ExUnit.Case
  doctest AOC.Day18

  test "day 18 - test input" do
    assert AOC.Day18.part_1([parse("1 + 2 * 3 + 4 * 5 + 6")]) == 71
    assert AOC.Day18.part_1([parse("1 + (2 * 3) + (4 * (5 + 6))")]) == 51
    assert AOC.Day18.part_1([parse("2 * 3 + (4 * 5)")]) == 26
    assert AOC.Day18.part_1([parse("5 + (8 * 3 + 9 + 3 * 4 * 3)")]) == 437
    assert AOC.Day18.part_1([parse("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))")]) == 12240
    assert AOC.Day18.part_1([parse("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2")]) == 13632

    assert AOC.Day18.part_2([parse("1 + 2 * 3 + 4 * 5 + 6")]) == 231
    assert AOC.Day18.part_2([parse("1 + (2 * 3) + (4 * (5 + 6))")]) == 51
    assert AOC.Day18.part_2([parse("2 * 3 + (4 * 5)")]) == 46
    assert AOC.Day18.part_2([parse("5 + (8 * 3 + 9 + 3 * 4 * 3)")]) == 1445
    assert AOC.Day18.part_2([parse("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))")]) == 669060
    assert AOC.Day18.part_2([parse("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2")]) == 23340
  end

  test "day 18 - real input" do
    {:ok, content} = File.read("resources/18.txt")
    expressions = content
    |> String.split("\n")
    |> Enum.map(&parse/1)
    assert AOC.Day18.part_1(expressions) == 21347713555555
    assert AOC.Day18.part_2(expressions) == 275011754427339
  end

  defp parse(content) do
    content
    |> String.split("", trim: true)
    |> Enum.filter(fn el -> el != " " end)
  end

end
