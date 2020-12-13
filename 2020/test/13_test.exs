defmodule AOC.Day13Test do
  use ExUnit.Case
  doctest AOC.Day13

  test "day 13 - test input" do
    content =
      "939
      7,13,x,x,59,x,31,19"
    assert AOC.Day13.earliest(parse(content)) == 295
    assert AOC.Day13.earliest_part_2(parse_bus(content), 0) == 1068781
  end

  test "day 13 - real input" do
    {:ok, content} = File.read("resources/13.txt")
    assert AOC.Day13.earliest(parse(content)) == 4808

    [first | _] = parse_bus(content)
    start = trunc(100000000000000 / String.to_integer(first)) * String.to_integer(first)
    assert AOC.Day13.earliest_part_2(parse_bus(content), start) == 1068781
  end

  defp parse(content) do
    [departure, buses] = content
    |> String.split("\n", trim: true)
    |> Enum.map(&String.trim/1)

    [
      String.to_integer(departure),
      buses
      |> String.split(",", trim: true)
      |> Enum.filter(fn bus -> bus != "x" end)
      |> Enum.map(fn bus -> String.to_integer(bus) end)
    ]
  end

  defp parse_bus(content) do
    [_, buses] = content
    |> String.split("\n", trim: true)
    |> Enum.map(&String.trim/1)

    String.split(buses, ",", trim: true)
  end

end
