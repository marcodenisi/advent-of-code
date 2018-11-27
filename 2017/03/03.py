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