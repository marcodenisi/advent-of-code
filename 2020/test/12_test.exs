defmodule AOC.Day12Test do
  use ExUnit.Case
  doctest AOC.Day12

  test "day 12 - test input" do
    content =
      "F10
      N3
      F7
      R90
      F11"
    assert AOC.Day12.manhattan(parse(content)) == 25
    assert AOC.Day12.manhattan_with_waypoint(parse(content)) == 286
  end

  test "day 12 - real input" do
    {:ok, content} = File.read("resources/12.txt")
    assert AOC.Day12.manhattan(parse(content)) == 1148
    assert AOC.Day12.manhattan_with_waypoint(parse(content)) == 52203
  end

  defp parse(content) do
    content
    |> String.split("\n", trim: true)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.split(&1, "", trim: true, parts: 2))
    |> Enum.map(fn [direction, amount] -> [direction, String.to_integer(amount)] end)
  end

end
