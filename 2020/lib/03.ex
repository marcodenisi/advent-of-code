defmodule AOC.Day3 do

  def count_trees(lines, right_move, down_move) do
    replica = replica_factor(lines, right_move, down_move)
    lines
    |> Enum.map(fn line -> String.duplicate(line, replica) end)
    |> Enum.zip(Stream.iterate(0, & &1 + 1))
    |> Enum.filter(fn {_, pos} -> rem(pos, down_move) == 0 end)
    |> Enum.count(fn {line, pos} -> String.at(line, trunc(pos/down_move) * right_move) == "#" end)
  end

  defp replica_factor(lines, right_move, down_move) do
    final_pos = (length(lines) - 1) * right_move / down_move
    line_len = lines |> Enum.at(0) |> String.length
    trunc(Float.ceil(final_pos / line_len))
  end

end
