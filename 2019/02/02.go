package aoc2019

import (
	"os"
	"encoding/csv"
	"fmt"
	"strconv"
	"log"
)

func Exec02(filePath string) {
	codes := load(filePath)
	setState(codes, 12, 2)
	prog := intCodeProgram(codes)
	fmt.Println("Part 1 - Result: ", prog[0])	
}

func Exec02Part2(filePath string, target int) {
	codes := load(filePath)
	for noun := 0; noun <= 99; noun++ {
		for verb := 0; verb <= 99; verb++ {
			setState(codes, noun, verb)
			if target == intCodeProgram(codes)[0] {
				fmt.Println("Part 2 - Result: ", 100 * noun + verb)
				return
			}
		}
	}
	fmt.Println("Not found")
}

func intCodeProgram(codes []int) []int {
	prog := make([]int, len(codes))
	copy(prog, codes)
	for i := 0; i < len(prog); i = i + 4 {
		switch op := prog[i]; op {
		case 1:
			prog[prog[i + 3]] = prog[prog[i + 1]] + prog[prog[i + 2]]
		case 2:
			prog[prog[i + 3]] = prog[prog[i + 1]] * prog[prog[i + 2]]
		case 99:
			return prog
		default:
			log.Fatalf("Something wrong, unsupported operation: %v at index: %v", op, i)
		}
	}
	return prog
}

func setState(codes []int, noun int, verb int) {
	codes[1] = noun
	codes[2] = verb
}

func load(filePath string) []int {
	file, err := os.Open(filePath)
	check(err)
	defer file.Close()

	reader := csv.NewReader(file)
	row, err := reader.Read()
	check(err)

	codes := make([]int, len(row))
	for i := 0; i < len(row); i++ {
		codes[i], err = strconv.Atoi(row[i])
		check(err)
	}

	return codes
}