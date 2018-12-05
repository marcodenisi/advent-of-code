# Part 1

def have_opposite_polarity(first, second):
	return ord(first) == ord(second) + 32 or ord(first) + 32 == ord(second)

def react(data):
	i = 1
	while i < len(data):
		if have_opposite_polarity(data[i], data[i - 1]):
			data = data[:i - 1] + data[i + 1:]
			i -= 1
		else:
			i += 1
	return data


with open('input.txt') as f:
	data = f.read()

print(len(react(data)))

#Part 2

unit_type_dict = {}
for i in range(ord('a'), ord('z') + 1):
	test_data = data.replace(chr(i), '').replace(chr(i - 32), '')
	unit_type_dict[chr(i)] = len(react(test_data))

print(min(unit_type_dict.values()))