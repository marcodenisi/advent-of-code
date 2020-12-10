defmodule AOC.Day4 do

  def valid_passphrase(phrases) do
    phrases
    |> Enum.map(&String.split(&1, " "))
    |> Enum.filter(fn p ->
      distinct = MapSet.new(p)
      if MapSet.size(distinct) != length(p), do: false, else: true
    end)
    |> Enum.count
  end

  def valid_passphrase_2(phrases) do
    phrases
    |> Enum.map(&String.split(&1, " "))
    |> Enum.filter(fn p ->
      p = p
      |> Enum.map(&String.split(&1, "", trim: true))
      |> Enum.map(&Enum.sort/1)
      |> Enum.map(&Enum.join/1)
      distinct = MapSet.new(p)
      if MapSet.size(distinct) != length(p), do: false, else: true
    end)
    |> Enum.count
  end

end
