package aoc2019

import (
	"testing"
	"reflect"
	"math"
)

func TestConvertActionToCommand(t *testing.T) {
	cases := []struct{
		in string
		want Command
	}{
		{"R100", Command{"R", 100}},
	}

	for _, c := range cases {
		got := convertActionToCommand(c.in)
		if !reflect.DeepEqual(got, c.want) {
			t.Errorf("convertActionToCommand(%v) == %v, want %v", c.in, got, c.want)
		}
	}
}

func TestCalculatePathForCommand(t *testing.T) {
	cases := []struct{
		start Point
		command Command
		want []Point
	}{
		{
			Point{0, 0},
			Command{"R", 4},
			[]Point{Point{1, 0},Point{2, 0},Point{3, 0},Point{4, 0}},
		},
		{
			Point{1, 8},
			Command{"L", 3},
			[]Point{Point{0, 8},Point{-1, 8},Point{-2, 8}},
		},
		{
			Point{1, 8},
			Command{"U", 3},
			[]Point{Point{1, 9},Point{1, 10},Point{1, 11}},
		},		
		{
			Point{1, 8},
			Command{"D", 3},
			[]Point{Point{1, 7},Point{1, 6},Point{1, 5}},
		},
	}

	for _, c := range cases {
		got := calculatePathForCommand(c.start, c.command)
		if !reflect.DeepEqual(got, c.want) {
			t.Errorf("calculatePathForCommand(%v, %v) == %v, want %v", c.start, c.command, got, c.want)
		}
	}
}

func TestCalculatePath(t *testing.T) {
	cases := []struct{
		in []string
		want []Point
	}{
		{
			[]string{"R3", "D1", "L2"},
			[]Point{Point{1,0}, Point{2,0}, Point{3,0}, Point{3,-1}, Point{2, -1}, Point{1, -1}},
		},
		{
			[]string{"U2", "R1", "D1"},
			[]Point{Point{0,1}, Point{0,2}, Point{1,2}, Point{1,1}},
		},
	}

	for _, c := range cases {
		got := calculatePath(c.in)
		if !reflect.DeepEqual(got, c.want) {
			t.Errorf("calculatePath(%v) == %v, want %v", c.in, got, c.want)
		}
	}
}

func TestGetIntersectionPoints(t *testing.T) {
	cases := []struct{
		path1 []Point
		path2 []Point
		want []Point
	}{
		{
			[]Point{},
			[]Point{},
			[]Point{},
		},
		{
			[]Point{Point{1,0}, Point{2,0}, Point{3,0}, Point{3,-1}, Point{2, -1}, Point{1, -1}},
			[]Point{Point{0,1}, Point{0,2}, Point{1,2}, Point{1,1}},
			[]Point{},
		},
		{
			[]Point{Point{1,0}, Point{2,0}, Point{3,0}, Point{3,-1}, Point{2, -1}, Point{1, -1}},
			[]Point{Point{0,1}, Point{0,2}, Point{1,2}, Point{1,1}, Point{1,0}, Point{2, -1}},
			[]Point{Point{1,0}, Point{2, -1}},
		},
	}

	for _, c := range cases {
		got := getIntersectionPoints(c.path1, c.path2)
		if !reflect.DeepEqual(got, c.want) {
			t.Errorf("getIntersectionPoints(%v, %v) == %v, want %v", c.path1, c.path2, got, c.want)
		}
	}
}

func TestCalculateMinManhattanDistance(t *testing.T) {
	cases := []struct{
		in []Point
		want float64
	}{
		{
			[]Point{},
			math.MaxFloat64,
		},
		{
			[]Point{Point{1,1}, Point{5,6}, Point{3,9}, Point{1,2}},
			2,
		},
	}

	for _, c := range cases {
		got := calculateMinManhattanDistance(c.in)
		if got != c.want {
			t.Errorf("calculateMinManhattanDistance(%v) == %v, want %v", c.in, got, c.want)
		}
	}
}

func TestCalculateFewerStepsToIntersections(t *testing.T) {
	cases := []struct{
		paths [][]Point
		intersections []Point
		want int
	}{
		{
			[][]Point{
				[]Point{Point{0,0},Point{1,0},Point{2,0}},
				[]Point{Point{3,0},Point{2,0},Point{1,0}},
			},
			[]Point{},
			math.MaxInt64,
		},
		{
			[][]Point{
				[]Point{Point{0,0},Point{1,0},Point{2,0}},
				[]Point{Point{3,0},Point{2,0},Point{1,0}},
			},
			[]Point{Point{2,0}},
			3,
		},
	}

	for _, c := range cases {
		got := calculateFewerStepsToIntersections(c.paths, c.intersections)
		if got != c.want {
			t.Errorf("CalculateFewerStepsToIntersections(%v, %v) == %v, want %v", c.paths, c.intersections, got, c.want)
		}
	}
}





