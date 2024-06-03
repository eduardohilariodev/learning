const sum = (a, b) => {
  return a + b;
};
const throwsErrorFn = (number) => {
  if (typeof number !== "number") {
    throw new Error("Param is not of type `number`");
  }
};

module.exports = { throwsErrorFn, sum };
