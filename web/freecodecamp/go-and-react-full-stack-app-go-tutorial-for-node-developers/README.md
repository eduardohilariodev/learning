# Go and React Full Stack App – Go Tutorial for Node Developers

- [Go and React Full Stack App – Go Tutorial for Node Developers](#go-and-react-full-stack-app--go-tutorial-for-node-developers)
  - [Tech Stack](#tech-stack)
  - [Resources](#resources)
  - [About Go](#about-go)
    - [Package](#package)

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
