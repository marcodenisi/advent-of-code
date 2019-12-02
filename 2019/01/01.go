package aoc2019

import (
	"fmt"
	"bufio"
	"log"
	"os"
	"strconv"
)

func check(e error) {
	if e != nil {
		log.Fatal(e)
	}
}

func Exec01(filePath string) {
	file, err := os.Open(filePath)
	check(err)
	defer file.Close()

	scanner := bufio.NewScanner(file)
	fuel := 0
	for scanner.Scan() {
		mass, err := strconv.Atoi(scanner.Text())
		check(err)
		currentMassFuel := int(mass / 3) - 2
		currentMassFuel += calcFuelForFuel(currentMassFuel)
		fuel += currentMassFuel
	}

	fmt.Println("Result: ", fuel)

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}
}

func calcFuelForFuel(fuel int) int {
	if additionalFuel := fuel / 3 - 2; additionalFuel > 0 {
		return additionalFuel + calcFuelForFuel(additionalFuel)
	}
	return 0
}
