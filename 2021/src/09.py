def parse_map(filename):
    with open(filename) as file:
        return [[int(el) for el in list(line.strip())] for line in file.readlines()]


def is_out_of_bound(r, c, map):
    return r < 0 or c < 0 or r >= len(map) or c >= len(map[0])


def check(r, c, map, current_element):
    if is_out_of_bound(r, c, map):
        return True

    return map[r][c] > current_element


def count_lower(map):
    counter = 0
    lower_points = []
    for r, row in enumerate(map):
        for c, col in enumerate(row):
            current_element = map[r][c]
            is_less_than_above = check(r - 1, c, map, current_element)
            is_less_than_below = check(r + 1, c, map, current_element)
            is_less_than_left = check(r, c - 1, map, current_element)
            is_less_than_right = check(r, c + 1, map, current_element)

            if is_less_than_above and is_less_than_below and is_less_than_left and is_less_than_right:
                counter += (current_element + 1)
                lower_points.append((r, c))
    return counter, lower_points


def visit(r, c, map, visited):
    if (r, c) in visited:
        return 0

    visited.add((r, c))

    if is_out_of_bound(r, c, map) or map[r][c] == 9:
        return 0

    return 1 + visit(r - 1, c, map, visited) + visit(r + 1, c, map, visited) + visit(r, c - 1, map, visited) + visit(r, c + 1, map, visited)


def get_basis(map, lower_points):
    basis_sizes = []
    for point in lower_points:
        visited = set()
        basis_sizes.append(visit(point[0], point[1], map, visited))
    return basis_sizes


if __name__ == '__main__':
    map = parse_map("../resources/09.txt")
    count, lp = count_lower(map)
    print(count)

    sizes = sorted(get_basis(map, lp), reverse=True)
    print(sizes[0] * sizes[1] * sizes[2])



