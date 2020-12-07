defmodule AOC.Day7Test do
  use ExUnit.Case
  doctest AOC.Day7

  test "day 7 - test input" do
    content = "light red bags contain 1 bright white bag, 2 muted yellow bags.
    dark orange bags contain 3 bright white bags, 4 muted yellow bags.
    bright white bags contain 1 shiny gold bag.
    muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
    shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
    dark olive bags contain 3 faded blue bags, 4 dotted black bags.
    vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
    faded blue bags contain no other bags.
    dotted black bags contain no other bags."


    assert AOC.Day7.shiny_bags(parseInput(content)) == 4
    assert AOC.Day7.shiny_bags_count(parseInput(content)) == 32
  end

  test "day 7 - real input" do
    {:ok, content} = File.read("resources/07.txt")
    assert AOC.Day7.shiny_bags(parseInput(content)) == 259
    assert AOC.Day7.shiny_bags_count(parseInput(content)) == 45018
  end

  def parseInput(input) do
    String.split(input, "\n", trim: true)
    |> Enum.reject(&String.contains?(&1, "no other bags"))
    |> Enum.map(&String.replace(&1, "bags", "bag"))
    |> Enum.map(&String.replace(&1, ".", ""))
    |> Enum.map(&String.split(&1, "contain", trim: true))
    |> Enum.reduce(%{}, &intoTree(&1, &2))
  end

  defp intoTree([parent, child], acc) do
    bags = String.split(child, ",", trim: true)
    |> Enum.map(&String.split(&1, " ", parts: 2, trim: true))

    Map.put(acc, String.trim(parent), bags)
  end

end
