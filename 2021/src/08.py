from typing import List


def get_input(filename: str):
    with open(filename) as file:
        return [line.strip().split(" | ") for line in file.readlines()]


def get_easy_digits(output_digits_list: List):
    count = 0
    for out_digit in output_digits_list:
        count += len([digit for digit in out_digit if len(digit) in [2, 3, 4, 7]])
    return count


def int_from_readout(readout, translations):
    out = ''
    readout = readout.split(" ")
    for digit in readout:
        digit = "".join(sorted(digit))
        out += translations[digit]
    return int(out)


def digit_has_segments(digit, segment_list):
    return all(item in digit for item in segment_list)


def find_zero_and_six(digits, one, nine):
    zero = None
    six = None
    for digit in list(filter(lambda x: len(x) == 6, digits)):
        if digit == nine:
            continue

        if digit_has_segments(digit, one):
            zero = digit
        else:
            six = digit

    return zero, six


def find_two_and_five(digits, three, six):
    two = None
    five = None
    for digit in list(filter(lambda x: len(x) == 5, digits)):
        if digit == three:
            continue

        if six and digit_has_segments(six, digit):
            five = digit
        else:
            two = digit

    return two, five


def sum_signals(signals: List):

    output_sum = 0
    for signal in signals:
        digits, readout = signal
        digits = ["".join(sorted(d)) for d in digits.split(" ")]

        one = next(filter(lambda x: len(x) == 2, digits), None)
        four = next(filter(lambda x: len(x) == 4, digits), None)
        seven = next(filter(lambda x: len(x) == 3, digits), None)
        eight = next(filter(lambda x: len(x) == 7, digits), None)
        three = next(filter(lambda x: len(x) == 5 and digit_has_segments(x, one), digits), None)
        nine = next(filter(lambda x: len(x) == 6 and digit_has_segments(x, four), digits), None)
        zero, six = find_zero_and_six(digits, one, nine)
        two, five = find_two_and_five(digits, three, six)

        translations = {
            zero: '0',
            one: '1',
            two: '2',
            three: '3',
            four: '4',
            five: '5',
            six: '6',
            seven: '7',
            eight: '8',
            nine: '9'
        }

        output_sum += int_from_readout(readout, translations)

    return output_sum


if __name__ == '__main__':
    signals = get_input("../resources/08.txt")

    output_digits = [signal[1].split(" ") for signal in signals]
    print(get_easy_digits(output_digits))

    print(sum_signals(signals))