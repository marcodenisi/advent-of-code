defmodule AOC.Day11 do

  def occupied(seats) do
    new_state = do_calculate(seats)
    if are_equal?(seats, new_state) do
      count_occupied(new_state)
    else
      occupied(new_state)
    end
  end

  defp do_calculate(old_state) do
    for row <- 0..length(old_state) - 1 do
      r = Enum.at(old_state, row)
      for col <- 0..length(r) - 1 do
        seat = Enum.at(r, col)
        case seat do
          "L" -> if adjacent(old_state, row, col, fn seat -> seat != "#" end) == 8, do: "#", else: "L"
          "#" -> if adjacent(old_state, row, col, fn seat -> seat == "#" end) >= 4, do: "L", else: "#"
          _ -> seat
        end
      end
    end
  end

  defp adjacent(state, row_index, col_index, fun) do
    above =
      if row_index == 0 do
        ["L", "L", "L"]
      else
        row = Enum.at(state, row_index - 1)
        if col_index == 0 do
          ["L", Enum.at(row, col_index), Enum.at(row, col_index + 1)]
        else
          if col_index == length(row) do
            ["L", Enum.at(row, col_index), Enum.at(row, col_index - 1)]
          else
            [Enum.at(row, col_index + 1), Enum.at(row, col_index), Enum.at(row, col_index - 1)]
          end
        end
      end |> Enum.count(fun)


    row = Enum.at(state, row_index)
    current =
      if col_index == 0 do
        ["L", Enum.at(row, col_index + 1)]
      else
        if col_index == length(row) do
          ["L", Enum.at(row, col_index - 1)]
        else
          [Enum.at(row, col_index + 1), Enum.at(row, col_index - 1)]
        end
      end |> Enum.count(fun)

    below =
      if row_index == length(state) - 1 do
        ["L", "L", "L"]
      else
        row = Enum.at(state, row_index + 1)
        if col_index == 0 do
          ["L", Enum.at(row, col_index), Enum.at(row, col_index + 1)]
        else
          if col_index == length(row) do
            ["L", Enum.at(row, col_index), Enum.at(row, col_index - 1)]
          else
            [Enum.at(row, col_index + 1), Enum.at(row, col_index), Enum.at(row, col_index - 1)]
          end
        end
      end |> Enum.count(fun)

    above + current + below
  end

  defp are_equal?(old_state, new_state) do
    rows = length(old_state)
    cols = length(Enum.at(old_state, 0))
    try do
      for row_idx <- 0..rows - 1 do
        old_row = Enum.at(old_state, row_idx)
        new_row = Enum.at(new_state, row_idx)
        for col_idx <- 0..cols - 1 do
          if Enum.at(old_row, col_idx) == Enum.at(new_row, col_idx), do: true, else: throw(:break)
        end |> Enum.all?(fn el -> el end)
      end |> Enum.all?(fn el -> el end)
    catch
      :break -> false
    end
  end

  defp count_occupied(state) do
    rows = length(state)
    cols = length(Enum.at(state, 0))
    for row_idx <- 0..rows - 1 do
      row = Enum.at(state, row_idx)
      for col_idx <- 0..cols - 1 do
        Enum.at(row, col_idx) == "#"
      end |> Enum.count(fn el -> el end)
    end |> Enum.sum
  end

end
