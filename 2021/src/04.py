from copy import deepcopy
from functools import reduce
from typing import List


class Table:
    def __init__(self):
        self.rows = [[] for _ in range(5)]
        self.cols = [[] for _ in range(5)]

    rows: List[List[int]]
    cols: List[List[int]]


def get_drawn_numbers() -> List[int]:
    with open("../resources/04.txt", "r") as file:
        return [int(n) for n in file.readline().split(",")]


def get_tables():
    tables: List[Table] = []
    with open("../resources/04.txt", "r") as file:
        file.readline()  # skip drawn numbers
        lines = [line.strip().split() for line in file.readlines() if line.strip() != ""]
        idx = 0
        while idx < len(lines):
            table = Table()
            for i in range(0, 5):
                # populate rows
                current_line = [int(el) for el in lines[idx]]
                table.rows[i] = deepcopy(current_line)

                # populate columns
                for j in range(0, 5):
                    table.cols[j].append(current_line[j])

                idx += 1
            tables.append(table)
    return tables


def sum_remaining_elements(table: Table) -> int:
    sum_per_row = [reduce(lambda x, y: x + y, row) for row in table.rows if len(row) > 0]
    return reduce(
        lambda x, y: x + y,
        sum_per_row if len(sum_per_row) else [0]
    )


def mark(number: int, table: Table) -> bool:
    found = False

    for row in table.rows:
        if number in row:
            row.remove(number)
            if len(row) == 0:
                found = True

    for col in table.cols:
        if number in col:
            col.remove(number)
            if len(col) == 0:
                found = True

    return found


def bingo(drawn: List[int], tables: List[Table]):
    for number in drawn:
        for table in tables:
            if mark(number, table):
                return number * sum_remaining_elements(table)


def bingo_safe(drawn: List[int], tables: List[Table]):
    winning_scores = []
    for number in drawn:
        to_remove = []
        for table in tables:
            if mark(number, table):
                winning_scores.append(number * sum_remaining_elements(table))
                to_remove.append(table)
        for t in to_remove:
            tables.remove(t)
    return winning_scores


if __name__ == '__main__':
    drawn_numbers = get_drawn_numbers()
    tables: List[Table] = get_tables()

    print(bingo(drawn_numbers, deepcopy(tables)))
    print(bingo_safe(drawn_numbers, deepcopy(tables))[-1])
