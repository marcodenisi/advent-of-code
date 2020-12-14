defmodule AOC.Day14 do

  def part_1(program) do
    program
    |> Enum.flat_map(
      fn %{:mask => mask, :instructions => instructions} ->
        maskOr = mask |> String.replace("X", "0") |> String.to_integer(2)
        maskAnd = mask |> String.replace("X", "1") |> String.to_integer(2)
        for %{:memory => location, :value => value} <- instructions do
          value = String.to_integer(value, 2)
          %{
            :memory => location,
            :value => Bitwise.bor(maskOr, value) |> Bitwise.band(maskAnd)
          }
        end
    end)
    |> Enum.reduce(%{}, fn %{:memory => memory, :value => value}, acc ->
      Map.put(acc, memory, value)
    end)
    |> Map.values
    |> Enum.sum
  end

  def part_2(filename \\ "input14.txt") do
    filename
    |> get_lines()
    |> Enum.map(fn line ->
      case Regex.run(~r/mask = ([X|1|0]+)/, line) do
        [_, mask] ->
          {:mask, mask}

        nil ->
          [_, mem_pos, val] = Regex.run(~r/mem\[(\d+)\] = (\d+)/, line)
          {:mem, String.to_integer(mem_pos), String.to_integer(val)}
      end
    end)
    |> init_memory_v2
    |> Map.values()
    |> Enum.sum()
  end

  def get_lines(filename, split_char \\ "\n") do
    filename
    |> File.read!
    |> String.split(split_char)
  end

  def init_memory_v2(commands, mask \\ "", memory \\ %{})
  def init_memory_v2([{:mask, mask} | tail], _, memory), do: init_memory_v2(tail, mask, memory)

  def init_memory_v2([{:mem, mem_pos, val} | tail], mask, memory) do
    memory_adresses_to_write = get_memory_addresses(mem_pos, mask)

    init_memory_v2(
      tail,
      mask,
      Enum.reduce(memory_adresses_to_write, memory, &Map.put(&2, &1, val))
    )
  end

  def init_memory_v2([], _, memory), do: memory

  def get_memory_addresses(mem_pos, mask) do
    {base_val, x_pos_list} =
      mem_pos
      |> Integer.to_string(2)
      |> String.pad_leading(36, "0")
      |> String.graphemes()
      |> Stream.zip(String.graphemes(mask))
      |> Stream.map(fn {bit, mask_bit} ->
        case mask_bit do
          "0" -> bit
          _ -> mask_bit
        end
      end)
      |> Stream.with_index()
      |> Enum.reduce({"", []}, fn {bit, i}, {string_so_far, x_pos_list} ->
        case bit do
          "X" -> {string_so_far <> "0", [35 - i | x_pos_list]}
          _ -> {string_so_far <> bit, x_pos_list}
        end
      end)

    base_val = base_val |> String.to_integer(2)

    x_pos_list
      |> Enum.map(&(:math.pow(2, &1) |> floor))
      |> get_permutations([0])
      |> Enum.map(&(base_val + &1))
  end

  def get_permutations([head | tail], list_so_far) do
    new_list = for a <- [0, head], b <- list_so_far, do: a + b
    get_permutations(tail, Enum.uniq(new_list))
  end
  def get_permutations([], list_so_far), do: list_so_far


end
