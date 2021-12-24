from copy import deepcopy
from typing import List

CHUNKS = {
    "(": ")",
    "[": "]",
    "{": "}",
    "<": ">",
}
SCORES = {
    ")": 3,
    "]": 57,
    "}": 1197,
    ">": 25137,
}
AUTO_COMPLETE_SCORES = {
    "(": 1,
    "[": 2,
    "{": 3,
    "<": 4,
}


def parse_input(filename):
    with open(filename) as file:
        return [list(line.strip()) for line in file.readlines()]


def calc_error_score(line: List):
    stack = []
    for c in line:
        if c in CHUNKS.keys():
            stack.append(c)
        else:
            last_open_c = stack.pop()
            if CHUNKS[last_open_c] != c:
                return SCORES[c]
    return 0


def calc_total_error_score(chunk_lines):
    incomplete_lines = []
    counter = 0
    for line in chunk_lines:
        score = calc_error_score(line)
        if score == 0:
            incomplete_lines.append(deepcopy(line))
        counter += score
    return counter, incomplete_lines


def get_score_for_stack(stack):
    score = 0
    stack = reversed(stack)
    for chunk in stack:
        score *= 5
        score += AUTO_COMPLETE_SCORES[chunk]
    return score


def autocomplete_score(line: List):
    stack = []
    for c in line:
        if c in CHUNKS.keys():
            stack.append(c)
        else:
            stack.pop()

    return get_score_for_stack(stack)


def autocomplete_scores(chunk_lines):
    scores = []
    for line in chunk_lines:
        scores.append(autocomplete_score(line))
    return scores


if __name__ == '__main__':
    input = parse_input("../resources/10.txt")
    score, incomplete_lines = calc_total_error_score(input)
    print(score)

    autocomplete_score_list = sorted(autocomplete_scores(incomplete_lines))
    mid = int(len(autocomplete_score_list) / 2)
    print(autocomplete_score_list[mid])


