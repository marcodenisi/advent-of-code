import pprint
import re

class Pixel:
	def __init__(self, x, y, vx, vy):
		self.x = x
		self.y = y
		self.vx = vx
		self.vy = vy

	def move(self):
		self.x += self.vx
		self.y += self.vy

	def __str__(self):
		return 'x: ' + self.x + ' - y: ' + self.y

def plot(pixels, y, x):
	sky = [[' ' for i in range(0, max(y) - min(y) + 1)] for i in range(0, max(x) - min(x) + 1)]
	for p in pixels:
		sky[p.x - min(x)][p.y - min(y)] = '#'
	
	for i in range(0, len(sky)):
		print(sky[i])


with open('input.txt') as f:
	data = f.read()

rows = data.split('\n')

row_regex = re.compile(r'''
	position\=\<
	([\s|\-]?[0-9]+)
	\,\s
	([\s|\-]?[0-9]+)
	\>\svelocity\=\<
	([\s|\-]?[0-9]+)
	\,\s
	([\s|\-]?[0-9]+)
	\>
	''', re.VERBOSE) 

pixels = []
for row in rows:
	features = row_regex.findall(row)[0]
	pixels.append(Pixel(int(features[0]), int(features[1]), int(features[2]), int(features[3])))

time = 0
while True:
	time += 1

	y = []
	x = []
	for pixel in pixels:
		pixel.move()
		y.append(pixel.y)
		x.append(pixel.x)

	if max(y) - min(y) <= 9:
		print(time)
		plot(pixels, y, x)

