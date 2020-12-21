defmodule AOC.Day20 do

  def part_1(tiles) do
    tiles = tiles
    |> Enum.map(&to_edges/1)

    tiles
    |> Enum.reduce(%{}, &find_matches(&1, &2, tiles))
    |> Enum.filter(fn {_, adjecents} -> adjecents == 2 end)
    |> Enum.reduce(1, fn {idx, _}, acc -> acc * String.to_integer(idx) end)
  end

  defp to_edges({id, rows}) do
    edges = [
      Enum.at(rows, 0),
      Enum.at(rows, length(rows) - 1),
      Enum.reduce(rows, "", fn row, acc ->
        acc <> String.at(row, 0)
      end),
      Enum.reduce(rows, "", fn row, acc ->
        acc <> String.at(row, String.length(row) - 1)
      end)
    ]

    {id, edges}
  end

  defp find_matches({id, edges}, acc, tiles) do
    tiles = tiles |> Enum.reject(fn {tile_id, _} -> tile_id == id end)

    adjacents = edges
    |> Enum.map(fn edge ->
      reversed_edge = String.reverse(edge)
      tiles
      |> Enum.filter(fn {_, rows} ->
        adjecents = Enum.filter(rows, fn row ->
          row in [edge, reversed_edge]
        end) |> Enum.count
        adjecents == 1
      end)
      |> Enum.count
    end)
    |> Enum.sum()

    Map.put(acc, id, adjacents)
  end

end
