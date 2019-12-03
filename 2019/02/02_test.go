package aoc2019

import (
	"testing"
	"reflect"
)

func TestIntCodeProgram(t *testing.T) {
	cases := []struct {
		in []int
		want []int
	}{
		{[]int{1,0,0,0,99}, []int{2,0,0,0,99}},
		{[]int{2,3,0,3,99}, []int{2,3,0,6,99}},
		{[]int{2,4,4,5,99,0}, []int{2,4,4,5,99,9801}},
		{[]int{1,1,1,4,99,5,6,0,99}, []int{30,1,1,4,2,5,6,0,99}},
	} 

	for _, c := range cases {
		got := intCodeProgram(c.in)
		if !reflect.DeepEqual(got, c.want) {
			t.Errorf("IntCodeProgram(%v) == %v, want %v", c.in, got, c.want)
		}
	}
}