package main

import (
	"context"
	"fmt"
	"log"
	"os"

	"github.com/gofiber/fiber/v2"
	"github.com/joho/godotenv"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

type Todo struct {
	// MongoDB uses Binary JSON (bson) to store data, this is why it's been double
	// declared on this struct.
	//
	// Why is the `omitempty` option used on the Todo struct tag?
	//
	// To omit empty values such as
	// {
	//	 "id": "000000000000000000000000",
	//   "completed": false,
	//   "body": "Learn Go"
	// }
	ID        primitive.ObjectID `json:"id,omitempty" bson:"_id,omitempty"`
	Completed bool               `json:"completed"`
	Body      string             `json:"body"`
}

var collection *mongo.Collection

func main() {
	fmt.Println()

	err := godotenv.Load(".env")
	if err != nil {
		log.Fatal("Error loading .env file")
	}

	MONGODB_URI := os.Getenv("MONGODB_URI")

	// Connect to MongoDB
	clientOptions := options.Client().ApplyURI(MONGODB_URI)

	// `context.Background()` is used when you want to have some cancellations,
	// some timeouts.
	//
	// In our case it goes something like "I'm starting this task, but I don't
	// have any special requirements or deadlines attached to it"
	client, err := mongo.Connect(context.Background(), clientOptions)

	if err != nil {
		log.Fatal(err)
	}

	defer client.Disconnect(context.Background())

	err = client.Ping(context.Background(), nil)

	if err != nil {
		log.Fatal(err)
	}

	fmt.Println("Connected to MongoDB Atlas")

	collection = client.Database("golang_db").Collection("todos")

	app := fiber.New()

	app.Get("/api/todos", listTodos)
	app.Post("/api/todos", createTodo)
	// app.Patch("/api/todos/:id", updateTodos)
	// app.Delete("/api/todos/:id", deleteTodos)

	port := os.Getenv("PORT")

	if port == "" {
		port = "4000"
	}

	log.Fatal(app.Listen("0.0.0.0:" + port))

}

func listTodos(c *fiber.Ctx) error {
	var todos []Todo

	// `bson.M{}` is because we're trying to pass filters, in our case, null
	// filters. This is to fetch all todos.
	//
	// In the case to pass filters, they'd go into the `{}` object.
	//
	// So this fetches all documents in this collection.
	//
	// The `cursor` is what's returned from a MongoDB query, essentially a pointer
	// to the result set. We can use this cursor to iterate over the documents
	// returned by the query.
	cursor, err := collection.Find(context.Background(), bson.M{})

	if err != nil {
		return err
	}

	// `defer` postpones the execution of a function call until the surrounding
	// function completes.
	//
	// In this case `listTodos` is the surrounding function.
	//
	// When the call to list the todos is finished, the connection to the MongoDB
	// database is closed.
	defer cursor.Close(context.Background())

	for cursor.Next(context.Background()) {
		var todo Todo
		if err := cursor.Decode(&todo); err != nil {
			return err

		}
		todos = append(todos, todo)
	}
	// c stands for Fiber context
	return c.JSON(todos)
}

func createTodo(c *fiber.Ctx) error {
	todo := new(Todo)

	// What does `BodyParser` do?
	//
	// It binds the body of the request to the `todo` struct
	if err := c.BodyParser(todo); err != nil {
		return err
	}

	if todo.Body == "" {
		return c.Status(400).JSON(fiber.Map{"error": "Todo body cannot be empty"})
	}

	insertResult, err := collection.InsertOne(context.Background(), todo)

	if err != nil {
		return err
	}

	todo.ID = insertResult.InsertedID.(primitive.ObjectID)

	// What does the status 201 means?
	//
	// A resource has been created.
	return c.Status(201).JSON(todo)
}
