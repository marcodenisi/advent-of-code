defmodule AOC.Day23 do

  def part_1(cups, moves) do
    play(cups, 0, moves)
    |> Enum.join
  end

  defp play(cups, turn, moves) when turn == moves do
    idx = Enum.find_index(cups, fn el -> el == 1 end)
    Enum.concat(cups, cups)
    |> Enum.drop(idx + 1)
    |> Enum.take(length(cups) - 1)
  end

  defp play([current, f, s, t | rest], turn, moves) do
    dest_idx = find_destination(current, rest, Enum.min_max(rest))
    cups = Enum.take(rest, dest_idx + 1) ++ [f, s, t] ++ Enum.drop(rest, dest_idx + 1) ++ [current]
    play(cups, turn + 1, moves)
  end

  defp find_destination(current, cups, {min, max}) do
    current = if current < min, do: max + 1, else: current

    if current - 1 in cups do
      Enum.find_index(cups, fn el -> el == current - 1 end)
    else
      find_destination(current - 1, cups, {min, max})
    end
  end

end
