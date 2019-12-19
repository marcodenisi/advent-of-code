package aoc2019

import (
	"bufio"
	"fmt"
	"os"
	"reflect"
	"strings"
	"testing"
)

func loadImages() []string {
	file, err := os.Open("/Users/denisim/code/personal/go/src/github.com/marcodenisi/aoc2019/input/08.txt")
	check(err)
	defer file.Close()

	var digits []string
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		digits = strings.Split(scanner.Text(),"")
	}

	return digits
}

func TestSplitLayers(t *testing.T) {
	cases := []struct{
		digits []string
		width int
		height int
		want [][]string
	}{
		{[]string{"1","2","3","0"}, 2, 1,
			[][]string{{"1", "2"},{"3", "0"}}},
	}

	for _, c := range cases {
		got := splitLayers(c.digits, c.width, c.height)
		if !reflect.DeepEqual(got, c.want) {
			t.Errorf("splitLayers(%v, %v, %v) == %v, want %v", c.digits, c.width, c.height, got, c.want)
		}
	}
}

func TestFindLayerWithFewerZeroes(t *testing.T) {
	cases := []struct{
		layers [][]string
		index int
	}{
		{[][]string{{"1", "2"},{"3", "0"}}, 0},
		{[][]string{{"1", "2"},{"3", "0"}, {"0", "0"}, {"1", "2"}}, 0},
	}

	for _, c := range cases {
		got := findLayerWithFewerZeroes(c.layers)
		if got != c.index {
			t.Errorf("findLayerWithFewerZeroes(%v) == %v, want %v", c.layers, got, c.index)
		}
	}
}

func TestCalculateOneByTwoInLayer(t *testing.T) {
	cases := []struct{
		layer []string
		result int
	}{
		{[]string{"1", "2"}, 1},
		{[]string{"1", "2", "2", "2"}, 3},
	}

	for _, c := range cases {
		got := calculateOneByTwoInLayer(c.layer)
		if got != c.result {
			t.Errorf("calculateOneByTwoInLayer(%v) == %v, want %v", c.layer, got, c.result)
		}
	}
}

func TestOverlapLayers(t *testing.T) {
	cases := []struct{
		layers [][]string
		output []string
	}{
		{[][]string{{"1", "2"},{"2", "0"}}, []string{"1", "0"}},
		{[][]string{{"2", "2"},{"2", "0"}, {"0", "0"}, {"1", "2"}}, []string{"0", "0"}},
	}

	for _, c := range cases {
		got := overlapLayers(c.layers)
		if !reflect.DeepEqual(got, c.output) {
			t.Errorf("overlapLayers(%v) == %v, want %v", c.layers, got, c.output)
		}
	}
}

func TestExec08(t *testing.T) {
	fmt.Println(Exec08(loadImages(), 25, 6))
}

func TestExec08_2(t *testing.T) {
	fmt.Println(Exec08_2(loadImages(), 25, 6))
}