defmodule AOC.Day4 do

  @fields ["ecl", "pid", "eyr", "hcl", "byr", "iyr", "hgt"]
  @eye_colors ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]

  defguard is_valid_byr?(val) when byte_size(val) == 4 and val >= "1920" and val <= "2002"
  defguard is_valid_iyr?(val) when byte_size(val) == 4 and val >= "2010" and val <= "2020"
  defguard is_valid_eyr?(val) when byte_size(val) == 4 and val >= "2020" and val <= "2030"
  defguard is_valid_pid?(val) when byte_size(val) == 9
  defguard is_valid_ecl?(val) when val in @eye_colors
  defguard is_valid_hgt_cm?(val) when val >= "150" and val <= "193"
  defguard is_valid_hgt_in?(val) when val >= "59" and val <= "76"

  def count_valid_passports(passports) do
    passports
    |> Enum.count(fn p -> count_valid_fields?(p, 0) == length(@fields) end)
  end

  defp count_valid_fields?([], acc), do: acc
  defp count_valid_fields?(["cid" <> ":" <> _ | tl], acc), do: count_valid_fields?(tl, acc)
  defp count_valid_fields?([<<field::bytes-size(3)>> <> ":" <> val | tl], acc) do
    case is_valid_field?(field, val) do
      true -> count_valid_fields?(tl, acc + 1)
      false -> count_valid_fields?([], acc)
    end
  end

  defp is_valid_field?("byr", val) when is_valid_byr?(val), do: true
  defp is_valid_field?("iyr", val) when is_valid_iyr?(val), do: true
  defp is_valid_field?("eyr", val) when is_valid_eyr?(val), do: true
  defp is_valid_field?("hgt", <<digits::bytes-size(3), "cm">>) when is_valid_hgt_cm?(digits), do: true
  defp is_valid_field?("hgt", <<digits::bytes-size(2), "in">>) when is_valid_hgt_in?(digits), do: true
  defp is_valid_field?("hcl", <<"#", color::bytes-size(6)>>), do: String.match?(color, ~r/^([0-9]|[a-f]){6}$/)
  defp is_valid_field?("ecl", val) when is_valid_ecl?(val), do: true
  defp is_valid_field?("pid", val) when is_valid_pid?(val), do: true
  defp is_valid_field?(_, _), do: false

end
