package aoc2019

import (
	"math"
)

type Amplifier struct {
	opcodes    []int
	exitReason string
}

func (a *Amplifier) run(input ...int) []int {
	result := []int{}
	isFirstInput := true
	i := 0
	for {
		intcode := parseCommand(a.opcodes[i])
		originalOpcode := a.opcodes[i]
		switch intcode.opcode {
		case 1:
			firstParam := retrieveFirstParam(intcode, a.opcodes, i)
			secondParam := retrieveSecondParam(intcode, a.opcodes, i)
			a.opcodes[a.opcodes[i+3]] = firstParam + secondParam
		case 2:
			firstParam := retrieveFirstParam(intcode, a.opcodes, i)
			secondParam := retrieveSecondParam(intcode, a.opcodes, i)
			a.opcodes[a.opcodes[i+3]] = firstParam * secondParam
		case 3:
			firstParam := a.opcodes[i+1]
			if isFirstInput {
				a.opcodes[firstParam] = input[0]
				isFirstInput = false
			} else {
				a.opcodes[firstParam] = input[1]
			}
		case 4:
			a.exitReason = "OUTPUT"
			return append(result, retrieveFirstParam(intcode, a.opcodes, i))
		case 5:
			firstParam := retrieveFirstParam(intcode, a.opcodes, i)
			if firstParam != 0 {
				i = retrieveSecondParam(intcode, a.opcodes, i)
			}
		case 6:
			firstParam := retrieveFirstParam(intcode, a.opcodes, i)
			if firstParam == 0 {
				i = retrieveSecondParam(intcode, a.opcodes, i)
			}
		case 7:
			firstParam := retrieveFirstParam(intcode, a.opcodes, i)
			secondParam := retrieveSecondParam(intcode, a.opcodes, i)
			if firstParam < secondParam {
				a.opcodes[a.opcodes[i+3]] = 1
			} else {
				a.opcodes[a.opcodes[i+3]] = 0
			}
		case 8:
			firstParam := retrieveFirstParam(intcode, a.opcodes, i)
			secondParam := retrieveSecondParam(intcode, a.opcodes, i)
			if firstParam == secondParam {
				a.opcodes[a.opcodes[i+3]] = 1
			} else {
				a.opcodes[a.opcodes[i+3]] = 0
			}
		case 99:
			a.exitReason = "99"
			return result
		}

		if originalOpcode == a.opcodes[i] {
			i += intcode.indexIncrement
		}

		if intcode.indexIncrement == 0 {
			a.exitReason = "WRONG"
			return result
		}
	}
}

func Exec07(opcodes, input []int) int {
	permutations := getPermutations(input)
	max := math.MinInt64
	for _, p := range permutations {
		if thruster := calculateThrusterForSettings(opcodes, p, 0); thruster > max {
			max = thruster
		}
	}
	return max
}

func copyOpcodes(in_opcodes []int) []int {
	opcodes := make([]int, len(in_opcodes))
	copy(opcodes, in_opcodes)
	return opcodes
}

func calculateThrusterForSettings(in_opcodes, phaseSettings []int, input int) int {
	amplifierA := Amplifier{opcodes: copyOpcodes(in_opcodes)}
	amplifierB := Amplifier{opcodes: copyOpcodes(in_opcodes)}
	amplifierC := Amplifier{opcodes: copyOpcodes(in_opcodes)}
	amplifierD := Amplifier{opcodes: copyOpcodes(in_opcodes)}
	amplifierE := Amplifier{opcodes: copyOpcodes(in_opcodes)}

	a := amplifierA.run(phaseSettings[0], input)
	b := amplifierB.run(phaseSettings[1], a[0])
	c := amplifierC.run(phaseSettings[2], b[0])
	d := amplifierD.run(phaseSettings[3], c[0])
	e := amplifierE.run(phaseSettings[4], d[0])

	return e[0]
}

func getPermutations(elements []int) [][]int {
	permutations := [][]int{}
	if len(elements) == 1 {
		permutations = [][]int{elements}
		return permutations
	}
	for i := range elements {
		el := make([]int, len(elements))
		copy(el, elements)

		for _, perm := range getPermutations(append(el[0:i], el[i+1:]...)) {
			permutations = append(permutations, append([]int{elements[i]}, perm...))
		}
	}
	return permutations
}
