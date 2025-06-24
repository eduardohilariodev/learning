/* ------------------------------- HELLO WORLD ------------------------------ */
console.log("Hello World");

/* ---------------------------- GLOBAL NAMESPACE ---------------------------- */
console.log("global.luckyNumber - before assignment: ", global.luckyNumber);

global.luckyNumber = 7;

console.log("global.luckyNumber - after assignment: ", global.luckyNumber);

/* --------------------------------- PROCESS -------------------------------- */

console.log("NODE_ENV: ", process.env.NODE);
console.log("PLATFORM: ", process.platform);
console.log("USERNAME: ", process.env.USERNAME);

/* ------------------------------ PROCESS ARGS ------------------------------ */

console.log(process.argv);

/* ------------------------------ PROCESS ENV ------------------------------ */

console.log("");

/* -------------------------------------------------------------------------- */
/*                                   EVENTS                                   */
/* -------------------------------------------------------------------------- */
console.log("EVENTS: ");
console.log("on exit: ");
process.on("exit", () => {
  console.log("exit");
});

console.log("on uncaughtException: ");
process.on("uncaughtException", () => {
  console.log("uncaughtException");
});

/* ------------------------- CREATING CUSTOM EVENTS ------------------------- */
console.log("CREATING CUSTOM EVENTS: ");
const { EventEmitter } = require("events");
const eventEmitter = new EventEmitter();

eventEmitter.on("lunch", () => {
  console.log("yum yum");
});

eventEmitter.emit("lunch");

/* -------------------------------------------------------------------------- */
/*                                 FILE SYSTEM                                */
/* -------------------------------------------------------------------------- */

const { readFile, readFileSync } = require("fs");

const txt = readFileSync("./fs-test-file.txt", "utf8");

console.log("Read sync file from system:\n", txt);
console.log("This gets blocked by reading file");

readFile("./fs-test-file.txt", "utf8", (err, txt) => {
  console.log(txt);
});

console.log("\nRead non-blocking file from system");

/* -------------------------------------------------------------------------- */
/*                                  PROMISES                                  */
/* -------------------------------------------------------------------------- */

const { readFile: readFilePromise } = require("fs").promises;

async function hello(params) {
  const file = await readFilePromise("./fs-test-file.txt", "utf8");
  console.log("Read promise file from system:\n", file);
}

/* -------------------------------------------------------------------------- */
/*                                   MODULES                                  */
/* -------------------------------------------------------------------------- */
const myModule = require("./my-module");

console.log("Module: ", myModule);
