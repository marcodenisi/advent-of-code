defmodule AOC.Day15Test do
  use ExUnit.Case
  doctest AOC.Day15

  test "day 15" do
    assert AOC.Day15.count(String.split("0,3,6", ",", trim: true)) == "436"
    assert AOC.Day15.count(String.split("1,3,2", ",", trim: true)) == "1"
    assert AOC.Day15.count(String.split("0,12,6,13,20,1,17", ",", trim: true)) == "620"
  end

end
