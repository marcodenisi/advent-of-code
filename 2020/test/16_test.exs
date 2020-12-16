defmodule AOC.Day16Test do
  use ExUnit.Case
  doctest AOC.Day16

  test "day 16" do
    content =
      "class: 1-3 or 5-7
      row: 6-11 or 33-44
      seat: 13-40 or 45-50

      your ticket:
      7,1,14

      nearby tickets:
      7,3,47
      40,4,50
      55,2,20
      38,6,12"

    rows = parse(content)
    rules = get_rules(rows)
    [_your_ticket | nearby_tickets] = get_tickets(rows)

    assert AOC.Day16.part_1(rules, nearby_tickets) == 71
  end

  test "day 16 - real input" do
    {:ok, content} = File.read("resources/16.txt")

    rows = parse(content)
    rules = get_rules(rows)
    [_your_ticket | nearby_tickets] = get_tickets(rows)

    assert AOC.Day16.part_1(rules, nearby_tickets) == 20013
  end

  defp parse(content) do
    content
    |> String.split("\n", trim: true)
    |> Enum.map(&String.trim/1)
    |> Enum.filter(fn row -> row != "your ticket:" and row != "nearby tickets:" end)
  end

  defp get_rules(rows) do
    rows
    |> Enum.take_while(fn row -> Regex.match?(~r/.+\:.+/, row) end)
    |> Enum.map(fn rule ->
      String.split(rule, ": ", trim: true)
      |> Enum.at(1)
      |> String.split(" or ", trim: true)
      |> Enum.flat_map(fn range ->
          [from, to] = String.split(range, "-", trim: true) |> Enum.map(&String.to_integer/1)
          from..to
        end)
    end)
  end

  defp get_tickets(rows) do
    rows
    |> Enum.drop_while(fn row -> Regex.match?(~r/.+\:.+/, row) end)
    |> Enum.map(fn ticket ->
      String.split(ticket, ",") |> Enum.map(&String.to_integer/1)
    end)
  end

end
