defmodule AOC.Day5Test do
  use ExUnit.Case
  doctest AOC.Day5

  test "day 5 - test input" do
    content = "FBFBBFFRLR
    BFFFBBFRRR
    FFFBBBFRRR
    BBFFBBFRLL"

    seats = String.split(content, "\n", trim: true)
    |> Enum.map(&String.trim/1)

    assert AOC.Day5.highest_seat_id(seats) == 820
  end

  test "day 5 - real input" do
    {:ok, content} = File.read("resources/05.txt")

    seats = String.split(content, "\n", trim: true)
    |> Enum.map(&String.trim/1)

    assert AOC.Day5.highest_seat_id(seats) == 858
    assert AOC.Day5.my_seat_id(seats) == 557
  end

end
