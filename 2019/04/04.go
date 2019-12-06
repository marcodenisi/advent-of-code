package aoc2019

import (
	"strconv"
)

func Exec04(start, end int) int {
	index := 0
	for i := start + 1; i < end; i++ {
		if result, _ := onlyIncreasingAndSameAdiacentDigits(strconv.Itoa(i)); result {
			index++
		}
	}

	return index
}

func Exec04_02(start, end int) int {
	index := 0
	for i := start + 1; i < end; i++ {
		if result, groupMap := onlyIncreasingAndSameAdiacentDigits(strconv.Itoa(i)); result && checkGroups(groupMap) {
			index++
		}
	}

	return index
}

func checkGroups(groups map[byte]int) bool {
	for _, val := range groups {
		if val == 1 {
			return true
		}
	}
	return false
}

func onlyIncreasingAndSameAdiacentDigits(number string) (bool, map[byte]int) {
	groupMap := make(map[byte]int)
	hasSameAdiacentDigits := false
	for i := 1; i < 6; i++ {
		if number[i] < number[i - 1] {
			return false, groupMap
		}

		if number[i] == number[i - 1] {
			hasSameAdiacentDigits = true
			groupMap[number[i]]++
		}

	}

	return hasSameAdiacentDigits, groupMap
}