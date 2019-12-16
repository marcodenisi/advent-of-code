package aoc2019

import (
	"strings"
)

func Exec06(orbits []string) int {

	orbitMap := createOrbitMap(orbits)

	connections := 0
	for key := range orbitMap {
		connections += navigateMapToOrigin(orbitMap, key)
	}

	return connections
}

func Exec06_2(orbits []string) int {
	orbitMap := createOrbitMap(orbits)

	santaPath := getPathToOrigin(orbitMap, "SAN")
	yourPath := getPathToOrigin(orbitMap, "YOU")

	for yourIndex, yourNode := range yourPath {
		for santaIndex, santaNode := range santaPath {
			if yourNode == santaNode {
				return yourIndex + santaIndex
			}
		}
	}

	return 0
}

func getPathToOrigin(orbitMap map[string]string, currentNode string) []string {
	path := []string{}
	for {
		currentNode = orbitMap[currentNode]
		if currentNode == "COM" {
			return append(path, "COM")
		}
		path = append(path, currentNode)
	}
}

func navigateMapToOrigin(orbitMap map[string]string, startingNode string) int {
	if orbitMap[startingNode] == "COM" {
		return 1
	}
	return 1 + navigateMapToOrigin(orbitMap, orbitMap[startingNode])
}

func createOrbitMap(orbits []string) map[string]string {
	orbitMap := make(map[string]string)
	for _, orbit := range orbits {
		points := strings.Split(orbit, ")")
		orbitMap[points[1]] = points[0]
	}
	return orbitMap
}
