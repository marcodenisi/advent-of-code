with open('input.txt') as f:
	data = f.read()

frequencies = data.split('\n')

# Part 1
counter = 0
for frequence in frequencies:
	counter += int(frequence)

print(counter)

# Part 2

counter = 0
found = False
frequencies_set = set()
while found is False:
	for frequence in frequencies:
		counter += int(frequence)
		if counter not in frequencies_set:
			frequencies_set.add(counter)
		else:
			found = True
			break
		
print(counter)