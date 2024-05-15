const sayHello = (name) => console.log("Hi " + name);

// With two arguments (incl. a phrase that replaces "Hi")
//   Add a default argument to the function you created: A fallback value for
//   the phrase if no value is provided.
const sayPhrase = (phrase = "Hi ", name) => console.log(phrase + name);
// with no arguments (hard-coded values in function body)
const sayHardcoded = () => console.log("Hi " + "Eduardo");
// with one returned value (instead of outputting text inside of the function
// directly)
const sayDirect = (phrase, name) => phrase + name;

const checkInput = (callback, ...args) => {
  let hasEmptyText = false;
  for (const text of args) {
    if (!text) {
      hasEmptyText = true;
      break;
    }
  }
  if (!hasEmptyText) {
    callback();
  }
};
checkInput(
  () => {
    console.log("All not empty");
  },
  "Hello",
  "",
  "from",
  "mars"
);

// X  Re-write the function you find in assignment.js as an arrow function.

//   Adjust the arrow function you created as part of task 1 to use three
//   different syntaxes: With two arguments (incl. a phrase that replaces "Hi"),
//   with no arguments (hard-coded values in function body) and with one
//   returned value (instead of outputting text inside of the function
//   directly).

//   Add a new function: "checkInput" which takes an unlimited amount of
//   arguments (unlimited amount of strings) and executes a callback function if
//   NO argument/ string is an empty string.
