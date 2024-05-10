const bodyParser = require("body-parser");
const express = require("express");

const app = express();
app.use(bodyParser.urlencoded({ extended: true }));

app.get("/", function (req, res) {
  res.sendFile(__dirname + "/index.html");
});

app.post("/", function (req, res) {
  const num1 = Number(req.body.num1);
  const num2 = Number(req.body.num2);
  const result = num1 + num2;

  res.send(`The result is ${result.toFixed(1)}`);
});

app.get("/bmi-calculator", function (req, res) {
  res.sendFile(__dirname + "/bmi-calculator.html");
});

app.post("/bmi-calculator", function (req, res) {
  const weight = req.body.weight;
  const height = req.body.height;
  const bmi = weight / Math.pow(height, 2);

  res.send(`Your BMI is ${bmi.toFixed(1)}`);
});

app.listen(3000, function () {
  console.log("Server started at 3000");
});
