// const hobbies = ["Foo", "Bar"];
// hobbies.push("Foobar");
// hobbies.unshift("Coding");
// const poppedValue = hobbies.pop();
// hobbies.shift();
// console.debug(hobbies);

// const testResults = [1, 5.3, 1.5, 10.99, -5, 1.5, 10];

// const storedResults = testResults.concat([3.99, 2]);

// testResults.push(5.91);

// console.debug(storedResults, testResults);
// console.debug(testResults.lastIndexOf(1.5));

// const personData = [{ name: "Max" }, { name: "Manuel" }];
// console.debug(personData.indexOf({ name: "Manuel" }));

// console.debug(testResults.includes(10.99));
// console.debug(testResults.indexOf(10.99) !== -1);

// const manuel = personData.find((person, index, persons) => {
//   return person.name === "Manuel";
// });

// manuel.name = "Anna";

// console.debug(manuel, personData);

// const foo = null;

// const maxIndex = personData.findIndex((person) => {
//   return person.name === "Max";
// });

// console.debug(maxIndex);

// const prices = [10.99, 5.99, 3.99, 6.59];

// const tax = 0.19;

// const taxAdjustedPrices = [];

// // for (const price of prices) {
// //   taxAdjustedPrices.push(price * (1 + tax));
// // }

// prices.forEach((price, index, prices) => {
//   const priceObj = { index, taxAdjustedPrices: price * (1 + tax) };
//   taxAdjustedPrices.push(priceObj);
// });

// console.debug(taxAdjustedPrices);

// const prices = [10.99, 5.99, 3.99, 6.59];
// const tax = 0.19;

// const taxAdjustedPrices = prices.map((price, index, prices) => {
//   const priceObj = { index, taxAdjustedPrices: price * (1 + tax) };
//   return priceObj;
// });

// console.debug(taxAdjustedPrices);

// const sortedPrices = prices.sort((a, b) => {
//   if (a > b) {
//     return 1;
//   } else if (a === b) {
//     return 0;
//   } else {
//     return -1;
//   }
// });
// console.debug(sortedPrices.reverse());

// const filteredArray = prices.filter((price) => price > 6);

// let sum = 0;

// prices.forEach((price) => {
//   sum += price;
// });

// console.debug(sum);

// const sum = prices.reduce((prevValue, curValue, curIndex, prices) => {
//   return prevValue + curValue;
// }, 0);

// console.debug(sum);

// const data = "new york;10.99;2000";

// const transformedData = data.split(";");

// console.debug(transformedData);

// const nameFragments = ["Eduardo", "Hilário"];
// const name = nameFragments.join(" ");
// console.debug(name);

// const copiedNameFragments = [...nameFragments];
// nameFragments.push("Mr.");
// console.debug(nameFragments, copiedNameFragments);

// console.debug(Math.min(...prices));

// const persons = [
//   { name: "Max", age: 30 },
//   { name: "Manuel", age: 31 },
// ];
// const copiedPersons = persons.map((person) => ({
//   name: person.name,
//   age: person.age,
// }));
// persons.push({ name: "Anna", age: 29 });

// persons[0].age = 31;

// console.debug(persons, copiedPersons);

// const nameData = ["Eduardo", "Hilario", "Mr", 30];

// const [firstName, lastName, ...otherInfo] = nameData;

// console.debug(firstName, lastName, otherInfo);
