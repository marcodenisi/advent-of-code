package aoc2019

import (
	"testing"
	"fmt"
)

func TestOnlyIncreasingAndSameAdiacentDigits(t *testing.T) {
	cases := []struct{
		in string
		want bool
		groupLen int
	}{
		{"123456", false, 0},
		{"111111", true, 1},
		{"223450", false, 1},
		{"123789", false, 0},
		{"122345", true, 1},
		{"111123", true, 1},
		{"111122", true, 2},
		{"112233", true, 3},
	}

	for _, c := range cases {
		got, group := onlyIncreasingAndSameAdiacentDigits(c.in)
		if got != c.want || len(group) != c.groupLen {
			t.Errorf("onlyIncreasingAndSameAdiacentDigits(%v) == (%v, %v), want (%v, %v)", c.in, got, len(group), c.want, c.groupLen)
		}
	}
}

func TestExec04(t *testing.T) {
	fmt.Println(Exec04(272091, 815432))
}

func TestExec04_02(t *testing.T) {
	fmt.Println(Exec04_02(272091, 815432))
}