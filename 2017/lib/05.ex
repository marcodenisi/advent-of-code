defmodule AOC.Day5 do

  def part_1(instructions) do
    instructions
    |> move(0, 0)
  end

  defp move(set, current_idx, count) when current_idx >= length(set), do: count
  defp move(set, current_idx, count) do
    steps = Enum.at(set, current_idx)
    move(
      List.update_at(set, current_idx, fn el -> el + 1 end),
      current_idx + steps,
      count + 1
    )
  end

end
