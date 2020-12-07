defmodule AOC.Day3Test do
  use ExUnit.Case
  doctest AOC.Day3

  test "Day 3 - real input" do
    assert AOC.Day3.manhattan(361527) == 326
  end
end
