defmodule AOC.Day4 do

  @fields ["ecl", "pid", "eyr", "hcl", "byr", "iyr", "hgt"]
  @eye_colors ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]

  def count_valid_passports(passports) do
    passports
    |> Enum.count(fn p -> count_valid_fields(p, 0) == length(@fields) end)
  end

  defp count_valid_fields([], acc), do: acc
  defp count_valid_fields(["cid" <> ":" <> _ | tl], acc), do: count_valid_fields(tl, acc)
  defp count_valid_fields([<<field::bytes-size(3)>> <> ":" <> val | tl], acc) do
    case is_valid_field?(field, val) do
      true -> count_valid_fields(tl, acc + 1)
      false -> count_valid_fields([], acc)
    end
  end

  defp is_valid_field?("byr", val), do: byte_size(val) == 4 and String.to_integer(val) >= 1920 and String.to_integer(val) <= 2002
  defp is_valid_field?("iyr", val), do: byte_size(val) == 4 and String.to_integer(val) >= 2010 and String.to_integer(val) <= 2020
  defp is_valid_field?("eyr", val), do: byte_size(val) == 4 and String.to_integer(val) >= 2020 and String.to_integer(val) <= 2030
  defp is_valid_field?("hgt", <<digits::bytes-size(3), "cm">>), do: String.to_integer(digits) >= 150 and String.to_integer(digits) <= 193
  defp is_valid_field?("hgt", <<digits::bytes-size(2), "in">>), do: String.to_integer(digits) >= 59 and String.to_integer(digits) <= 76
  defp is_valid_field?("hcl", <<"#", color::bytes-size(6)>>), do: String.match?(color, ~r/^([0-9]|[a-f]){6}$/)
  defp is_valid_field?("ecl", val), do: val in @eye_colors
  defp is_valid_field?("pid", val), do: byte_size(val) == 9
  defp is_valid_field?(_, _), do: false

end
