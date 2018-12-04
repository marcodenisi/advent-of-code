import re
import pprint

with open('input.txt') as f:
	data = f.read()

rows = data.split('\n')

row_regex = re.compile(r'''
	\[
	([0-9]{4}\-[0-9]{2}\-[0-9]{2}\s00\:[0-9]{2})
	\]
	\s
	(Guard\s\#[0-9]+\sbegins\sshift|falls\sasleep|wakes\sup)
	''', re.VERBOSE)

begins_regex = re.compile(r'Guard\s\#([0-9]+)\sbegins\sshift')

falls_regex = re.compile(r'''
	\[
	([0-9]{4}\-[0-9]{2}\-[0-9]{2}\s00\:([0-9]{2}))
	\]
	\s
	falls\sasleep
	''', re.VERBOSE)

wakes_regex = re.compile(r'''
	\[
	([0-9]{4}\-[0-9]{2}\-[0-9]{2}\s00\:([0-9]{2}))
	\]
	\s
	wakes\sup
	''', re.VERBOSE)

# Part 1

rows.sort()		# sort rows alphabetically (equal to using timestamp)

guards_frequencies = {}
guards = {}
actual_guard = 0
for row in rows:
	if begins_regex.search(row) != None:
		actual_guard = begins_regex.search(row).group(1)

		guards_frequencies[actual_guard] = guards_frequencies.get(actual_guard, [0 for x in range(60)])

	elif falls_regex.search(row) != None:
		start_sleeping_minute = int(falls_regex.search(row).group(2))

	elif wakes_regex.search(row) != None:
		end_sleeping_minute = int(wakes_regex.search(row).group(2))

		total_sleep_time = end_sleeping_minute - start_sleeping_minute
		guards[actual_guard] = guards.get(actual_guard, 0) + total_sleep_time

		for index in range(start_sleeping_minute, end_sleeping_minute):
			guards_frequencies[actual_guard][index] += 1


guard_to_watch = -1
for k, v in guards.items():
	if v == max(guards.values()):
		guard_to_watch = k
		break

print('Guard to watch:', guard_to_watch)
print('Max frequency:', max(guards_frequencies[guard_to_watch]))

minute = -1
for index, value in enumerate(guards_frequencies[guard_to_watch]):
	if value == max(guards_frequencies[guard_to_watch]):
		minute = index
		break
print('Minute:', minute)
print('Result:', minute * int(guard_to_watch))

# Part 2

max_freq_per_guard = {}
for guard, frequency in guards_frequencies.items():
	max_freq_per_guard[guard] = max(frequency)

max_freq = max(max_freq_per_guard.values())
print('Max freq', max_freq)
for k, v in max_freq_per_guard.items():
	if v == max_freq:
		print('Guard having max freq is', k)
		for index, item in enumerate(guards_frequencies[k]):
			if item == max_freq:
				print('Here is the minute', index)
				print('Result:', index * int(k))











