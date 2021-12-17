from typing import List


def move_depth_height(commands: List) -> tuple:
    d = 0
    h = 0
    for command in commands:
        match command:
            case ["forward", x]:
                h += int(x)
            case ["down", x]:
                d += int(command[1])
            case ["up", x]:
                d -= int(command[1])
    return d, h


def move_with_aim(commands: List) -> tuple:
    d = 0
    h = 0
    aim = 0
    for command in commands:
        match command:
            case ["forward", x]:
                h += int(x)
                d += (aim * int(x))
            case ["down", x]:
                aim += int(x)
            case ["up", x]:
                aim -= int(x)
    return d, h, aim


if __name__ == '__main__':
    with open("../resources/02.txt", "r") as file:
        command_list: List = [line.split() for line in file.readlines()]

    depth, height = move_depth_height(command_list)
    print(f"Part 1: {depth * height}")

    depth, height, a = move_with_aim(command_list)
    print(f"Part 2: {depth * height}")
