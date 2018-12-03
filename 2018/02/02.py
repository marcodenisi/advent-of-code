with open('input.txt') as f:
	data = f.read()

ids = data.split('\n')

from collections import Counter

# Part 1
counter_2 = 0
counter_3 = 0
for i in ids:
	found_counter_2 = False
	found_counter_3 = False
	for key, val in Counter(i).items():
		if val == 2:
			found_counter_2 = True
		if val == 3:
			found_counter_3 = True
	if found_counter_2:
		counter_2 += 1
	if found_counter_3:
		counter_3 += 1

print('Mult:', counter_2 * counter_3)

# Part 2

def are_near(first, second):
	if (len(first) != len(second)):
		return False;

	counter = 0
	for i in range(0, len(first)):
		if first[i] != second[i]:
			counter += 1

	return counter == 1

def get_resulting_string(first, second):
	result = ''
	for idx, char in enumerate(first):
		if second[idx] == char:
			result += char
	return result

for i in range(0, len(ids) - 1):
	for j in range(i + 1, len(ids)):
		if are_near(ids[i], ids[j]):
			print(ids[i], ids[j])
			print(get_resulting_string(ids[i], ids[j]))
