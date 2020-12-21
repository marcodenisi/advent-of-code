defmodule AOC.Day21 do

  def part_1(foods) do

    ingredients_with_allergen = foods
    |> Enum.reduce(%{}, &ingredients_for_allergens/2)
    |> Map.values
    |> Enum.flat_map(&MapSet.to_list/1)
    |> MapSet.new

    foods
    |> Enum.reduce(0, fn {_, ingredients}, acc ->
      size = MapSet.new(ingredients)
      |> MapSet.difference(ingredients_with_allergen)
      |> MapSet.size
      acc + size
    end)
  end

  defp ingredients_for_allergens({[], _}, acc), do: acc
  defp ingredients_for_allergens({[hd | tl], ingredients}, acc) do
    acc = case Map.get(acc, hd) do
      nil -> Map.put(acc, hd, MapSet.new(ingredients))
      val -> Map.put(acc, hd, MapSet.intersection(val, MapSet.new(ingredients)))
    end
    ingredients_for_allergens({tl, ingredients}, acc)
  end

  def part_2(foods) do
    allergen_ingredients = foods
    |> Enum.reduce(%{}, &ingredients_for_allergens/2)

    allergen_ingredients = allergen_ingredients
    |> Map.to_list
    |> Enum.sort_by(fn {_, set} -> set end)

    map_allergen(allergen_ingredients, %{}, allergen_ingredients)
    |> Enum.reduce("", fn
        {_, ingredient}, "" -> ingredient
        {_, ingredient}, acc -> acc <> "," <> ingredient
      end
    )
  end


  defp map_allergen([], acc, _), do: acc
  defp map_allergen([{allergen, ingredient_set} | rest], acc, allergen_ingredients) do
    ingredient = MapSet.to_list(ingredient_set) |> Enum.at(0)
    acc = Map.put(acc, allergen, MapSet.to_list(ingredient_set) |> Enum.at(0))
    allergen_ingredients = allergen_ingredients
    |> Enum.reject(fn {id, _} -> id == allergen end)
    |> Enum.map(fn {id, ingredients} ->
      {
        id,
        MapSet.delete(ingredients, ingredient)
      }
    end)
    |> Enum.sort_by(fn {_, set} -> set end)

    rest = rest
    |> Enum.map(fn {id, ingredients} ->
      {
        id,
        MapSet.delete(ingredients, ingredient)
      }
    end)
    |> Enum.sort_by(fn {_, set} -> set end)

    map_allergen(rest, acc, allergen_ingredients)
  end


end
