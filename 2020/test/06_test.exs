defmodule AOC.Day6Test do
  use ExUnit.Case
  doctest AOC.Day6

  test "day 6 - test input" do
    content = "abc

    a
    b
    c

    ab
    ac

    a
    a
    a
    a

    b"

    groups = String.split(content, "\n\n", trim: true)

    assert AOC.Day6.yes_answers(groups |> Enum.map(&group/1)) == 11
    assert AOC.Day6.everyone_yes_answers(groups |> Enum.map(&group_2/1)) == 6
  end

  test "day 6 - real input" do
    {:ok, content} = File.read("resources/06.txt")

    groups = String.split(content, "\n\n", trim: true)

    assert AOC.Day6.yes_answers(groups |> Enum.map(&group/1)) == 6273
    assert AOC.Day6.everyone_yes_answers(groups |> Enum.map(&group_2/1)) == 3254
  end

  defp group(group) do
    String.split(group, "\n", trim: true) |> Enum.map(&String.trim/1) |> Enum.flat_map(fn el -> String.split(el, "", trim: true) end)
  end

  defp group_2(group) do
    String.split(group, "\n", trim: true) |> Enum.map(&String.trim/1)
  end

end
