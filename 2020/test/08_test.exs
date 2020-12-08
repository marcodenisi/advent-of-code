defmodule AOC.Day8Test do
  use ExUnit.Case
  doctest AOC.Day8

  test "day 8 - test input" do
    content = "nop +0
    acc +1
    jmp +4
    acc +3
    jmp -3
    acc -99
    acc +1
    jmp -4
    acc +6"

    instructions = parse(content)
    assert AOC.Day8.execute(instructions) == {:loop, 5}
    assert AOC.Day8.fix_loop(instructions) == {:ok, 8}
  end

  test "day 8 - real input" do
    {:ok, content} = File.read("resources/08.txt")
    instructions = parse(content)
    assert AOC.Day8.execute(instructions) == {:loop, 1816}
    assert AOC.Day8.fix_loop(instructions) == {:ok, 1149}
  end

  defp parse(content) do
    content
    |> String.split("\n", trim: true)
    |> Enum.map(&String.trim/1)
    |> Enum.with_index()
    |> Enum.map(
        fn {l, idx} ->
            [op | arg] = String.split(l, " ", trim: true)
            {num, _} = Integer.parse(hd(arg))
            {idx, op, num}
        end
    )
  end

end
