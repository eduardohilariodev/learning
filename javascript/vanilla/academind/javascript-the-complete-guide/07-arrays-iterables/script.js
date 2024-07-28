// const hobbies = ["Foo", "Bar"];
// hobbies.push("Foobar");
// hobbies.unshift("Coding");
// const poppedValue = hobbies.pop();
// hobbies.shift();
// console.debug(hobbies);

const testResults = [1, 5.3, 1.5, 10.99, -5, 10];

const storedResults = testResults.slice(2);

testResults.push(5.91);

console.debug(storedResults, testResults);
