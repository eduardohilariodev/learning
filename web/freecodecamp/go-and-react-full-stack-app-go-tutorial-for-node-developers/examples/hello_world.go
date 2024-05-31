package main

import "fmt"

func hello_world() {
	fmt.Println("Hello world")

	// Variable declaration
	var myName string = "John Doe"

	// Constant declarion
	const mySecondName string = "Jane Doe"

	// Inferred var type declaration
	myThirdName := "Bob Doe"

	fmt.Println(myName)
	fmt.Println(mySecondName)
	fmt.Println(myThirdName)
}
