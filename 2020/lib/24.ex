defmodule AOC.Day24 do

  def part_1(paths) do
    paths
    |> Enum.reduce(%{}, &flip(&1, &2, {0, 0, 0}))
    |> Map.values
    |> Enum.count(fn color -> color == :black end)
  end

  defp flip("", acc, key) do
    Map.put(
      acc,
      key,
      case Map.get(acc, key) do
        :black -> :white
        _ -> :black
      end
    )
  end
  defp flip("se" <> rest, acc, {x, y, z}), do: flip(rest, acc, {x, y - 1, z + 1})
  defp flip("sw" <> rest, acc, {x, y, z}), do: flip(rest, acc, {x - 1, y, z + 1})
  defp flip("ne" <> rest, acc, {x, y, z}), do: flip(rest, acc, {x + 1, y, z - 1})
  defp flip("nw" <> rest, acc, {x, y, z}), do: flip(rest, acc, {x, y + 1, z - 1})
  defp flip("e" <> rest, acc, {x, y, z}), do: flip(rest, acc, {x + 1, y - 1, z})
  defp flip("w" <> rest, acc, {x, y, z}), do: flip(rest, acc, {x - 1, y + 1, z})

end
