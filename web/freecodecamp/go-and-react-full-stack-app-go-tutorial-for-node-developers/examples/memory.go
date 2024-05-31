package main

import "fmt"

func main() {

	// The variable foo is, for example, stored on the address 0x00001
	var foo int = 5

	// The asterisc means that `bar` is an int pointer
	// The ampersand creates a reference to the memory address of `foo`
	// The value of `bar` then becomes the memory addres of `foo` (0x00001)
	var bar *int = &foo

	fmt.Println("Memory address:", bar)
	fmt.Println("Value:", *bar)

}
