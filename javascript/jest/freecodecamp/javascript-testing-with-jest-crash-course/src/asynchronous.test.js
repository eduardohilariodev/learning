const { fetchTimeout, fetchPromise } = require("./asynchronous");

/* ------------------------------ SIMPLE ASYNC ------------------------------ */
test("should return 'waldo' when calling fetchTimeout", (done) => {
  const callbackFn = (data) => {
    try {
      expect(data).toBe("waldo");
      done();
    } catch (error) {
      done(error);
    }
  };

  fetchTimeout(callbackFn);
});

/* --------------------------------- PROMISE -------------------------------- */
test("should resolve to 'waldo' when calling fetchPromise", () => {
  return expect(fetchPromise()).resolves.toBe("waldo");
});

test("should fail with an error when rejecting fetchPromise", () => {
  return expect(fetchPromise({ shouldReject: true })).rejects.toThrow("error");
});

/* ------------------------------- ASYNC/AWAIT ------------------------------ */
test("should resolve to 'waldo' when calling fetchPromise", async () => {
  const data = await fetchPromise();
  expect(data).toBe("waldo");
});
