from typing import List


class Segment:
    def __init__(self, start: [int], end: [int]):
        self.start = start
        self.end = end

    start: [int]
    end: [int]


def parse_segments():
    with open("../resources/05.txt") as file:
        segment_list = [
            [start.split(","), end.split(",")] for start, end in
            [line.split(" -> ") for line in file.readlines()]
        ]

        return [
            Segment(
                start=[int(start[0].strip()), int(start[1].strip())],
                end=[int(end[0].strip()), int(end[1].strip())],
            )
            for start, end in segment_list
        ]


def is_vertical(s: Segment):
    return s.start[0] == s.end[0]


def is_horizontal(s: Segment):
    return s.start[1] == s.end[1]


def count_overlaps(points: dict):
    return len(list(filter(lambda x: points[x] > 1, points.keys())))


def count_points(segments: List[Segment]):
    points = dict()
    for segment in segments:
        if is_vertical(segment):
            x = segment.start[0]
            y_start = min(segment.start[1], segment.end[1])
            y_end = max(segment.start[1], segment.end[1])
            for y in range(y_start, y_end + 1):
                if (x, y) in points:
                    points[(x, y)] += 1
                else:
                    points[(x, y)] = 1
        elif is_horizontal(segment):
            y = segment.start[1]
            x_start = min(segment.start[0], segment.end[0])
            x_end = max(segment.start[0], segment.end[0])
            for x in range(x_start, x_end + 1):
                if (x, y) in points:
                    points[(x, y)] += 1
                else:
                    points[(x, y)] = 1
        else:
            y_dir = 1 if segment.start[1] < segment.end[1] else -1
            x_dir = 1 if segment.start[0] < segment.end[0] else -1
            x, y = (segment.start[0], segment.start[1])

            for i in range(abs(segment.start[0] - segment.end[0]) + 1):
                if (x, y) in points:
                    points[(x, y)] += 1
                else:
                    points[(x, y)] = 1

                x += x_dir
                y += y_dir

    return points


if __name__ == '__main__':
    segments: List[Segment] = parse_segments()
    # part 1
    points = count_points(
        [s for s in segments if is_vertical(s) or is_horizontal(s)]
    )
    print(count_overlaps(points))

    # part 2
    points = count_points(segments)
    print(count_overlaps(points))
