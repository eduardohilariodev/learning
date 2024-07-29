// const ids = new Set(["Hi", "from", "set!"]);

// ids.add(2);

// ids.delete("Hi1");

// console.debug("🚀 ~ file: setsmaps.js:2 ~ ids:", ids);

// for (const entry of ids.values()) {
//   console.debug(entry);
// }

const person1 = { name: "Eduardo" };
const person2 = { name: "Hilario" };

const personData = new Map([[person1, [{ date: "yesterday", price: 10 }]]]);

personData.set(person2, [{ data: "2 weeks ago", price: 20 }]);

console.debug(personData);

console.debug(personData.get(person1));

for (const [key, value] of personData.entries()) {
  console.debug(key, value);
}

for (const key of personData.keys()) {
  console.debug(key);
}
for (const value of personData.values()) {
  console.debug(value);
}
