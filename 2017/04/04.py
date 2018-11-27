with open('input.txt') as f:
	data = f.read()

passphrases = data.split('\n')

#Part 1

count = 0
for passphrase in passphrases:
	words = passphrase.split(' ')
	if len(words) == len(set(words)):
		count += 1

print(count)

# Part 2

count = 0
for passphrase in passphrases:
	words = passphrase.split(' ')
	wordsSet = set()
	for word in words:
		wordsSet.add(''.join(sorted(word)))
	if len(wordsSet) == len(words):
		count += 1

print(count)


