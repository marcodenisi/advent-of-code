def get_packages():
    with open("../inputs/01.txt", "r") as file:
        return file.read().splitlines()


def part_1(packages):
    total_paper_needed = 0
    for package in packages:
        l, w, h = map(int, package.split("x"))
        faces = [
            l * w,
            l * h,
            w * h,
        ]
        total_paper_needed += sum([2 * face for face in faces]) + min(faces)

    return total_paper_needed


def part_2(packages):

    total_ribbon_feet = 0
    for package in packages:
        l, w, h = map(int, package.split("x"))
        sides = [l, w, h]
        sides.remove(max(sides))

        total_ribbon_feet += l * h * w + 2 * (sides[0] + sides[1])

    return total_ribbon_feet


if __name__ == '__main__':
    print(part_1(packages=get_packages()))
    print(part_2(packages=get_packages()))
