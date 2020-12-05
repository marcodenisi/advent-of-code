defmodule AOC.Day2Test do
  use ExUnit.Case
  doctest AOC.Day2

  test "Day 2 - real input" do
    {:ok, content} = File.read("resources/02.txt")

    lines = content
    |> String.split("\n", trim: true)
    |> Enum.map(fn line -> String.split(line, "\t", trim: true) end)
    |> Enum.map(fn line -> Enum.map(line, &String.to_integer/1) end)

    assert AOC.Day2.checksum(lines) == 44216
    assert AOC.Day2.checksum_evenly_divisible(lines) == 320
  end
end
