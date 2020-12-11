defmodule AOC.Day11Test do
  use ExUnit.Case
  doctest AOC.Day11

  test "day 11 - test input" do
    content = "L.LL.LL.LL
    LLLLLLL.LL
    L.L.L..L..
    LLLL.LL.LL
    L.LL.LL.LL
    L.LLLLL.LL
    ..L.L.....
    LLLLLLLLLL
    L.LLLLLL.L
    L.LLLLL.LL"

    seats = parse(content)

    assert AOC.Day11.occupied(seats) == 37
    #assert AOC.Day10.arrangements(adapters) == 19208 * 2
  end

  test "day 11 - real input" do
    {:ok, content} = File.read("resources/11.txt")
    seats = parse(content)

    assert AOC.Day11.occupied(seats) == 2489
    #assert AOC.Day10.arrangements(adapters) == 347250213298688 * 2
  end

  defp parse(content) do
    content
    |> String.split("\n", trim: true)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.split(&1, "", trim: true))
  end

end
