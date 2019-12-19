package aoc2019

import (
	"math"
)

func Exec08(digits []string, width, height int) int {

	layers := splitLayers(digits, width, height)

	zeroLayerIndex := findLayerWithFewerZeroes(layers)

	return calculateOneByTwoInLayer(layers[zeroLayerIndex])
}

func Exec08_2(digits []string, width, height int) string {
	layers := splitLayers(digits, width, height)

	result := overlapLayers(layers)

	s := ""
	for i := 0; i < len(result); i++ {
		if i > 0 && i % width == 0 {
			s += "\n"
		}

		if result[i] == "0" {
			s += " "
		} else {
			s += result[i]
		}
	}

	return s
}

func splitLayers(digits []string, width, height int) [][]string {
	layers := [][]string{}

	digitsInLayer := height * width
	for i := 0; i < len(digits)/digitsInLayer; i++ {
		layers = append(layers, []string{})
	}

	for i := 0; i < len(digits); i++ {
		layers[i/digitsInLayer] = append(layers[i/digitsInLayer], digits[i])
	}

	return layers
}

func findLayerWithFewerZeroes(layers [][]string) int {
	min := math.MaxInt64
	index := 0
	for i := 0; i < len(layers); i++ {
		zeroes := 0
		for j := 0; j < len(layers[i]); j++ {
			if layers[i][j] == "0" {
				zeroes++
			}
		}
		if min > zeroes {
			min = zeroes
			index = i
		}
	}
	return index
}

func calculateOneByTwoInLayer(layer []string) int {
	ones := 0
	twos := 0
	for i := 0; i < len(layer); i++ {
		switch layer[i] {
		case "1":
			ones++
		case "2":
			twos++
		}
	}
	return ones * twos
}

func overlapLayers(layers [][]string) []string {
	output := []string{}
	for i := 0; i < len(layers[0]); i++ {
		digit := "2"
		for j := 0; j < len(layers) && digit == "2"; j++ {
			digit = layers[j][i]
		}
		output = append(output, digit)
	}

	return output
}
