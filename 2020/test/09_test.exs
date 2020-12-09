defmodule AOC.Day9Test do
  use ExUnit.Case
  doctest AOC.Day9

  test "day 9 - test input" do
    content = "35
    20
    15
    25
    47
    40
    62
    55
    65
    95
    102
    117
    150
    182
    127
    219
    299
    277
    309
    576"
    numbers = content
    |> String.split("\n", trim: true)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)

    preamble = 5
    assert AOC.Day9.find_number(numbers, preamble) == {:found, 127}
    assert AOC.Day9.encryption_weakness(numbers, 127) == 62
  end

  test "day 9 - real input" do
    {:ok, content} = File.read("resources/09.txt")
    numbers = content
    |> String.split("\n", trim: true)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
    preamble = 25
    assert AOC.Day9.find_number(numbers, preamble) == {:found, 1504371145}
    assert AOC.Day9.encryption_weakness(numbers, 1504371145) == 183278487
  end
end
