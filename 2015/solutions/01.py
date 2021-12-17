def part_1():
    with open("../inputs/00.txt", "r") as file:
        input = file.read()

    return input.count("(") - input.count(")")

def part_2():
    with open("../inputs/00.txt", "r") as file:
        input = file.read()

    current = 0
    for idx in range(len(input)):
        if "(" == input[idx]:
            current += 1
        else:
            current -= 1

        if current == -1:
            return idx + 1

if __name__ == '__main__':
    print(part_1())
    print(part_2())
