import pprint

serial_number = 5719
d = [[0 for x in range(0, 301)] for x in range(0, 301)]
for i in range(1, 301):
  for j in range(1, 301):
    rack_id = i + 10
    then = (rack_id * j + serial_number) * rack_id
    powr = ((then // 100) % 10) - 5
    d[i][j] = powr

max_power = 0
x = 0
y = 0
for i in range(1, 298):
	for j in range(1, 298):
		power = sum(d[i][j:j+3]) + sum(d[i+1][j:j+3]) + sum(d[i+2][j:j+3])
		if power > max_power:
			max_power = power
			x = i
			y = j
print(max_power, x, y)

squares = {}
for i in range(1, 301):
	for j in range(1, 301):
		squares[(i, j, 1)] = d[i][j]

max_power = 0
x = 0
y = 0
max_size = 0
for size in range(2, 301):
	for i in range(1, 301 - size + 1):
		for j in range(1, 301 - size + 1):
			try:
				previous_sum = squares.get((i, j, size - 1), 0)
				previous_sum += sum(d[i + size - 1][j : j + size])
				for index in range(i, i + size - 1):
					previous_sum += d[index][j + size - 1]
				squares[(i, j, size)] = previous_sum

				if previous_sum > max_power:
					max_power = previous_sum
					x = i
					y = j
					max_size = size

			except IndexError as e:
				print('Error: ', i, j, size)
				print(e)

print(max_power, x, y, max_size)