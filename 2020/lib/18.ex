defmodule AOC.Day18 do

  def part_1(equations) do
    equations
    |> Enum.map(&do_solve(&1, nil, nil))
    |> Enum.sum
  end

  defp do_solve([], acc, _), do: acc
  defp do_solve([hd | tl], acc, last_op) do
    case hd do
      val when val in ["+", "*"] -> do_solve(tl, acc, val)
      "(" ->
        {operand, new_tl} = do_solve(tl, nil, nil)
        acc = if acc == nil do
          operand
        else
          if last_op == "+", do: acc + operand, else: acc * operand
        end
        do_solve(new_tl, acc, nil)
      ")" -> {acc, tl}
      val ->
        operand = String.to_integer(val)
        if acc == nil do
          do_solve(tl, operand, last_op)
        else
          acc = if last_op == "+", do: acc + operand, else: acc * operand
          do_solve(tl, acc, nil)
        end
    end
  end

  def part_2(equations) do
    equations
    |> Enum.map(&do_solve_2(&1, nil, nil))
    |> Enum.map(fn {el, _} -> el end)
    |> Enum.sum
  end

  defp do_solve_2([], acc, _), do: {acc, []}
  defp do_solve_2([hd | tl], acc, last_op) do
    case hd do
      "+" -> do_solve_2(tl, acc, "+")
      "*" ->
        {operand, new_tl} = do_solve_2(tl, nil, nil)
        acc = if acc != nil do
          acc * operand
        else
          operand
        end
        {acc, new_tl}
      "(" ->
        {operand, new_tl} = do_solve_2(tl, nil, nil)
        acc = if acc == nil do
          operand
        else
          if last_op == "+", do: acc + operand, else: acc * operand
        end
        do_solve_2(new_tl, acc, nil)
      ")" -> {acc, tl}
      val ->
        operand = String.to_integer(val)
        if acc != nil do
          do_solve_2(tl, acc + operand, nil)
        else
          do_solve_2(tl, operand, nil)
        end
    end
  end

end
