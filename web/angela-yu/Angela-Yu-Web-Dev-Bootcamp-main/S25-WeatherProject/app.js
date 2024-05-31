const express = require("express");
const https = require("https");
const bodyParser = require("body-parser");

const app = express();

app.use(bodyParser.urlencoded({ extended: true }));

app.listen(3000, () => {
  console.log("Server is running on port 3000");
});

app.get("/", (req, res) => {
  res.sendFile(__dirname + "/index.html");
});

app.post("/", (req, res) => {
  const apiKey = "fc4e9895568c21ec0b2e7821c843d9d9";
  const city = req.body.cityName;
  const units = "metric";
  const url = `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${apiKey}&units=${units}`;

  https
    .get(url, (response) => {
      console.log("headers", response.headers);
      console.log("statusCode", response.statusCode);

      response.on("data", (data) => {
        const weatherData = JSON.parse(data);
        const icon = weatherData.weather[0].icon;
        const temp = weatherData.main.temp;
        const weatherDescription = weatherData.weather[0].description;

        res.setHeader("Content-Type", "text/html"); // Set the content type to 'text/html'

        res.write(
          `<h3><img height="40" width="40" src="http://openweathermap.org/img/wn/${icon}@2x.png"/> ${weatherDescription}</h3>`
        );
        res.write(`<h1>The temperature in ${city} is ${temp} &ordm;C</h1>`);
        res.send();
      });
    })
    .on("error", (error) => {
      console.error(error);
    });
});
