import re

with open('input.txt') as f:
	data = f.read()

claims = data.split('\n')

#Part 1

claim_regex = re.compile(r'''
	\#
	([0-9]+) #id
	\s\@\s
	([0-9]+) # left distance
	\,
	([0-9]+) # top distance
	\:\s
	([0-9]+) # width
	[x]
	([0-9]+) # height
	''', re.VERBOSE)

# init matrix
matrix = [[0 for x in range(1000)] for y in range(1000)]

conflicts = 0
# for each claim
for claim in claims:
	identifier, left_d, top_d, w, h = claim_regex.findall(claim)[0]
	for idx in range(int(left_d), int(left_d) + int(w)):
		for idx_2 in range(int(top_d), int(top_d) + int(h)):
			if matrix[idx][idx_2] != 'X':
				if matrix[idx][idx_2] != 0:
					matrix[idx][idx_2] = 'X'
					conflicts += 1
					is_intact = False
				else:
					matrix[idx][idx_2] = 1

print(conflicts)

# Part 2
for claim in claims:
	identifier, left_d, top_d, w, h = claim_regex.findall(claim)[0]
	is_intact = True
	for idx in range(int(left_d), int(left_d) + int(w)):
		for idx_2 in range(int(top_d), int(top_d) + int(h)):
			if matrix[idx][idx_2] == 'X':
				is_intact = False
	if is_intact:
		print(identifier)