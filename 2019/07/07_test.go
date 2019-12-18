package aoc2019

import (
	"bufio"
	"os"
	"reflect"
	"strconv"
	"strings"
	"testing"
)

func TestExec07(t *testing.T) {
	expected := 262086
	got := Exec07(loadOps(), []int{0,1,2,3,4})
	if got != expected {
		t.Errorf("Exec07() == %v, want %v", got, expected)
	}
}

func TestCalculateThrusterForSettings(t *testing.T) {
	cases := []struct{
		opcodes []int
		phaseSettings []int
		thruster int
	}{
		{
			[]int{3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0},
			[]int{4,3,2,1,0},
			43210,
		},
		{
			[]int{3,23,3,24,1002,24,10,24,1002,23,-1,23,101,5,23,23,1,24,23,23,4,23,99,0,0},
			[]int{0,1,2,3,4},
			54321,
		},
		{
			[]int{3,31,3,32,1002,32,10,32,1001,31,-2,31,1007,31,0,33,1002,33,7,33,1,33,31,31,1,32,31,31,4,31,99,0,0,0},
			[]int{1,0,4,3,2},
			65210,
		},
	}

	for _, c := range cases {
		got := calculateThrusterForSettings(c.opcodes, c.phaseSettings, 0)
		if got != c.thruster {
			t.Errorf("calculateThrusterForSettings(%v, %v) == %v, want %v", c.opcodes, c.phaseSettings, got, c.thruster)
		}
	}
}

func TestGetPermutations(t *testing.T) {
	cases := []struct{
		in []int
		want [][]int
	}{
		{[]int{1,2,3}, [][]int{
			{1,2,3},{1,3,2},{2,1,3},{2,3,1},{3,1,2},{3,2,1},
		}},
	}

	for _, c := range cases {
		got := getPermutations(c.in)
		if !reflect.DeepEqual(got, c.want) {
			t.Errorf("getPermutations(%v) == %v, want %v", c.in, got, c.want)
		}
	}
}

func loadOps() []int {
	file, err := os.Open("/Users/denisim/code/personal/go/src/github.com/marcodenisi/aoc2019/input/07.txt")
	check(err)
	defer file.Close()

	opcodes := []int{}
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		opStrings := strings.Split(scanner.Text(), ",")
		for _, opString := range opStrings {
			code, err := strconv.Atoi(opString)
			check(err)
			opcodes = append(opcodes, code)
		}
	}
	return opcodes
}