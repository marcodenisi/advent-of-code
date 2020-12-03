defmodule AOC.Day1 do
  def fix_expenses_2(expenses, target) do
    [hd | _] = for x <- expenses, y <- expenses, x + y == target, do: x * y
    hd
  end

  def fix_expenses_3(expenses, target) do
    [hd | _] = for x <- expenses, y <- expenses, z <- expenses, x + y + z == target, do: x * y * z
    hd
  end
end
