defmodule AOC.Day23Test do
  use ExUnit.Case
  doctest AOC.Day23

  @tag timeout: :infinity
  test "day 23" do
    input = String.split("389125467", "", trim: true)
    |> Enum.map(&String.to_integer/1)
    assert AOC.Day23.part_1(input, 10) == "92658374"
    assert AOC.Day23.part_1(input, 100) == "67384529"

    input = String.split("215694783", "", trim: true)
    |> Enum.map(&String.to_integer/1)
    assert AOC.Day23.part_1(input, 100) == "46978532"
  end

end
