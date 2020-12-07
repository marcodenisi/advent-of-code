defmodule AOC.Day7 do

  def shiny_bags(bags) do
    Enum.map(Map.keys(bags), &dfs(bags, &1, "shiny gold bag"))
    |> Enum.sum()
  end

  def shiny_bags_count(bags) do
    count_bags(bags, "shiny gold bag")
  end

  defp dfs(tree, root, targetNode) do
    case Map.fetch(tree, root) do
      {:ok, leaf} ->
        case Enum.any?(leaf, fn [_, bag] -> bag == targetNode end) do
          true -> 1
          false ->
            found = Enum.any?(leaf, fn [_, bag] -> dfs(tree, bag, targetNode) == 1 end)
            case found do
              true -> 1
              false -> 0
            end
        end
      :error ->
        0
    end
  end

  defp count_bags(bagtree, root) do
    case Map.fetch(bagtree, root) do
      {:ok, bags} ->
        Enum.reduce(bags, 0, fn [num, bag], acc ->
          acc + String.to_integer(num) + String.to_integer(num) * count_bags(bagtree, bag)
        end)

      :error ->
        0
    end
  end

end
