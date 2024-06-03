const fetchTimeout = (callbackFn) => {
  setTimeout(() => {
    callbackFn("waldo");
  }, 1000);
};

const fetchPromise = ({ shouldReject } = {}) => {
  return new Promise((resolve) => {
    if (shouldReject) {
      throw new Error("error");
    }
    setTimeout(() => {
      return resolve("waldo");
    }, 1000);
  });
};

module.exports = { fetchTimeout, fetchPromise };
