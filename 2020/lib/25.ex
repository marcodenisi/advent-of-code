defmodule AOC.Day25 do

  def part_1([card_pkey, door_pkey]) do
    card_loop_size = calc(1, card_pkey, 0)
    calc_encryption(1, door_pkey, 0, card_loop_size)
  end

  defp calc(val, key, iteration) when val == key, do: iteration
  defp calc(val, key, iteration), do: calc(rem(val * 7, 20201227), key, iteration + 1)

  defp calc_encryption(val, _, iteration, loop_size) when iteration == loop_size, do: val
  defp calc_encryption(val, key, iteration, loop_size), do: calc_encryption(rem(val * key,  20201227), key, iteration + 1, loop_size)

end
