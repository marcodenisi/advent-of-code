defmodule AOC.Day13 do

  def earliest([departure, buses]) do
    {bus, time} = buses
    |> Enum.map(fn bus ->
      {bus, trunc(departure / bus) * bus + bus}
    end)
    |> Enum.min_by(fn {_, time} -> time end)
    bus * (time - departure)
  end

  def earliest_part_2([hd | _] = buses, start) do
    case count(buses, start, start) do
      :error -> earliest_part_2(buses, start + String.to_integer(hd))
      n -> n
    end
  end

  defp count([], start, _), do: start
  defp count(["x" | buses], start, target), do: count(buses, start, target + 1)
  defp count([current_bus | buses], start, target) do
    current_bus = String.to_integer(current_bus)
    if rem(target, current_bus) == 0 do
      count(buses, start, target + 1)
    else
      :error
    end
  end

end
