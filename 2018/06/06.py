import re
import pprint

with open('input.txt') as f:
	data = f.read()

size = 350

####### test data
#data = '''1, 1
#1, 6
#8, 3
#3, 4
#5, 5
#8, 9'''

#size = 10
#######

def manhattan_distance(first_point, second_point):
	return abs(int(first_point[0]) - int(second_point[0])) + abs(int(first_point[1]) - int(second_point[1]))

def has_no_right_point(x, y, value, matrix):
	for index in range(y + 1, len(matrix[x])):
		if matrix[x][index] != value:
			return False
	return True

def has_no_left_point(x, y, value, matrix):
	for index in range(0, y - 1):
		if matrix[x][index] != value:
			return False
	return True

def has_no_above_point(x, y, value, matrix):
	for index in range(0, x - 1):
		if matrix[index][y] != value:
			return False
	return True

def has_no_below_point(x, y, value, matrix):
	for index in range(x + 1, len(matrix)):
		if matrix[index][y] != value:
			return False
	return True

def has_infinite_area(x, y, value, matrix):
	return (has_no_below_point(x, y, value, matrix) or 
		   has_no_above_point(x, y, value, matrix) or 
		   has_no_right_point(x, y, value, matrix) or 
		   has_no_left_point(x, y, value, matrix))

def init_matrix(size, points):
	matrix = [[0 for x in range(size)] for y in range(size)]
	for index, point in enumerate(points):
		matrix[point[0]][point[1]] = index + 1
	return matrix 

coords_regex = re.compile(r'''
	([0-9]+)
	\,\s
	([0-9]+)
	''', re.VERBOSE)

rows = data.split('\n')

# extract coordinates
points = []
for row in rows:
	string_point = coords_regex.findall(row)[0]
	points.append((int(string_point[0]), int(string_point[1])))

# init matrix
matrix = init_matrix(size, points)

# calculate min manhattan distance for each matrix point
areas_dict = {}
for row in range(size):
	for column in range(size):

		if (row, column) in points:
			continue

		distances = [0 for x in range(len(points))]
		for index, point in enumerate(points):
			distances[index] = manhattan_distance([row, column], point)

		min_distance = min(distances)
		counter = distances.count(min_distance)		
		if counter < 2:
			nearest = distances.index(min_distance) + 1
			matrix[row][column] = nearest
			areas_dict[nearest] = areas_dict.get(nearest, 0) + 1
		else:
			matrix[row][column] = -1

# remove points that have no other point above/belove or right/left
areas_list = []
for point_index, area in areas_dict.items():
	x, y = points[point_index - 1]
	if not has_infinite_area(x, y, point_index, matrix):
		areas_list.append(area)

print('Part 1', max(areas_list) + 1) # +1 cause the point itself is not taken into account

limit = 10000
matrix = init_matrix(size, points)

region_size = 0
for row in range(size):
	for column in range(size):
		for index, point in enumerate(points):
			matrix[row][column] += manhattan_distance([row, column], point)
		if matrix[row][column] < limit:
			region_size += 1

print('Part 2', region_size)