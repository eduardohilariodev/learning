package main

import (
	"fmt"
	"log"

	"github.com/gofiber/fiber/v2"
)

type Todo struct {
	ID        int    `json:"id"`
	Completed bool   `json:"completed"`
	Body      string `json:"body"`
}

func main() {
	fmt.Println("Hello world")

	app := fiber.New()

	todos := []Todo{}

	// Routes
	app.Get("/", func(c *fiber.Ctx) error {
		return c.Status(200).JSON(fiber.Map{"msg": "hello world"})
	})

	app.Post("/api/todos", func(c *fiber.Ctx) error {
		todo := &Todo{} // Initialized as {id: 0, completed: false, body: ""}

		if err := c.BodyParser(todo); err != nil {
			return err
		}

		// If body is empty return an error
		if todo.Body == "" {
			return c.Status(400).JSON(fiber.Map{"error": "Todo body is required"})
		}

		// Increment the ID by 1
		todo.ID = len(todos) + 1

		// Append the just created todo to the array
		// The asterisc is the pointer to the value of the memory reference
		todos = append(todos, *todo)

		// 201 means that a resource has been created
		return c.Status(201).JSON(todo)
	})

	log.Fatal(app.Listen(":4000"))
}
