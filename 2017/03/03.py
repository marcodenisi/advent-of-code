# Part 1

input = 361527

index = 1
while index * index < input:
	index += 2

square = index * index
print('Here\'s the square found', square)
print('Here\'s the index found', index)

initial_starting_running = square
while input <= initial_starting_running - (index - 1):
	initial_starting_running -= (index - 1)

print('Starting counting from', initial_starting_running)

distance = index - 1
target_distance = 0
print(distance / 2)
if (initial_starting_running - input) <= distance / 2:
	target_distance = distance - (initial_starting_running - input)
else:
	target_distance = abs(input - initial_starting_running)

print('Target distance:', target_distance)

# Part 2

def next_coords(x, y):
	if x == y == 0: 
		return (1, 0)
	if y > -x and x > y:   	# go up
		return (x, y+1)
	if y > -x and y>= x: 	# go left
		return (x-1, y)
	if y <= -x and x < y:   # go down
		return (x, y-1)
	if y <= -x and x >= y: 	# go right
		return (x+1, y)

x, y = 0, 0
vals = {(0, 0): 1}
while vals[(x, y)] <= input:
	x, y = next_coords(x, y)
	vals[(x, y)] = sum(vals.get((x+i, y+j), 0) for i in [-1, 0, 1] for j in [-1, 0, 1])

print('Result part 2:', vals[(x, y)])