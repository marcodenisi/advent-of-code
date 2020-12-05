defmodule AOC.Day2 do

  def checksum(lines) do
    lines
    |> Enum.map(&line_min_max/1)
    |> Enum.sum
  end

  defp line_min_max(line), do: (line |> Enum.max()) - (line |> Enum.min())

  def checksum_evenly_divisible(lines) do
    lines
    |> Enum.map(&line_evenly_divisible/1)
    |> Enum.sum
  end

  defp line_evenly_divisible(line) do
    [hd] = for x <- line, y <- line, x != y and rem(x, y) == 0, do: trunc(x/y)
    hd
  end

end
