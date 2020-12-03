defmodule AOC.Day3Test do
  use ExUnit.Case
  doctest AOC.Day3

  test "day 3 - test input" do
    lines = "..##.......
    #...#...#..
    .#....#..#.
    ..#.#...#.#
    .#...##..#.
    ..#.##.....
    .#.#.#....#
    .#........#
    #.##...#...
    #...##....#
    .#..#...#.#"
    |> String.split("\n", trim: true)
    |> Enum.map(&String.trim/1)

    assert AOC.Day3.count_trees(lines, 3, 1) == 7
    assert AOC.Day3.count_trees(lines, 1, 1) == 2
    assert AOC.Day3.count_trees(lines, 5, 1) == 3
    assert AOC.Day3.count_trees(lines, 7, 1) == 4
    assert AOC.Day3.count_trees(lines, 1, 2) == 2
  end

  test "day 3 - real input" do
    {:ok, content} = File.read("resources/03.txt")

    lines = content
    |> String.split("\n", trim: true)

    assert AOC.Day3.count_trees(lines, 3, 1) == 242
    assert AOC.Day3.count_trees(lines, 1, 1) == 82
    assert AOC.Day3.count_trees(lines, 5, 1) == 71
    assert AOC.Day3.count_trees(lines, 7, 1) == 67
    assert AOC.Day3.count_trees(lines, 1, 2) == 24
  end

end
