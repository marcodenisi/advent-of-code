import re
import pprint
from collections import deque

def calc_pots_sum(configuration):
	pots_sum = 0
	for index, element in enumerate(configuration):
		if element == '#':
			pots_sum += (index - zero_position) 
	return pots_sum

configuration = list('#.#..#..###.###.#..###.#####...########.#...#####...##.#....#.####.#.#..#..#.#..###...#..#.#....##.')

with open('input.txt') as f:
	data = f.read()

rule_regex = re.compile(r'''
	([\.|\#]{5})
	\s\=\>\s
	(\#|\.)
	''', re.VERBOSE)

rules = {}
for rule in data.split('\n'):
	tpl = rule_regex.findall(rule)[0]
	rules[tpl[0]] = tpl[1]

# keep track of pot 0
for index in range(0, 3):
	configuration.insert(0, '.')
for index in range(0, 1000):
	configuration.append('.')
zero_position = 3

previous_sum = calc_pots_sum(configuration)
for generation in range(0, 1000):

	if generation % 500000 == 0:
		print(generation)

	next_configuration = list(configuration)
	for index in range(2, len(configuration) - 2):
		if rules.get(''.join(configuration[index - 2 : index + 3]), None) is not None:
			next_configuration[index] = rules[''.join(configuration[index - 2 : index + 3])]
		else:
			next_configuration[index] = '.'
	configuration = list(next_configuration)
	current_sum = calc_pots_sum(configuration)
	print('gen', generation, current_sum, current_sum - previous_sum)
	previous_sum = current_sum