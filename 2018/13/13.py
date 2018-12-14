import pprint
from collections import OrderedDict

with open('input.txt') as f:
	data = f.read()

rows = data.split('\n')
map_rows = []
for row in rows:
	map_rows.append(list(row))

def get_cart_positions(rows):
	positions = {}
	for row_index, row in enumerate(rows):
		for char_index, char in enumerate(row):
			if char in (['v', '<', '>', '^']):
				positions[row_index, char_index] = (char, 0)
	return OrderedDict(sorted(positions.items()))

def get_interceptions_coords(rows):
	positions = []
	for row_index, row in enumerate(rows):
		for char_index, char in enumerate(row):
			if char == '+':
				positions.append((row_index, char_index))
	return positions

def get_curves(rows):
	positions = {}
	for row_index, row in enumerate(rows):
		for char_index, char in enumerate(row):
			if char in ['\\', '/']:
				positions[row_index, char_index] = char
	return positions

def check_crash(rows):
	for row_index, row in enumerate(rows):
		for char_index, char in enumerate(row):
			if char == 'X':
				return True, row_index, char_index
	return False, -1, -1

def check_crashes(rows):
	crashes = set()
	for row_index, row in enumerate(rows):
		for char_index, char in enumerate(row):
			if char == 'X':
				crashes.add((row_index, char_index))
	return crashes

def move(rows, cart_positions, interception_positions, curve_positions):
	new_positions = {}
	for (x, y), (cart_value, cart_interceptions) in cart_positions.items():
		interception = False
		new_x = -1
		new_y = -1
		cart = ''
		if cart_value == '>':
			interception, new_x, new_y, cart = move_right(rows, x, y, cart_interceptions)
		elif cart_value == '<':
			interception, new_x, new_y, cart = move_left(rows, x, y, cart_interceptions)
		elif cart_value == '^':
			interception, new_x, new_y, cart = move_up(rows, x, y, cart_interceptions)
		else:
			interception, new_x, new_y, cart = move_down(rows, x, y, cart_interceptions)

		if interception:
			new_positions[(new_x, new_y)] = (cart, (cart_positions[(x, y)][1] + 1) % 3)
		else:
			new_positions[(new_x, new_y)] = (cart, cart_positions[(x, y)][1])

		if (x, y) in interception_positions:
			rows[x][y] = '+'

		if (x, y) in curve_positions:
			rows[x][y] = curve_positions[(x, y)]

	return OrderedDict(sorted(new_positions.items(), key=lambda x:(x[0], x[1])))

def move_right(rows, x, y, cart_interceptions):
	rows[x][y] = '-'
	next_char = rows[x][y + 1]
	if next_char == '/':
		rows[x][y + 1] = '^'
	elif next_char == '\\':
		rows[x][y + 1] = 'v'
	elif next_char == '-':
		rows[x][y + 1] = '>'
	elif next_char == '+':
		if cart_interceptions == 0:
			rows[x][y + 1] = '^'
		elif cart_interceptions == 1:
			rows[x][y + 1] = '>'
		else:
			rows[x][y + 1] = 'v'
		return True, x, y + 1, rows[x][y + 1]
	else:
		rows[x][y + 1] = 'X'
	return False, x, y + 1, rows[x][y + 1]

def move_left(rows, x, y, cart_interceptions):
	rows[x][y] = '-'
	next_char = rows[x][y - 1]
	if next_char == '/':
		rows[x][y - 1] = 'v'
	elif next_char == '\\':
		rows[x][y - 1] = '^'
	elif next_char == '-':
		rows[x][y - 1] = '<'
	elif next_char == '+':
		if cart_interceptions == 0:
			rows[x][y - 1] = 'v'
		elif cart_interceptions == 1:
			rows[x][y - 1] = '<'
		else:
			rows[x][y - 1] = '^'
		return True, x, y - 1, rows[x][y - 1]
	else: 
		rows[x][y - 1] = '<'
	return False, x, y - 1, rows[x][y - 1]

def move_up(rows, x, y, cart_interceptions):
	rows[x][y] = '|'
	next_char = rows[x - 1][y]
	if next_char == '/':
		rows[x - 1][y] = '>'
	elif next_char == '\\':
		rows[x - 1][y] = '<'
	elif next_char == '|':
		rows[x - 1][y] = '^'
	elif next_char == '+':
		if cart_interceptions == 0:
			rows[x - 1][y] = '<'
		elif cart_interceptions == 1:
			rows[x - 1][y] = '^'
		else:
			rows[x - 1][y] = '>'
		return True, x - 1, y, rows[x - 1][y]
	else:
		rows[x - 1][y] = 'X'
	return False, x - 1, y, rows[x - 1][y]

def move_down(rows, x, y, cart_interceptions):
	rows[x][y] = '|'
	next_char = rows[x + 1][y]
	if next_char == '/':
		rows[x + 1][y] = '<'
	elif next_char == '\\':
		rows[x + 1][y] = '>'
	elif next_char == '|':
		rows[x + 1][y] = 'v'
	elif next_char == '+':
		if cart_interceptions == 0:
			rows[x + 1][y] = '>'
		elif cart_interceptions == 1:
			rows[x + 1][y] = 'v'
		else:
			rows[x + 1][y] = '<'
		return True, x + 1, y, rows[x + 1][y]
	else:
		rows[x + 1][y] = 'X'
	return False, x + 1, y, rows[x + 1][y]

def print_map(rows):
	for row in rows:
		print(''.join(row))

cart_positions = get_cart_positions(map_rows)
interception_positions = get_interceptions_coords(map_rows)
curve_positions = get_curves(map_rows)
crashed = False
x = -1
y = -1
while not crashed:
	cart_positions = move(map_rows, cart_positions, interception_positions, curve_positions)
	crashed, x, y = check_crash(map_rows)

print(x, y)

#### PART 2

rows = data.split('\n')

initial_state = []
for row in rows:
	initial_state.append(list(row))

cart_positions = get_cart_positions(map_rows)
interception_positions = get_interceptions_coords(map_rows)
curve_positions = get_curves(map_rows)
x = -1
y = -1
map_rows = list(initial_state)
while len(cart_positions) > 1:
	cart_positions = move(map_rows, cart_positions, interception_positions, curve_positions)
	crashes = check_crashes(map_rows)
	for crash in crashes:
		print('crash', crash)
		print(cart_positions)
		cart_positions.pop(crash, None)
		map_rows[crash[0]][crash[1]] = initial_state[crash[0]][crash[1]]

cart_positions = move(map_rows, cart_positions, interception_positions, curve_positions)
print(cart_positions)











