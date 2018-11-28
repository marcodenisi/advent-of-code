with open('input.txt') as f:
	data = f.read()

maze = list(map(int, data.split('\n')))

# Part 1

count = 0
index = 0
while index < len(maze):
	jumps = maze[index]
	maze[index] = maze[index] + 1
	index += jumps
	count += 1

print(count)

# Part 2

maze = list(map(int, data.split('\n')))

count = 0
index = 0
while index < len(maze):
	jumps = maze[index]
	if maze[index] >= 3:
		maze[index] = maze[index] - 1
	else:
		maze[index] = maze[index] + 1
	index += jumps
	count += 1

print(count)