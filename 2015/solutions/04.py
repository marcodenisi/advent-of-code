import hashlib


def part_1(key):
    number = 0
    result = hashlib.md5(f"{key}{number}".encode()).hexdigest()

    while not result.startswith("00000"):
        number += 1
        result = hashlib.md5(f"{key}{number}".encode()).hexdigest()

    return number


def part_2(key):
    number = 0
    result = hashlib.md5(f"{key}{number}".encode()).hexdigest()

    while not result.startswith("000000"):
        number += 1
        result = hashlib.md5(f"{key}{number}".encode()).hexdigest()

    return number


if __name__ == '__main__':
    key = "yzbqklnj"
    print(part_1(key))
    print(part_2(key))
