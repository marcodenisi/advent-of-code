import pprint
import collections

players = 477
last_marble_value = 70851

def place_marble(board, marble_to_place, current_marble_position):
	# initial scenario, only 0 is placed
	if len(board) == 1:
		board.append(marble_to_place)
		return len(board) - 1
	
	# if current marble is the last
	if current_marble_position + 1 == len(board):
		board.insert(1, marble_to_place)
		return 1

	# if current marble position is second to last
	if current_marble_position + 2 == len(board):
		board.append(marble_to_place)
		return len(board) - 1

	#otherwise
	board.insert(current_marble_position + 2, marble_to_place)
	return current_marble_position + 2

def remove_marble(board, marble_to_remove, current_marble_position):
	if current_marble_position - 7 < 0:
		to_remove_from_tail = 7 - current_marble_position
		return len(board) - to_remove_from_tail, board.pop(-to_remove_from_tail)

	return current_marble_position - 7, board.pop(current_marble_position - 7)

def remove_marble_deque(board, marble_to_remove, current_marble_position):
	index = 0
	if current_marble_position - 7 < 0:
		index = len(board) - (7 - current_marble_position)
	else:
		index = current_marble_position - 7
	element = board[index]
	del board[index]
	return index, element

players_points = {}
board = [0]
current_marble_position = 0
marble = 1
while marble < last_marble_value:
	if marble % 23 != 0:
		current_marble_position = place_marble(board, marble, current_marble_position)
	else:
		players_points[marble % players] = players_points.get(marble % players, 0) + marble
		current_marble_position, points_to_add = remove_marble(board, marble, current_marble_position)
		players_points[marble % players] += points_to_add

	marble += 1

pprint.pprint(max(players_points.values()))

last_marble_value = 7085100

board = collections.deque([0])
players_points = collections.defaultdict(int)
for marble in range(1, last_marble_value + 1):
	if marble % 23 == 0:
		board.rotate(7)
		players_points[marble % players] += marble + board.pop()
		board.rotate(-1)
	else:
		board.rotate(-1)
		board.append(marble)
print(max(players_points.values()))
