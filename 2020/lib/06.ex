defmodule AOC.Day6 do

  def yes_answers(groups) do
    groups
    |> Enum.map(&yes_answers_in_group/1)
    |> Enum.sum
  end

  defp yes_answers_in_group(group) do
    group
    |> Enum.sort
    |> Enum.dedup
    |> Enum.count
  end

  def everyone_yes_answers(groups) do
    groups
    |> Enum.map(&everyone_yes_answers_in_group/1)
    |> Enum.sum
  end

  defp everyone_yes_answers_in_group(group) do
    len = length(group)
    group
    |> Enum.flat_map(fn answers -> String.split(answers, "", trim: true) end)
    |> Enum.frequencies
    |> Enum.filter(fn {_k, v} -> v == len end)
    |> Enum.count
  end

end
