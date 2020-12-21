defmodule AOC.Day20Test do
  use ExUnit.Case
  doctest AOC.Day20

  test "day 20 - test inpunt" do
    {:ok, content} = File.read("resources/20_test.txt")

    tiles = parse(content)
    assert AOC.Day20.part_1(tiles) == 20899048083289
    assert AOC.Day20.part_2(tiles) == 7901522557967
  end

  test "day 20" do
    {:ok, content} = File.read("resources/20.txt")

    tiles = parse(content)
    assert AOC.Day20.part_1(tiles) == 7901522557967
  end

  defp parse(content) do
    tiles = String.split(content, "\n\n", trim: true)
    |> Enum.map(&String.split(&1, "\n", trim: true))
    |> Enum.map(fn [header | rows] ->
       header = String.replace(header, "Tile ", "") |> String.replace(":", "")
       {header, rows}
    end)
  end

end
