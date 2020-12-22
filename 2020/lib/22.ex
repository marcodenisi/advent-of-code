defmodule AOC.Day22 do

  def part_1([deck1, deck2]) do
    fight(deck1, deck2)
    |> Enum.reverse
    |> Enum.with_index(1)
    |> Enum.reduce(0, fn {idx, el}, acc -> acc + el * idx end)
  end

  defp fight([hd1 | rest1], [hd2 | rest2]) when hd1 >= hd2, do: fight(rest1 ++ [hd1, hd2], rest2)
  defp fight([hd1 | rest1], [hd2 | rest2]) when hd1 < hd2, do: fight(rest1, rest2 ++ [hd2, hd1])
  defp fight(deck1, []), do: deck1
  defp fight([], deck2), do: deck2

  def part_2([deck1, deck2]) do
    {cards, _} = recursive_fight(deck1, deck2, MapSet.new(), MapSet.new())

    cards
    |> Enum.reverse
    |> Enum.with_index(1)
    |> Enum.reduce(0, fn {idx, el}, acc -> acc + el * idx end)
  end

  defp recursive_fight(deck1, [], _, _), do: {deck1, 1}
  defp recursive_fight([], deck2, _, _), do: {deck2, 2}
  defp recursive_fight([hd1 | rest1] = p1_deck, [hd2 | rest2] = p2_deck, p1_rounds, p2_rounds) when length(rest1) < hd1 or length(rest2) < hd2 do
    if MapSet.member?(p1_rounds, p1_deck) or MapSet.member?(p2_rounds, p2_deck) do
      {p1_deck, 1}
    else
      p1_rounds = MapSet.put(p1_rounds, p1_deck)
      p2_rounds = MapSet.put(p2_rounds, p2_deck)
      if hd1 > hd2 do
        recursive_fight(rest1 ++ [hd1, hd2], rest2, p1_rounds, p2_rounds)
      else
        recursive_fight(rest1, rest2 ++ [hd2, hd1], p1_rounds, p2_rounds)
      end
    end
  end

  defp recursive_fight([hd1 | rest1] = p1_deck, [hd2 | rest2] = p2_deck, p1_rounds, p2_rounds) do
    if MapSet.member?(p1_rounds, p1_deck) or MapSet.member?(p2_rounds, p2_deck) do
      {p1_deck, 1}
    else
      p1_rounds = MapSet.put(p1_rounds, p1_deck)
      p2_rounds = MapSet.put(p2_rounds, p2_deck)
      {_, winner} = recursive_fight(Enum.take(rest1, hd1), Enum.take(rest2, hd2), MapSet.new(), MapSet.new())
      case winner do
        1 -> recursive_fight(rest1 ++ [hd1, hd2], rest2, p1_rounds, p2_rounds)
        2 -> recursive_fight(rest1, rest2 ++ [hd2, hd1], p1_rounds, p2_rounds)
      end
    end

  end

end
