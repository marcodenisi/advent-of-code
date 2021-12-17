from copy import deepcopy
from functools import reduce
from typing import List


def get_lanternfishes(filename: str):
    with open(filename, "r") as file:
        return [int(n) for n in file.readline().strip().split(",")]


def generate(fishes: List[int], iterations: int):
    for _ in range(iterations):
        born_fishes = 0
        for i, f in enumerate(fishes):
            match f:
                case 0:
                    fishes[i] = 6
                    born_fishes += 1
                case _:
                    fishes[i] -= 1

        for i in range(born_fishes):
            fishes.append(8)
    return len(fishes)


def smart_generate(fishes: List[int], iterations: int):
    days: dict[int, int] = {k: 0 for k in range(9)}
    for i, f in enumerate(fishes):
        days[f] += 1

    for _ in range(iterations):
        to_be_added = 0
        next_day = {k: 0 for k in range(9)}
        for k, v in days.items():
            if k == 0 and v > 0:
                to_be_added = v
            else:
                next_day[k - 1] = v
        next_day[8] = to_be_added
        next_day[6] += to_be_added
        days = next_day

    return reduce(lambda x, y: x + y, days.values())


if __name__ == '__main__':
    lf = get_lanternfishes("../resources/06.txt")

    lantern_fishes: List = deepcopy(lf)
    print(smart_generate(lantern_fishes, 80))
    print(smart_generate(lantern_fishes, 256))
