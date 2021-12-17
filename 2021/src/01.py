from typing import List


def count_increases(depths: List) -> int:
    count: int = 0
    for i in range(1, len(depths)):
        if depths[i] > depths[i - 1]:
            count += 1

    return count


def reduce_depths(depths: List) -> List:
    reduced_depths = []
    for i in range(0, len(depths) - 2):
        reduced_depths.append(
            depths[i] + depths[i + 1] + depths[i + 2]
        )

    return reduced_depths


if __name__ == '__main__':
    with open("../resources/01.txt", "r") as source:
        depths = [int(l) for l in source.readlines()]
    increases = count_increases(depths)
    print(f"Part 1: {increases}")

    increases = count_increases(reduce_depths(depths))
    print(f"Part 2: {increases}")
