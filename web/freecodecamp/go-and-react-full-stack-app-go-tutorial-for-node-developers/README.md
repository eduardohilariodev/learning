# Go and React Full Stack App – Go Tutorial for Node Developers

- [Go and React Full Stack App – Go Tutorial for Node Developers](#go-and-react-full-stack-app--go-tutorial-for-node-developers)
  - [Resources](#resources)
  - [Tech Stack](#tech-stack)
  - [Roadmap](#roadmap)
  - [Modules](#modules)
  - [About Go](#about-go)
    - [Package](#package)
    - [Memory](#memory)

## Resources

[Tutorial](https://www.youtube.com/watch?v=lNd7XlXwlho)

## Tech Stack

| Use case      | Technology         |
| ------------- | ------------------ |
| Frontend      | React + TypeScript |
| Backend       | Go                 |
| Styling       | Chakra UI          |
| Database      | MongoDB            |
| Data fetching | TanStack Query     |
| Hosting       | Railway            |

## Roadmap

1. Implement a simple Go server, that first saves data to memory. This configures Fiber, Air, Dotenv and 5 CRUD routes.
2. Implement a MongoDB database and connect it to the Go server. This configures a cluster, installs the Go MongoDB driver.

## Modules

- [Fiber](github.com/gofiber/fiber/v2)  
  This is a web server framework for Go.
- [Air](github.com/cosmtrek/air@latest)  
  This is a live reload tool for Go.
- [Dotenv](github.com/joho/godotenv)  
  This is a Go port of the Ruby dotenv library.
- [MongoDB Go Driver](go.mongodb.org/mongo-driver/mongo)  
  This is the official Go driver for MongoDB.

## About Go

### Package

A package is a collection of Go source files that reside in the same directory
and have the same package declaration at the top.

Packages collectively form a **module**.

```plaintext
module
│
├─cmd   <- package
│   main.go
│
├─handlers   <- package
│   handler.go
│
└─api   <- package
    api.go
```

### Memory

```go
 var foo int = 5
 var bar *int = &foo
```

| **Address** | **Value** | **Variable** |
| ----------- | --------- | ------------ |
| 0x1000      | 5         | foo          |
| 0x1004      | 0x1000    | bar          |
| 0x1008      |           |              |
| 0x1012      |           |              |
