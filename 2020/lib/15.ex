defmodule AOC.Day15 do

  def count(starting_numbers) do
    turns_played = length(starting_numbers)
    acc = starting_numbers
    |> Enum.with_index(1)
    |> Enum.map(fn {el, idx} -> {el, [idx]} end)
    |> Map.new
    do_count(turns_played, "-1", acc)
  end

  defp do_count(turns_played, last_num, _) when turns_played == 2020, do: last_num
  defp do_count(turns_played, last_num, acc) do
    current_turn = turns_played + 1
    next = case Map.get(acc, last_num) do
      val when val == nil or is_list(val) and length(val) == 1 -> "0"
      [previous, latest] -> Integer.to_string(latest - previous)
    end
    acc = Map.put(
      acc,
      next,
      case Map.get(acc, next) do
        nil -> [current_turn]
        [previous] -> [previous, current_turn]
        [_, latest] -> [latest, current_turn]
      end
    )
    do_count(current_turn, next, acc)
  end

end
