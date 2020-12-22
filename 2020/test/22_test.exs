defmodule AOC.Day22Test do
  use ExUnit.Case
  doctest AOC.Day22

  test "day 22 - test input" do
    {:ok, content} = File.read("resources/22_test.txt")
    decks = parse(content)
    assert AOC.Day22.part_1(decks) == 306
    assert AOC.Day22.part_2(decks) == 291
  end

  test "day 22" do
    {:ok, content} = File.read("resources/22.txt")
    decks = parse(content)
    assert AOC.Day22.part_1(decks) == 35005
    assert AOC.Day22.part_2(decks) == 32751
  end

  defp parse(content) do
    content
    |> String.split("\n\n", trim: true)
    |> Enum.map(&String.split(&1, "\n", trim: true))
    |> Enum.map(&Enum.drop(&1, 1))
    |> Enum.map(fn rows -> Enum.map(rows, &String.to_integer/1) end)
  end

end
