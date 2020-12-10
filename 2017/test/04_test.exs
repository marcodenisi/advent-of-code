defmodule AOC.Day4Test do
  use ExUnit.Case
  doctest AOC.Day4

  test "Day 4 - real input" do
    {:ok, content} = File.read("resources/04.txt")
    assert AOC.Day4.valid_passphrase(parse(content)) == 477
    assert AOC.Day4.valid_passphrase_2(parse(content)) == 167
  end

  defp parse(content) do
    content
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

end
