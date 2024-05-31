# Go and React Full Stack App – Go Tutorial for Node Developers

- [Go and React Full Stack App – Go Tutorial for Node Developers](#go-and-react-full-stack-app--go-tutorial-for-node-developers)
  - [Tech Stack](#tech-stack)
  - [Resources](#resources)
  - [About Go](#about-go)
    - [Package](#package)
    - [Modules used in the project](#modules-used-in-the-project)
    - [Memory](#memory)

## Tech Stack

| Use case      | Technology         |
| ------------- | ------------------ |
| Frontend      | React + TypeScript |
| Backend       | Go                 |
| Styling       | Chakra UI          |
| Database      | MongoDB            |
| Data fetching | TanStack Query     |
| Hosting       | Railway            |

## Resources

[Tutorial](https://www.youtube.com/watch?v=lNd7XlXwlho)

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

### Modules used in the project

- [Fiber](github.com/gofiber/fiber/v2)  
  This is a web server framework for Go.
- [Air](github.com/cosmtrek/air@latest)  
  This is a live reload tool for Go.
- [Dotenv](github.com/joho/godotenv)  
  This is a Go port of the Ruby dotenv library.

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
