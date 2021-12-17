from typing import List


def get_positions(filename):
    with open(filename) as file:
        return [int(p) for p in file.readline().strip().split(",")]


def min_fuel(positions: List[int], fuel_calc_func) -> int:
    min_x = min(positions)
    max_x = max(positions)

    return min(
        [sum(fuel_calc_func(positions, p)) for p in range(min_x, max_x + 1)]
    )


if __name__ == '__main__':
    positions = get_positions("../resources/07.txt")

    def dumb_fuel_calc(position_list, current_pos):
        return map(lambda x: abs(current_pos - x), positions)

    def smart_fuel_calc(position_list, current_pos):
        return map(lambda x: sum([pos for pos in range(1, abs(current_pos - x) + 1)]), position_list)

    print(min_fuel(positions, dumb_fuel_calc))
    print(min_fuel(positions, smart_fuel_calc))
