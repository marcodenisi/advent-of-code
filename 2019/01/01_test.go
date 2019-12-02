package aoc2019

import "testing"

func TestCalcFuelForFuel(t *testing.T) {
	cases := []struct {
		in, want int
	}{
		{14, 2},
		{1969, 966},
		{100756, 50346},
	} 

	for _, c := range cases {
		got := calcFuelForFuel(c.in)
		if got != c.want {
			t.Errorf("calcFuelForFuel(%q) == %q, want %q", c.in, got, c.want)
		}
	}
}