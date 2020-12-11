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

  def occupied_2(seats) do
    new_state = do_calculate_2(seats)
    if are_equal?(seats, new_state) do
      count_occupied(new_state)
    else
      occupied_2(new_state)
    end
  end

  defp do_calculate_2(old_state) do
    for row <- 0..length(old_state) - 1 do
      r = Enum.at(old_state, row)
      for col <- 0..length(r) - 1 do
        seat = Enum.at(r, col)
        case seat do
          "L" -> if adjacent_2(old_state, row, col, fn seat -> seat != "#" end) == 8, do: "#", else: "L"
          "#" -> if adjacent_2(old_state, row, col, fn seat -> seat == "#" end) >= 5, do: "L", else: "#"
          _ -> seat
        end
      end
    end
  end

  defp adjacent_2(state, row_index, col_index, fun) do
    current_row = Enum.at(state, row_index)

    down = state
    |> Enum.drop(row_index + 1)
    |> Enum.map(&Enum.at(&1, col_index))
    |> get_next

    up = state
    |> Enum.take(row_index)
    |> Enum.filter(&not_empty?/1)
    |> Enum.reverse
    |> Enum.map(&Enum.at(&1, col_index))
    |> get_next

    right = current_row |> Enum.drop(col_index + 1) |> get_next

    left = current_row |> Enum.take(col_index) |> Enum.reverse |> get_next

    right_down = state
    |> Enum.drop(row_index + 1)
    |> Enum.map(&Enum.drop(&1, col_index + 1))
    |> Enum.filter(&not_empty?/1)
    |> get_next_diagonal

    left_down = state
    |> Enum.drop(row_index + 1)
    |> Enum.map(&Enum.take(&1, col_index))
    |> Enum.filter(&not_empty?/1)
    |> Enum.map(&Enum.reverse/1)
    |> get_next_diagonal

    right_up = state
    |> Enum.take(row_index)
    |> Enum.map(&Enum.drop(&1, col_index + 1))
    |> Enum.reverse
    |> Enum.filter(&not_empty?/1)
    |> get_next_diagonal

    left_up = state
    |> Enum.take(row_index)
    |> Enum.reverse
    |> Enum.map(&Enum.take(&1, col_index))
    |> Enum.map(&Enum.reverse/1)
    |> Enum.filter(&not_empty?/1)
    |> get_next_diagonal

    [
      down,
      up,
      right,
      left,
      right_down,
      right_up,
      left_down,
      left_up
    ] |> Enum.count(fun)

  end

  defp not_empty?([]), do: false
  defp not_empty?(_), do: true

  defp get_next([]), do: "L"
  defp get_next(["." | tl]), do: get_next(tl)
  defp get_next([seat | _]), do: seat

  defp get_next_diagonal([]), do: "L"
  defp get_next_diagonal([["." | _] | rest]), do: rest |> Enum.map(&Enum.drop(&1, 1)) |> Enum.filter(&not_empty?/1) |> get_next_diagonal
  defp get_next_diagonal([[seat | _] | _]), do: seat
end
