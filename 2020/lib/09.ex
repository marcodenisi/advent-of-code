defmodule AOC.Day9 do

  def find_number(numbers, preamble_len) do
    for index <- preamble_len..length(numbers) - 1 do
      preamble = Enum.slice(numbers, index - preamble_len, preamble_len)
      current_number = Enum.at(numbers, index)
      find_sum_in_preamble(current_number, preamble)
    end
    |> Enum.find(fn {k, _} -> k == :found end)
  end

  defp find_sum_in_preamble(number, preamble) do
    sums = for x <- preamble, y <- preamble, x != y, do: x + y
    if number not in sums, do: {:found, number}, else: {:ok, number}
  end

  def encryption_weakness(numbers, target) do
    sums = sum(numbers, 0, 0, target)
    Enum.min(sums) + Enum.max(sums)
  end

  defp sum(numbers, start_index, end_index, target) do
    sum = Enum.slice(numbers, start_index, end_index - start_index) |> Enum.sum
    if sum == target do
      Enum.slice(numbers, start_index, end_index - start_index)
    else
      if sum < target do
        sum(numbers, start_index, end_index + 1, target)
      else
        sum(numbers, start_index + 1, end_index, target)
      end
    end
  end

end
