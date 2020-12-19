defmodule AOC.Day19 do

  def part_1(rule_map, messages) do
    rule_zero_regex_string = rule_map
    |> compile_regex_for_key("0")

    rule_zero_regex =
      "^#{rule_zero_regex_string}$"
      |> Regex.compile!()

    Enum.filter(messages, &Regex.match?(rule_zero_regex, &1))
    |> Enum.count()
  end

  def part_2(rule_map, messages) do
    rule_map = rule_map |> Map.put("8", "42 | 42 8") |> Map.put("11", "42 31 | 42 11 31")

    rule_zero_regex_string =
      rule_map
      |> compile_regex_for_key("0", true)

    rule_zero_regex =
      "^#{rule_zero_regex_string}$"
      |> Regex.compile!()

    Enum.filter(messages, &Regex.match?(rule_zero_regex, &1))
    |> Enum.count()
  end

  def compile_regex_for_key(rule_map, key \\ "0", doing_p2 \\ false)
  def compile_regex_for_key(_, "a", _), do: "a"
  def compile_regex_for_key(_, "b", _), do: "b"
  def compile_regex_for_key(_, "|", _), do: "|"

  def compile_regex_for_key(rule_map, "8", true) do
    "(#{
      rule_map
      |> Map.get("42")
      |> String.split(" ", trim: true)
      |> Enum.map(&compile_regex_for_key(rule_map, &1, true))
    })+"
  end

  def compile_regex_for_key(rule_map, "11", true) do
    ident = "a#{:rand.uniform(1000) |> Integer.to_string()}"

    "(?'#{ident}'(#{
      rule_map
      |> Map.get("42")
      |> String.split(" ", trim: true)
      |> Enum.map(&compile_regex_for_key(rule_map, &1, true))
    })(?&#{ident})?(#{
      rule_map
      |> Map.get("31")
      |> String.split(" ", trim: true)
      |> Enum.map(&compile_regex_for_key(rule_map, &1, true))
    }))"
  end

  def compile_regex_for_key(rule_map, key, is_p2?) do
    rule =
      rule_map
      |> Map.get(key)
      |> String.split(" ", trim: true)
      |> Enum.map(&compile_regex_for_key(rule_map, &1, is_p2?))

    case Enum.count(rule) do
      1 -> hd(rule)
      _ -> "(#{rule})"
    end
  end
end
