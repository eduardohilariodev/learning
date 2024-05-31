package main

import (
	"fmt"
	"log"
	"os"

	"github.com/gofiber/fiber/v2"
	"github.com/joho/godotenv"
)

type Todo struct {
	Id        int    `json:"id"`
	Completed bool   `json:"completed"`
	Body      string `json:"body"`
}

func api() {
	fmt.Println("Hello world")

	app := fiber.New()

	err := godotenv.Load(".env")
	if err != nil {
		log.Fatal("Error loading .env file")
	}
	PORT := os.Getenv("PORT")

	todos := []Todo{}

	/* ------------------------------------------------------------------------- */
	/*                                   ROUTES                                  */
	/* ------------------------------------------------------------------------- */

	/* ------------------------------- LIST TODOS ------------------------------ */
	// {c *fiber.Ctx} will be a pointer to the Fiber package context
	app.Get("/api/todos", func(c *fiber.Ctx) error {
		return c.Status(200).JSON(todos)
	})

	/* ----------------------------- CREATE A TODO ----------------------------- */
	app.Post("/api/todos", func(c *fiber.Ctx) error {
		// Initialized as {id: 0, completed: false, body: ""}
		// Here we get the memory address of the Todo (using the ampersand)
		todo := &Todo{}

		if err := c.BodyParser(todo); err != nil {
			return err
		}

		// If body is empty return an error
		if todo.Body == "" {
			return c.Status(400).JSON(fiber.Map{"error": "Todo body is required"})
		}

		// Increment the ID by 1
		todo.Id = len(todos) + 1

		// todos appends the just created todo to the array
		// The asterisc is the pointer to the value of the memory reference
		todos = append(todos, *todo)

		// 201 means that a resource has been created
		return c.Status(201).JSON(todo)
	})

	/* ----------------------------- UPDATE A TODO ----------------------------- */
	// Turn a given Todo by {id} into true
	app.Patch("/api/todos/:id", func(c *fiber.Ctx) error {
		id := c.Params("id")

		// Go doesn't have `while` loops
		for i, todo := range todos {
			if fmt.Sprint(todo.Id) == id {
				todos[i].Completed = true
				return c.Status(200).JSON(todos[i])
			}
		}

		return c.Status(404).JSON(fiber.Map{"error": "Todo not found"})
	})

	/* ----------------------------- DELETE A TODO ----------------------------- */
	app.Delete("/api/todos/:id", func(c *fiber.Ctx) error {
		id := c.Params("id")

		for i, todo := range todos {
			if fmt.Sprint(todo.Id) == id {
				// Append into the `todos` up until this `index` that we're trying to
				// delete, but not including it.
				//
				// The ellipsis (...) in Go is called `variadic operator` (much like the
				// spread operator in JS)
				todos = append(todos[:i], todos[i+1:]...)
				return c.Status(200).JSON(fiber.Map{"success": true})
			}
		}

		return c.Status(404).JSON(fiber.Map{"error": "Todo not found"})
	})

	log.Fatal(app.Listen(":" + PORT))
}
