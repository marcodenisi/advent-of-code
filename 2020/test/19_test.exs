defmodule AOC.Day19Test do
  use ExUnit.Case
  doctest AOC.Day19

  test "day 19" do
    {:ok, content} = File.read("resources/19.txt")

    [rule_lines, message_lines] = content
    |> String.replace("\"", "")
    |> String.split("\n\n", trim: true)

    rule_map = rule_lines
    |> String.split("\n", trim: true)
    |> Enum.map(fn rule ->
      [_, rule_num, rule_components] = Regex.run(~r/(\d+): (.*)$/, rule)
      {rule_num, rule_components}
    end)
    |> Enum.reduce(%{}, &Map.put(&2, elem(&1, 0), elem(&1, 1)))

    messages = message_lines |> String.split("\n", trim: true)

    assert AOC.Day19.part_1(rule_map, messages) == 173
    assert AOC.Day19.part_2(rule_map, messages) == 367
  end

end
