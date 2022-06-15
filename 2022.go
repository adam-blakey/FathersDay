package main

import "fmt"

type child struct {
	name   string
	height float32
}

func main() {
	lauren := child { name: "Lauren", height: 165 }
	ben    := child { name: "Ben",    height: 180 }
	adam   := child { name: "Adam",   height: ben.height + 1 }

	tallest_child := findTallest(lauren, ben, adam)

    fmt.Println(fmt.Sprintf("%v is the tallest.", tallest_child.name))
}

func findTallest(children ...child) child {
	tallest := children[0]
	for i := 1; i < len(children); i++ {
		if children[i].height > tallest.height {
			tallest = children[i]
		}
	}

	return tallest
}

