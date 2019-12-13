package aoc2019

import (
	"testing"
	"reflect"
	//"fmt"
)

func TestExec05(t *testing.T) {

	cases := []struct{
		in []int
		input int
		want int
	}{
		{[]int{3,9,8,9,10,9,4,9,99,-1,8},8,1},
		{[]int{3,9,8,9,10,9,4,9,99,-1,8},9,0},
		{[]int{3,9,7,9,10,9,4,9,99,-1,8},4,1},
		{[]int{3,9,7,9,10,9,4,9,99,-1,8},9,0},
		{[]int{3,3,1108,-1,8,3,4,3,99},8,1},
		{[]int{3,3,1108,-1,8,3,4,3,99},9,0},
		{[]int{3,3,1107,-1,8,3,4,3,99},4,1},
		{[]int{3,3,1107,-1,8,3,4,3,99},9,0},
		{[]int{3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9},0,0},
		{[]int{3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9},1,1},
		{[]int{3,3,1105,-1,9,1101,0,0,12,4,12,99,1}, 0, 0},
		{[]int{3,3,1105,-1,9,1101,0,0,12,4,12,99,1}, 1, 1},
	}

	for _, c := range cases {
		got := Exec05(c.in, c.input)
		if len(got) != 1 || got[0] != c.want {
			t.Errorf("Exec05(%v, %v) == %v, want [%v]", c.in, c.input, got, c.want)
		}
	}

}

func TestGetIndexIncrementForOpcode(t *testing.T) {
	cases := []struct{
		opcode int
		want int
	}{
		{1, 4},
		{2, 4},
		{3, 2},
		{4, 2},
		{99, 0},
	}

	for _, c := range cases {
		got := getIndexIncrementForOpcode(c.opcode)
		if got != c.want {
			t.Errorf("getIndexIncrementForOpcode(%v) == %v, want %v", c.opcode, got, c.want)
		}
	}
}

func TestParseCommand(t *testing.T) {
	cases := []struct{
		command int
		want Intcode
	}{
		{1, Intcode{opcode:1, indexIncrement: 4}},
		{2, Intcode{opcode:2, indexIncrement: 4}},
		{3, Intcode{opcode:3, indexIncrement: 2}},
		{4, Intcode{opcode:4, indexIncrement: 2}},
		{1001, Intcode{opcode:1, indexIncrement: 4, firstParamMode: 0, secondParamMode: 1, thirdParamMode: 0}},
		{1101, Intcode{opcode:1, indexIncrement: 4, firstParamMode: 1, secondParamMode: 1, thirdParamMode: 0}},
		{11004, Intcode{opcode:4, indexIncrement: 2, firstParamMode: 0, secondParamMode: 1, thirdParamMode: 1}},
	}

	for _, c := range cases {
		got := parseCommand(c.command)
		if !reflect.DeepEqual(got, c.want) {
			t.Errorf("parseCommand(%v) == %v, want %v", c.command, got, c.want)
		}
	}
}