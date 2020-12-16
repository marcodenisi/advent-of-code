defmodule AOC.Day16 do

  def part_1(rules, tickets) do
    tickets
    |> Enum.reduce(0, fn ticket, acc ->
      wrong_ticket = ticket
      |> Enum.filter(fn number ->
        case rules |> Enum.any?(fn rule -> number in rule end) do
          false -> true
          _ -> false
        end
      end)
      |> Enum.at(0)
      if wrong_ticket, do: wrong_ticket + acc, else: acc
    end)
  end

  def part_2(rules, [my_ticket | nearby_tickets]) do
    rules = rules |> Enum.with_index

    acc = for number <- my_ticket, do: get_satisfied_rules(number, rules)

    nearby_tickets
    |> Enum.filter(&is_valid_ticket?(&1, rules))
    |> Enum.reduce(acc, fn ticket, accumulator ->
      ticket
      |> Enum.map(&get_satisfied_rules(&1, rules))
      |> Enum.zip(accumulator)
      |> Enum.map(fn {current, old} -> MapSet.intersection(current, old) end)
    end)
    |> Enum.with_index
    |> Enum.sort
    |> Enum.reduce(%{}, fn {rule_indexes, position}, acc ->
      rule_index = rule_indexes
      |> Enum.find(fn rule_idx ->
        not Map.has_key?(acc, rule_idx)
      end)
      Map.put(acc, rule_index, position)
    end)
    |> Enum.take(6)
    |> Enum.reduce(1, fn {_, pos}, acc ->
      acc * Enum.at(my_ticket, pos)
    end)

  end

  defp is_valid_ticket?(ticket, rules) do
    ticket
    |> Enum.all?(fn number ->
      rules |> Enum.any?(fn {rule, _} -> number in rule end)
    end)
  end

  defp get_satisfied_rules(number, rules) do
    rules |> Enum.filter(fn {rule, _} -> number in rule end) |> Enum.map(fn {_, idx} -> idx end) |> MapSet.new
  end

end
