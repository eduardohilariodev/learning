const promise = fetch("https://jsonplaceholder.typicode.com/posts/1");

promise
  .then((res) => res.json())
  .then((user) => {
    throw new Error("🤡");
  })
  .then((user) => console.log("😛", user.title))
  .catch((err) => console.error("😭", err));

console.log("🥪 Synchronous");
