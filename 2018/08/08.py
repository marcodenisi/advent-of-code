input_file = 'input.txt'
test_input_file = 'input_test.txt'
with open(input_file) as f:
	data = f.read()

class Node:
	def __init__(self):
		self.children = []
		self.metadata = []

	def __str__(self):
		return 'Children:' + str(self.children) + ' - Metadata:' + str(self.metadata)

	def add_children(self, child_node):
		self.children.append(child_node)

	def add_metadata(self, metadata):
		self.metadata.append(metadata)

numbers = data.split(' ')
metadata_sum = 0

def read_node(numbers):
	global metadata_sum
	node = Node()
	children_n = int(numbers[0])
	metadata_n = int(numbers[1])

	if children_n == 0:
		# read metadata
		index = 0
		while index < metadata_n:
			node.add_metadata(int(numbers[2 + index]))
			metadata_sum += int(numbers[2 + index])
			index += 1
		return node
	else:
		# read children
		index = 0
		offset = 2
		while index < children_n:
			child = read_node(numbers[offset:])
			node.add_children(child)
			offset = get_offset(node)
			index += 1

		index = 0
		while index < metadata_n:
			node.add_metadata(int(numbers[offset + index]))
			metadata_sum += int(numbers[offset + index])
			index += 1

	return node

def get_offset(node):
	offset = 2
	if node.children is None or len(node.children) == 0:
		return offset + len(node.metadata)
	for element in node.children:
		offset += get_offset(element)
	return offset + len(node.metadata)

root = read_node(numbers)
print('Part 1:', metadata_sum)

def calc_node_value (node):
	if len(node.children) == 0:
		return sum(node.metadata)

	if len(node.metadata) == 0:
		return 0
	else:
		value = 0
		for meta in node.metadata:
			if meta <= len(node.children) and meta > 0:
				value += calc_node_value(node.children[meta - 1])
		return value

print('Part 2:', calc_node_value(root))
