def get_instructions():
    with open("../inputs/03.txt") as file:
        return file.read()


def get_new_position(x, y, instruction):
    if instruction == "<":
        x -= 1
    if instruction == ">":
        x += 1
    if instruction == "^":
        y += 1
    if instruction == "v":
        y -= 1

    return x, y


def part_1(instructions):
    x, y = 0, 0
    visited = {"0;0"}
    for instruction in instructions:
        x, y = get_new_position(x, y, instruction)
        visited.add(f"{x};{y}")

    return visited


def part_2(instructions: str):
    robo_santa_instructions = [instructions[idx] for idx in range(len(instructions)) if idx % 2 != 0]
    santa_instructions = [instructions[idx] for idx in range(len(instructions)) if idx % 2 == 0]

    visited = {"0;0"}
    x, y, x_r, y_r = 0, 0, 0, 0
    for idx in range(len(santa_instructions)):
        instruction = santa_instructions[idx]
        robo_instruction = robo_santa_instructions[idx]

        x, y = get_new_position(x, y, instruction)
        x_r, y_r = get_new_position(x_r, y_r, robo_instruction)

        visited.add(f"{x};{y}")
        visited.add(f"{x_r};{y_r}")

    return visited


if __name__ == '__main__':
    print(len(part_1(get_instructions())))
    print(len(part_2(get_instructions())))
