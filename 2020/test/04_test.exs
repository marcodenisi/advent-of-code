defmodule AOC.Day4Test do
  use ExUnit.Case
  doctest AOC.Day4

  test "day 4 - test input" do
    content = "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
    byr:1937 iyr:2017 cid:147 hgt:183cm

    iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
    hcl:#cfa07d byr:1929

    hcl:#ae17e1 iyr:2013
    eyr:2024
    ecl:brn pid:760753108 byr:1931
    hgt:179cm

    hcl:#cfa07d eyr:2025 pid:166559648
    iyr:2011 ecl:brn hgt:59in
    "

    passports = String.split(content, "\n\n", trim: true)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&split_passport/1)

    assert AOC.Day4.count_valid_passports(passports) == 2
  end

  test "day 4 - real input" do
    {:ok, content} = File.read("resources/04.txt")

    passports = String.split(content, "\n\n", trim: true)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&split_passport/1)

    assert AOC.Day4.count_valid_passports(passports) == 140
  end

  defp split_passport(p) do
    p
    |> String.split(" ", trim: true)
    |> Enum.flat_map(fn f -> String.split(f, "\n", trim: true) end)
  end

end
