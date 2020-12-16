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

end
