defmodule AOC.Day3 do

  def manhattan(target), do: do_build({0, 0}, 1, 1, 0, target, :right)

  defp do_build({x, y}, current_num, _step, _index, target, _gradient) when target == current_num, do: x + y

  defp do_build({x, y}, current_num, step, index, target, gradient) when index < step - 1 do
    do_build(
      move(gradient, {x, y}),
      current_num + 1,
      step,
      index + 1,
      target,
      gradient
    )
  end

  defp do_build({x, y}, current_num, step, _index, target, _gradient) when current_num == step * step do
    do_build(
      move(:right, {x, y}), # go right
      current_num + 1, #increase number
      step + 2, # increase step (square length)
      1, # set index to one
      target,
      :up # always go up here
    )
  end

  defp do_build({x, y}, current_num, step, _index, target, gradient) do
    gradient = turn_left(gradient)
    do_build(
      move(gradient, {x, y}),
      current_num + 1,
      step,
      1,
      target,
      gradient
    )
  end

  defp move(:up, {x, y}), do: {x, y + 1}
  defp move(:down, {x, y}), do: {x, y - 1}
  defp move(:right, {x, y}), do: {x + 1, y}
  defp move(:left, {x, y}), do: {x - 1, y}

  defp turn_left(:up), do: :left
  defp turn_left(:left), do: :down
  defp turn_left(:down), do: :right
  defp turn_left(:right), do: :up

end
