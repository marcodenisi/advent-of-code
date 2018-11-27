with open('input.txt') as f:
	data = f.read()

passphrases = data.split('\n')

count = 0
for passphrase in passphrases:
	words = passphrase.split(' ')
	if len(words) == len(set(words)):
		count += 1

print(count)