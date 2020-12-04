defmodule AOC.Day1 do

  def count(list) do
    do_count([Enum.at(list, length(list) - 1) | list], 0, 0)
  end

  defp do_count([], current_acc, acc), do: acc + current_acc
  defp do_count([hd | tl], current_acc, acc) do
    if hd == Enum.at(tl, 0), do: do_count(tl, current_acc + hd, acc), else: do_count(tl, 0, acc + current_acc)
  end

  def count_2(list) do
    {first_half, second_half} = list
    |> Enum.split(trunc(length(list) / 2))

    Enum.zip(first_half, second_half)
    |> Enum.reduce(0, fn el, acc -> do_count_2(el, acc) end)

  end

  defp do_count_2({first, second}, acc) when first == second, do: acc + first * 2
  defp do_count_2({_, _}, acc), do: acc

end
