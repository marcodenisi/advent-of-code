package aoc2019

type Intcode struct {
	opcode int
	firstParamMode int
	secondParamMode int
	thirdParamMode int
	indexIncrement int
}

func Exec05(in_opcodes []int, input int) []int {
	opcodes := make([]int, len(in_opcodes))
	copy(opcodes, in_opcodes)
	result := []int{}
	i := 0
	for {
		intcode := parseCommand(opcodes[i])
		originalOpcode := opcodes[i]
		switch intcode.opcode {
			case 1: 
				firstParam := retrieveFirstParam(intcode, opcodes, i)
				secondParam := retrieveSecondParam(intcode, opcodes, i)
				opcodes[opcodes[i + 3]] = firstParam + secondParam
			case 2:
				firstParam := retrieveFirstParam(intcode, opcodes, i)
				secondParam := retrieveSecondParam(intcode, opcodes, i)
				opcodes[opcodes[i + 3]] = firstParam * secondParam
			case 3:
				firstParam := opcodes[i + 1]
				opcodes[firstParam] = input
			case 4:
				result = append(result, retrieveFirstParam(intcode, opcodes, i))
			case 5:
				firstParam := retrieveFirstParam(intcode, opcodes, i)
				if firstParam != 0 {
					i = retrieveSecondParam(intcode, opcodes, i)
				}
			case 6:
				firstParam := retrieveFirstParam(intcode, opcodes, i)
				if firstParam == 0 {
					i = retrieveSecondParam(intcode, opcodes, i)
				}
			case 7:
				firstParam := retrieveFirstParam(intcode, opcodes, i)
				secondParam := retrieveSecondParam(intcode, opcodes, i)
				if firstParam < secondParam {
					opcodes[opcodes[i + 3]] = 1
				} else {
					opcodes[opcodes[i + 3]] = 0
				}
			case 8:
				firstParam := retrieveFirstParam(intcode, opcodes, i)
				secondParam := retrieveSecondParam(intcode, opcodes, i)
				if firstParam == secondParam {
					opcodes[opcodes[i + 3]] = 1
				} else {
					opcodes[opcodes[i + 3]] = 0
				}
		}

		if originalOpcode == opcodes[i] {
			i += intcode.indexIncrement	
		}
		
		if (intcode.indexIncrement == 0) {
			return result
		}
	}
}

func retrieveFirstParam(intcode Intcode, opcodes []int, index int) int {
	if intcode.firstParamMode == 0 {
		return opcodes[opcodes[index + 1]]
	}
	return opcodes[index + 1]
}

func retrieveSecondParam(intcode Intcode, opcodes []int, index int) int {
	if intcode.secondParamMode == 0 {
		return opcodes[opcodes[index + 2]]
	}
	return opcodes[index + 2]
}

func parseCommand(command int) Intcode {
	if command < 100 {
		return Intcode{opcode: command, indexIncrement: getIndexIncrementForOpcode(command)}
	}

	opcode := command % 100
	return Intcode{
		opcode: opcode,
		firstParamMode: command / 100 % 100 % 10,
		secondParamMode: command / 1000 % 10,
		thirdParamMode: command / 10000,
		indexIncrement: getIndexIncrementForOpcode(opcode),
	}
}

func getIndexIncrementForOpcode(opcode int) int {
	switch opcode {
	case 1:
		return 4
	case 2:
		return 4
	case 3:
		return 2
	case 4:
		return 2
	case 5:
		return 3
	case 6:
		return 3
	case 7:
		return 4
	case 8:
		return 4
	default:
		return 0
	}
}