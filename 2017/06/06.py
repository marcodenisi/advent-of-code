def calculate_next_configuration(current_configuration):
	blocks = max(current_configuration)
	current_max_idx = current_configuration.index(blocks)
	current_configuration[current_max_idx] = 0

	runner = current_max_idx + 1
	while blocks > 0:
		if runner >= len(current_configuration):
			runner = 0
		current_configuration[runner] += 1
		runner += 1
		blocks -= 1

def memory_reallocation(configurations):
	current_configuration = banks
	calculate_next_configuration(current_configuration)

	while(tuple(current_configuration) not in configurations):
		configurations.add(tuple(current_configuration))
		calculate_next_configuration(current_configuration)

	return current_configuration

with open('input.txt') as f:
	data = f.read()

banks = list(map(int, data.split('\t')))

# add the first configuration to a set
configurations = set()
configurations.add(tuple(banks))

last_configuration = memory_reallocation(configurations)
print("#Part 1 result:", len(configurations))
print("Last configuration:", last_configuration)

# easy way, just re-run the function with a new configurations set
configurations = set()
configurations.add(tuple(last_configuration))
memory_reallocation(configurations)
print("#Part 2 result:", len(configurations))