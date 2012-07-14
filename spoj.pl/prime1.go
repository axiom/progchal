package main

import (
	"fmt"
)

func primesBetween(lower, upper uint64) []uint64 {
	cStart := 0
	candidates := make([]uint64, 0, upper / 2)

	for c := uint64(2); c <= upper; c++ {
		prime := true

		for _, p := range candidates {
			if c % p == 0 {
				prime = false
				break
			}

			if p * p > c {
				break
			}
		}

		if prime {
			candidates = append(candidates, c)

			if c < lower {
				cStart++
			}
		}
	}

	return candidates[cStart:]
}

// Read number of test cases as the first line then each test case seperated
// by one blank line. Each line in a test case have two fields, which is a
// lower and upper bound. The task is to generate all the prime numbers inside
// the bound.
func main() {
	var nTests uint64
	fmt.Scanf("%d", &nTests)

	for ; nTests > 0; nTests-- {
		var lower, upper uint64
		if nScanned, _ := fmt.Scanf("%d %d", &lower, &upper); 2 != nScanned {
			panic("Could not read proper test case")
		}

		for _, prime := range primesBetween(lower, upper) {
			fmt.Println(prime)
		}
	}
}
