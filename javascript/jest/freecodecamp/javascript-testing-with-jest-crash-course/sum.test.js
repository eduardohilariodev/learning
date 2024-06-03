const { sum, throwsErrorFn } = require(".");

/* -------------------------------------------------------------------------- */
/*                                  MATCHERS                                  */
/* -------------------------------------------------------------------------- */

/* --------------------------------- TOBE() --------------------------------- */
test("should return three when one sums 2", () => {
  /** `.toBe()` is a **matcher** */
  expect(sum(1, 2)).toBe(3);
});

test("should return for when two sum two", () => {
  expect(2 + 2).toBe(4);
});

/* -------------------------------- TOEQUAL() ------------------------------- */
test("should assign property to object", () => {
  const data = { one: 1 };
  data["two"] = 2;
  expect(data).toEqual({ one: 1, two: 2 });
});

/* ---------------------------------- FALSY --------------------------------- */
test("should return falsy when checking null", () => {
  const foo = null;
  expect(foo).toBeFalsy();
});

test("should return falsy when checking zero", () => {
  const foo = 0;
  expect(foo).toBeFalsy();
});

/* --------------------------------- TRUTHY --------------------------------- */
test("should return truthy when checking a positive integer", () => {
  const foo = 1;
  expect(foo).toBeTruthy();
});

/* ---------------------------------- THROW --------------------------------- */
test("should throw an invalid input", () => {
  expect(() => {
    const foo = "1";
    throwsErrorFn(foo);
  }).toThrow();
});
