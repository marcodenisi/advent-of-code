from copy import deepcopy
from typing import List


def get_gamma_epsilon(reports: List) -> tuple:
    position_digit_acc: List = []
    for i in range(len(reports[0]) - 1):
        position_digit_acc.append(0)

    for report in reports:
        for idx in range(len(report) - 1):
            digit = report[idx]
            if digit == "0":
                position_digit_acc[idx] += 1

    gamma = ""
    epsilon = ""
    for value in position_digit_acc:
        if value > len(reports) / 2:
            gamma += "0"
            epsilon += "1"
        else:
            gamma += "1"
            epsilon += "0"

    return gamma, epsilon


def get_rating(reports: List, condition) -> str:
    for i in range(len(reports[0])):
        count = 0
        for report in reports:
            if report[i] == "0":
                count += 1

        if condition(count, reports):
            # get only zeroes
            reports = list(filter(lambda x: (x[i] == "0"), reports))
        else:
            # get only ones
            reports = list(filter(lambda x: (x[i] == "1"), reports))

        if len(reports) == 1:
            return reports[0]


if __name__ == '__main__':
    with open("../resources/03.txt", "r") as file:
        numbers: List = file.readlines()

    g, e = get_gamma_epsilon(numbers)
    print(int(g, 2) * int(e, 2))

    def oxigen_condition(count, reports):
        return count > len(reports) / 2

    def c02_scrubber_condition(count, reports):
        return count <= len(reports) / 2

    ox = get_rating(deepcopy(numbers), oxigen_condition)
    co2 = get_rating(deepcopy(numbers), c02_scrubber_condition)
    print(int(ox, 2) * int(co2, 2))
