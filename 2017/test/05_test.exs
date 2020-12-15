defmodule AOC.Day4Test do
  use ExUnit.Case
  doctest AOC.Day4

  @tag timeout: :infinity
  test "Day 5 - real input" do
    {:ok, content} = File.read("resources/05.txt")
    assert AOC.Day5.part_1(parse(content)) == 339351
    assert AOC.Day5.part_2(parse(content)) == 24315397
  end

  defp parse(content) do
    content
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index
    |> Enum.map(fn {el, idx} -> {idx, el} end)
    |> Map.new
  end

end
