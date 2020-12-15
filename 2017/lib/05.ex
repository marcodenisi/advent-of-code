defmodule AOC.Day5 do

  def part_1(instructions) do
    instructions
    |> move(0, 0, fn el -> el + 1 end)
  end

  defp move(set, current_idx, count, _) when current_idx >= map_size(set), do: count
  defp move(set, current_idx, count, change_fun) do
    steps = Map.get(set, current_idx)
    move(
      Map.put(set, current_idx, change_fun.(steps)),
      current_idx + steps,
      count + 1,
      change_fun
    )
  end

  def part_2(instructions) do
    instructions
    |> move(0, 0, fn
      el when el >= 3 -> el - 1
      el -> el + 1
    end)
  end

end
