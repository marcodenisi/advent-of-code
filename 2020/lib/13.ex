defmodule AOC.Day13 do

  def earliest([departure, buses]) do
    {bus, time} = buses
    |> Enum.map(fn bus ->
      {bus, trunc(departure / bus) * bus + bus}
    end)
    |> Enum.min_by(fn {_, time} -> time end)
    bus * (time - departure)
  end

  def find_first_time(buses) do
    bigN = buses
    |> Enum.map(&(elem(&1, 0)))
    |> Enum.reduce(1, &Kernel.*/2)

    x = buses
    |> Enum.map(fn {n, a} ->
      ni = Integer.floor_div(bigN, n)
      xi = find_xi(ni, n, 1)
      ni * xi * a
    end)
    |> Enum.sum()
    |> Kernel.rem(bigN)

    bigN - x
  end

  def find_xi(ni, n, x) do
    case rem(x * ni, n) do
      1 -> x
      _ -> find_xi(ni, n, x + 1)
    end
  end

end
