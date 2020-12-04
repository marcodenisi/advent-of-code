defmodule AOC.Day1Test do
  use ExUnit.Case
  doctest AOC.Day1

  test "greets the world" do
    {:ok, content} = File.read("resources/01.txt")

    list = content
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
    assert AOC.Day1.count(list) == 995

    assert AOC.Day1.count_2(list) == 1130
  end
end
