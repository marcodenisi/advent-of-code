package aoc2019

import (
	"os"
	"encoding/csv"
	"io"
	"strconv"
	"log"
	"math"
)

type Command struct {
	direction string
	steps int
}

type Point struct {
	x int
	y int
}

func Exec03(filePath string) (float64, int) {
	wires := loadWires(filePath)

	paths := [][]Point{}
	for _, wire := range wires {
		paths = append(paths, calculatePath(wire))
	}

	intersections := getIntersectionPoints(paths[0], paths[1])

	return calculateMinManhattanDistance(intersections), calculateFewerStepsToIntersections(paths, intersections)
}

func loadWires(filePath string) [][]string {
	file, err := os.Open(filePath)
	check(err)
	defer file.Close()

	reader := csv.NewReader(file)

	var rows [][]string
	for {
		row, err := reader.Read()
		if err == io.EOF {
			break
		}
		check(err)

		rows = append(rows, row)	
	}

	return rows
}

func convertActionToCommand(action string) Command {
	steps, err := strconv.Atoi(action[1:])
	check(err)
	return Command{
		direction: action[:1],
		steps: steps,
	}
}

func calculatePathForCommand(start Point, command Command) []Point {
	points := []Point{}
	switch command.direction {
		case "R":
			for i := start.x + 1; i <= start.x + command.steps; i++ {
				points = append(points, Point{i, start.y})
			}	
		case "L":
			for i := start.x - 1; i >= start.x - command.steps; i-- {
				points = append(points, Point{i, start.y})
			}
		case "U":
			for i := start.y + 1; i <= start.y + command.steps; i++ {
				points = append(points, Point{start.x, i})
			}
		case "D":
			for i := start.y - 1; i >= start.y - command.steps; i-- {
				points = append(points, Point{start.x, i})
			}
		default: 
			log.Fatalf("Unrecognized direction: %v", command.direction)
	}
	return points
}

func calculatePath(wire []string) []Point{
	pathForWire := []Point{}
	start := Point{0, 0}
	for _, action := range wire {
		command := convertActionToCommand(action)
		pathForWire = append(pathForWire, calculatePathForCommand(start, command)...)
		start = pathForWire[len(pathForWire) - 1]
	}
	return pathForWire
}

func getIntersectionPoints(path1, path2 []Point) []Point {
	intersectionPoints := []Point{}

	pointMap := make(map[Point]Point)
	for _, point := range path1 {
		pointMap[point] = point
	}

	for _, point := range path2 {
		if _, ok := pointMap[point]; ok {
			intersectionPoints = append(intersectionPoints, point)
		}
	}

	return intersectionPoints
}

func calculateMinManhattanDistance(points []Point) float64 {
	min := float64(math.MaxFloat64)
	for _, point := range points {
		distance := math.Abs(float64(point.x)) + math.Abs(float64(point.y))
		if distance < min {
			min = distance
		}
	}
	return min
}

func calculateFewerStepsToIntersections(paths [][]Point, intersections []Point) int {
	map1 := make(map[Point]int)
	for idx, p := range paths[0] {
		map1[p] = idx
	}

	map2 := make(map[Point]int)
	for idx, p := range paths[1] {
		map2[p] = idx
	}

	min := math.MaxInt64
	for _, p := range intersections {
		if current := map1[p] + map2[p]; current < min {
			min = current
		}
	}

	return min
}














