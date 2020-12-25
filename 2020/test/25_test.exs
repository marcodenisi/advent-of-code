defmodule AOC.Day25Test do
  use ExUnit.Case
  doctest AOC.Day25

  test "day 25 - test input" do
    [card_pkey, door_pkey] = [5764801, 17807724]
    assert AOC.Day25.part_1([card_pkey, door_pkey]) == 14897079
  end

  test "day 25" do
    [card_pkey, door_pkey] = [2959251, 4542595]
    assert AOC.Day25.part_1([card_pkey, door_pkey]) == 3803729
  end

end
