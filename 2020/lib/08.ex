defmodule AOC.Day8 do
  def execute(instructions) do
    do_execute(Enum.at(instructions, 0), 0, instructions, MapSet.new())
  end

  def fix_loop(instructions) do
    instructions
    |> Enum.filter(fn {_, op, _} -> op == "nop" or op == "jmp" end)
    |> Enum.map(fn {idx, op, arg} ->
      Enum.slice(instructions, 0..idx - 1) ++ [flip({idx, op, arg})] ++ Enum.slice(instructions, idx + 1..length(instructions) - 1)
    end)
    |> Enum.map(&execute/1)
    |> Enum.find(fn {exit_status, _} -> exit_status == :ok end)
  end

  defp flip({idx, "nop", arg}), do: {idx, "jmp", arg}
  defp flip({idx, "jmp", arg}), do: {idx, "nop", arg}

  defp do_execute(nil, acc, _, _), do: {:ok, acc}

  defp do_execute({index, "nop", _}, acc, instructions, executed) do
    if MapSet.member?(executed, index) do
      {:loop, acc}
    else
      do_execute(Enum.at(instructions, index + 1), acc, instructions, MapSet.put(executed, index))
    end
  end

  defp do_execute({index, "acc", arg}, acc, instructions, executed) do
    if MapSet.member?(executed, index) do
      {:loop, acc}
    else
      do_execute(Enum.at(instructions, index + 1), acc + arg, instructions, MapSet.put(executed, index))
    end
  end

  defp do_execute({index, "jmp", arg}, acc, instructions, executed) do
    if MapSet.member?(executed, index) do
      {:loop, acc}
    else
      do_execute(Enum.at(instructions, index + arg), acc, instructions, MapSet.put(executed, index))
    end
  end

end
