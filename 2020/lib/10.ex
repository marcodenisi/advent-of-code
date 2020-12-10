defmodule AOC.Day10 do
  use Agent

  def differences(adapters) do
    max = adapters |> Enum.max
    adapters = [0, max + 3] ++ adapters |> Enum.sort
    do_difference(adapters, %{})
  end

  defp do_difference([_], acc), do: acc
  defp do_difference([hd | tl], acc) do
    case Enum.at(tl, 0) - hd do
      1 -> do_difference(tl, Map.put(acc, :one, Map.get(acc, :one, 0) + 1))
      3 -> do_difference(tl, Map.put(acc, :three, Map.get(acc, :three, 0) + 1))
      _ -> do_difference(tl, acc)
    end
  end

  def arrangements(adapters) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)

    max = adapters |> Enum.max
    adapters = [0, max + 3] ++ adapters |> Enum.sort
    arrange(hd(adapters), tl(adapters))
  end

  defp arrange(_, []), do: 1
  defp arrange(current, [hd | tl]) do
    memoized = Agent.get(__MODULE__, &(Map.get(&1, current)))
    if memoized do
      memoized
    else
      if hd - current > 3 do
        0
      else
        count = arrange(hd, tl) + arrange(current, tl)
        Agent.update(__MODULE__, &(Map.put(&1, current, count)))
        count
      end
    end
  end

end
