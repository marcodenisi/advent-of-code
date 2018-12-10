import re
import pprint

input_file = 'input.txt'
test_input_file = 'test_data.txt'
with open(input_file) as f:
	data = f.read()

instructions = data.split('\n')

instruction_regex = re.compile(r'''
	Step\s
	([A-Z])
	\smust\sbe\sfinished\sbefore\sstep\s
	([A-Z])
	\scan\sbegin\.
	''', re.VERBOSE)

graph = {}
occurrences = {}
children = []
for instruction in instructions:
	first, second = instruction_regex.findall(instruction)[0]
	if first not in graph:
		graph[first] = [second]
	else:
		graph[first].append(second)
	occurrences[first] = occurrences.get(first, 0)
	occurrences[second] = occurrences.get(second, 0) + 1
	children.append(second)

top_elements = list(set(graph.keys()) - set(children))
top_elements.sort()

result = ''
queue = list(top_elements)
temp_occurrences = dict(occurrences)
while len(queue) > 0:
	step = queue[0]
	queue.remove(step)
	result += step
	if graph.get(step, None) is not None:
		for element in graph[step]:
			temp_occurrences[element] -= 1
			if element not in queue and temp_occurrences[element] == 0:
				queue.append(element)
	queue.sort()

print('Part 1:', result)

workers = 5
delay = 60
queue = list(top_elements)
current_steps = {}
temp_occurrences = dict(occurrences)
time = 0
is_first_iteration = True
while len(current_steps) > 0 or is_first_iteration:
	is_first_iteration = False
	time += 1
	for step in current_steps.keys():
		current_steps[step] -= 1
		if current_steps[step] == 0 and graph.get(step, None) is not None:
			for element in graph[step]:
				temp_occurrences[element] -= 1
				if element not in queue and temp_occurrences[element] == 0:
					queue.append(element)

	# remove entries in current_step dictionary with 0 as value
	current_steps = { k:v for k, v in current_steps.items() if v != 0 }

	while len(current_steps) < workers and len(queue) > 0:
		step = queue[0]
		queue.remove(step)
		current_steps[step] = delay + ord(step) - 64

print('Part 2:', time - 1)