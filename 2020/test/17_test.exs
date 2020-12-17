defmodule AOC.Day17Test do
  use ExUnit.Case
  doctest AOC.Day17

  test "day 17 - real input" do
    {:ok, content} = File.read("resources/17.txt")

    state_3d = content
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, y}, map ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.reduce(map, fn {char, x}, acc ->
        Map.put(acc, {x, y, 0}, char)
      end)
    end)

    state_4d = for {{x, y, z}, cube_state} <- state_3d, into: %{}, do: {{x, y, z, 0}, cube_state}

    assert AOC.Day17.part_1(state_3d) == 265
    assert AOC.Day17.part_2(state_4d) == 1936
  end

end
