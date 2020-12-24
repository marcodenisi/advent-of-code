defmodule AOC.Day24 do

  def part_1(paths) do
    paths
    |> Enum.reduce(MapSet.new(), &flip(&1, &2, {0, 0, 0}))
    |> MapSet.size
  end

  defp flip("", acc, key), do: if(key in acc, do: MapSet.delete(acc, key), else: MapSet.put(acc, key))
  defp flip("se" <> rest, acc, {x, y, z}), do: flip(rest, acc, {x, y - 1, z + 1})
  defp flip("sw" <> rest, acc, {x, y, z}), do: flip(rest, acc, {x - 1, y, z + 1})
  defp flip("ne" <> rest, acc, {x, y, z}), do: flip(rest, acc, {x + 1, y, z - 1})
  defp flip("nw" <> rest, acc, {x, y, z}), do: flip(rest, acc, {x, y + 1, z - 1})
  defp flip("e" <> rest, acc, {x, y, z}), do: flip(rest, acc, {x + 1, y - 1, z})
  defp flip("w" <> rest, acc, {x, y, z}), do: flip(rest, acc, {x - 1, y + 1, z})

  def part_2(paths) do
    paths
    |> Enum.reduce(MapSet.new(), &flip(&1, &2, {0, 0, 0}))
    |> days(100)
    |> MapSet.size()
  end

  def days(flipped, 0), do: flipped
  def days(flipped, n), do: flipped |> day() |> days(n - 1)

  def day(flipped) do
    flipped
    |> Enum.flat_map(&adjacent/1)
    |> MapSet.new()
    |> Enum.filter(
      &case {&1 in flipped, flipped(&1, flipped)} do
        {true, n} when n == 0 or n > 2 -> false
        {false, 2} -> true
        {flip?, _} -> flip?
      end
    )
    |> MapSet.new()
  end

  def flipped(key, set), do: key |> adjacent() |> Enum.count(&(&1 in set))

  defp adjacent({x, y, z}) do
    [
      {x + 1, y - 1, z}, # east
      {x, y - 1, z + 1}, # se
      {x - 1, y, z + 1}, # sw
      {x - 1, y + 1, z}, # w
      {x, y + 1, z - 1}, # nw
      {x + 1, y, z - 1}  # ne
    ]
  end

end
