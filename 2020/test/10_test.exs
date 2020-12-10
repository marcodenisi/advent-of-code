defmodule AOC.Day10Test do
  use ExUnit.Case
  doctest AOC.Day10

  test "day 10 - test input" do
    content = "28
    33
    18
    42
    31
    14
    46
    20
    48
    47
    24
    23
    49
    45
    19
    38
    39
    11
    1
    32
    25
    35
    8
    17
    7
    9
    4
    2
    34
    10
    3"

    adapters = parse(content)

    assert AOC.Day10.differences(adapters) == %{:one => 22, :three => 10}
    assert AOC.Day10.arrangements(adapters) == 19208 * 2
  end

  test "day 10 - real input" do
    {:ok, content} = File.read("resources/10.txt")
    adapters = parse(content)

    assert AOC.Day10.differences(adapters) == %{:one => 74, :three => 27}
    assert AOC.Day10.arrangements(adapters) == 347250213298688 * 2
  end

  defp parse(content) do
    content
    |> String.split("\n", trim: true)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
  end

end
