/* ---------------------------- GLOBAL NAMESPACE ---------------------------- */

// console.log(global.luckyNum);

// global.luckyNum = "42";

// console.debug(global.luckyNum);

/* --------------------------------- PROCESS -------------------------------- */

// console.debug(process.platform);

// console.debug(process.env.OS);

/* --------------------------------- EVENTS --------------------------------- */

// built-in
// process.on("exit", () => {
//   console.log("process exited");
// });

// custom

// // create event
// const { EventEmitter } = require("events");
// const eventEmitter = new EventEmitter();
// eventEmitter.on("lunch", () => {
//   console.debug("yum 🍣");
// });

// // call event
// eventEmitter.emit("lunch");

/* ------------------------------- FILE SYSTEM ------------------------------ */
// const { readFile, readFileSync } = require("fs");

// sync === blocking | everytime a sentence ends in sync think of blocking
// const txt = readFileSync("./hello.txt", "utf8");
// console.log(txt);
// console.log("do this ASAP");

// non-blocking callbacks
// readFile("./hello.txt", "utf8", (err, txt) => {
//   console.log(txt);
// });
// console.log("do this ASAP");

// promises

const { readFile } = require("fs").promises;

(async function hello() {
  const file = await readFile("./hello.txt", "utf8");
  console.debug("🚀 ~ file: index.js:53 ~ file:", file);
})();
