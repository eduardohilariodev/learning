const express = require("express");
const { readFile } = require("fs");
const app = express();

app.get("/", (request, response) => {
  console.log("Request from:", request.ip);
  console.log("User Agent:", request.get("User-Agent"));
  console.log("Request Method:", request.method);
  console.log("Request URL:", request.url);

  readFile("./index.html", "utf8", (err, data) => {
    if (err) {
      response.status(500).send("Error reading file");
    } else {
      response.send(data);
    }
  });
});

app.get("/async", async (request, response) => {
  response.send(await readFile("./index.html", "utf8"));
});

app.listen(3000, () => {
  console.log("Server is running on port 3000");
});
