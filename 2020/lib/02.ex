defmodule AOC.Day2 do
  def count_valid_pwds(policies, passwords) do
    Enum.zip(policies, passwords)
    |> Enum.count(fn {policy, password} -> is_valid?(password, policy) end)
  end

  defp is_valid?(password, policy) do
    policy_char = policy_char(policy)

    password
    |> String.split("", trim: true)
    |> Enum.count(fn char -> policy_char == char end)
    |> is_policy_respected?(policy)
  end

  defp policy_char(policy) do
    [_, char] = String.split(policy, " ", parts: 2)
    char
  end

  defp is_policy_respected?(count, policy) do
    [counts, _] = String.split(policy, " ", parts: 2)
    [min, max] = String.split(counts, "-", parts: 2)
    count >= String.to_integer(min) && count <= String.to_integer(max)
  end

  def count_valid_password_part_2(policies, passwords) do
    Enum.zip(policies, passwords)
    |> Enum.count(fn {policy, password} -> is_policy_respected_part_2?(password, policy) end)
  end

  defp is_policy_respected_part_2?(password, policy) do
    [counts, char] = String.split(policy, " ", parts: 2)
    [first, second] = String.split(counts, "-", parts: 2)
    xor(String.at(password, String.to_integer(first) - 1) == char,
        String.at(password, String.to_integer(second) - 1) == char)
  end

  defp xor(true, false), do: true
  defp xor(false, true), do: true
  defp xor(_, _), do: false

end
