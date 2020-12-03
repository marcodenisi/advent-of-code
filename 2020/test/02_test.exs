defmodule AOC.Day2Test do
  use ExUnit.Case
  doctest AOC.Day2

  test "day 2 - test input" do
    policies = ["1-3 a", "1-3 b", "2-9 c"]
    passwords = ["abcde", "cdefg", "ccccccccc"]

    assert AOC.Day2.count_valid_pwds(policies, passwords) == 2
  end

  test "day 2.1 - real input" do
    {:ok, content} = File.read("resources/02.txt")

    lines = content
    |> String.split("\n", trim: true)
    |> Enum.map(fn line -> String.split(line, ": ", parts: 2) end)

    policies = lines |> Enum.map(fn [p, _] -> p end)
    passwords = lines |> Enum.map(fn [_, pwd] -> pwd end)

    assert AOC.Day2.count_valid_pwds(policies, passwords) == 569

    assert AOC.Day2.count_valid_password_part_2(policies, passwords) == 346
  end

end
