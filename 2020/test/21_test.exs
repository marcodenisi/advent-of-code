defmodule AOC.Day21Test do
  use ExUnit.Case
  doctest AOC.Day21

  test "day 21 - test input" do
    content = "mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
    trh fvjkl sbzzf mxmxvkd (contains dairy)
    sqjhc fvjkl (contains soy)
    sqjhc mxmxvkd sbzzf (contains fish)"

    foods = parse(content)
    assert AOC.Day21.part_1(foods) == 5
    assert AOC.Day21.part_2(foods) == "mxmxvkd,sqjhc,fvjkl"
  end

  test "day 21" do
    {:ok, content} = File.read("resources/21.txt")
    foods = parse(content)
    assert AOC.Day21.part_1(foods) == 2324
    assert AOC.Day21.part_2(foods) == "bxjvzk,hqgqj,sp,spl,hsksz,qzzzf,fmpgn,tpnnkc"
  end

  defp parse(content) do
    String.split(content, "\n", trim: true)
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn row ->
      [ingredients, allergens] = String.split(row, " (", trim: true)

      allergens = allergens
      |> String.replace("contains", "")
      |> String.replace(")", "")
      |> String.split(", ", trim: true)
      |> Enum.map(&String.trim/1)

      ingredients = ingredients
      |> String.split(" ", trim: true)

      {allergens, ingredients}
    end)
  end

end
