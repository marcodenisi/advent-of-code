defmodule AOC.Day5 do

  def highest_seat_id(seats) do
    seats |> Enum.map(&calculate_seat_id/1) |> Enum.max
  end

  def my_seat_id(seats) do
    {seat, _} = seats
    |> Enum.map(&calculate_seat_id/1)
    |> Enum.sort
    |> Enum.map(fn seat -> seat - 12 end)
    |> Enum.with_index
    |> Enum.find(fn {seat, index} -> seat != index end)

    seat + 11
  end

  defp calculate_seat_id(<<row::bytes-size(7), column::bytes-size(3)>>) do
    split_half(row, 0, 128) * 8 + split_half(column, 0, 8)
  end

  defp split_half(<<char::bytes-size(1)>>, from, _) when char in ["F", "L"], do: from
  defp split_half(<<_::bytes-size(1)>>, _, to), do: to - 1
  defp split_half(<<char::bytes-size(1), rest::binary>>, from, to) when char in ["F", "L"], do: split_half(rest, from, from + trunc((to-from)/2))
  defp split_half(<<_::bytes-size(1), rest::binary>>, from, to), do: split_half(rest, from + trunc((to-from)/2), to)
end
