defmodule AOC.Day12 do

  @directions %{
    :north => [:north, :east, :south, :west],
    :east => [:east, :south, :west, :north],
    :south => [:south, :west, :north, :east],
    :west => [:west, :north, :east, :south]
  }

  def manhattan(instructions) do
    instructions
    |> move(%{})
  end

  defp move(instructions, acc, curr_direction \\ :east)

  defp move([], acc, _), do: abs(Map.get(acc, "x", 0)) + abs(Map.get(acc, "y", 0))

  defp move([[direction, amount] | tl], acc, curr_direction) do
    {acc, curr_direction} = case direction do
      "N" -> {move_in_direction(acc, :north, amount), curr_direction}
      "S" -> {move_in_direction(acc, :south, amount), curr_direction}
      "E" -> {move_in_direction(acc, :east, amount), curr_direction}
      "W" -> {move_in_direction(acc, :west, amount), curr_direction}
      "L" -> {acc, turn(curr_direction, amount, -1)}
      "R" -> {acc, turn(curr_direction, amount)}
      "F" -> {move_in_direction(acc, curr_direction, amount), curr_direction}
    end
    move(tl, acc, curr_direction)
  end

  defp turn(curr_dir, amount, clockwise \\ 1) do
    idx = trunc(amount / 90) * clockwise
    Map.get(@directions, curr_dir)
    |> Enum.at(idx)
  end

  defp move_in_direction(acc, curr_direction, amount) do
    case curr_direction do
      :north -> Map.put(acc, "y", Map.get(acc, "y", 0) + amount)
      :south -> Map.put(acc, "y", Map.get(acc, "y", 0) - amount)
      :east -> Map.put(acc, "x", Map.get(acc, "x", 0) + amount)
      :west -> Map.put(acc, "x", Map.get(acc, "x", 0) - amount)
    end
  end

  def manhattan_with_waypoint(instructions) do
    instructions
    |> move_waypoint(%{"x" => 10, "y" => 1}, %{})
  end

  defp move_waypoint([], _, ship), do: abs(Map.get(ship, "x", 0)) + abs(Map.get(ship, "y", 0))
  defp move_waypoint([[direction, amount] | tl], waypoint_acc, ship_acc) do
    {waypoint_acc, ship_acc} = case direction do
      "N" -> {move_in_direction(waypoint_acc, :north, amount), ship_acc}
      "S" -> {move_in_direction(waypoint_acc, :south, amount), ship_acc}
      "E" -> {move_in_direction(waypoint_acc, :east, amount), ship_acc}
      "W" -> {move_in_direction(waypoint_acc, :west, amount), ship_acc}
      "L" -> {turn_waypoint(waypoint_acc, amount, -1), ship_acc}
      "R" -> {turn_waypoint(waypoint_acc, amount), ship_acc}
      "F" -> {waypoint_acc, move_with_waypoint(ship_acc, waypoint_acc, amount)}
    end
    move_waypoint(tl, waypoint_acc, ship_acc)
  end

  defp move_with_waypoint(ship, waypoint, amount) do
    x = Map.get(waypoint, "x", 0)
    y = Map.get(waypoint, "y", 0)
    ship = Map.put(ship, "x", Map.get(ship, "x", 0) + x * amount)
    Map.put(ship, "y", Map.get(ship, "y", 0) + y * amount)
  end

  defp turn_waypoint(waypoint, amount, clockwise \\ 1) do
    idx = trunc(amount / 90) * clockwise
    x = Map.get(waypoint, "x", 0)
    y = Map.get(waypoint, "y", 0)
    case idx do
      n when n in [1, -3] ->
        waypoint = Map.put(waypoint, "x", y)
        Map.put(waypoint, "y", -x)
      n when n in [2, -2] ->
        waypoint = Map.put(waypoint, "x", -x)
        Map.put(waypoint, "y", -y)
      n when n in [3, -1] ->
        waypoint = Map.put(waypoint, "x", -y)
        Map.put(waypoint, "y", x)
    end
  end

end
