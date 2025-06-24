// https://www.youtube.com/watch?v=vn3tm0quoqE

const tick = Date.now();
const log = (v) => console.log(`${v} \n Elapsed: ${Date.now() - tick}ms`);

const codeBlockerMainThread = () => {
  let i = 0;
  while (i < 1_000_000_000) {
    i++;
  }
  return "🐷 Billion loops are done";
};

const codeBlockerMicroTask = () => {
  return new Promise((resolve) => {
    let i = 0;
    while (i < 1_000_000_000) {
      i++;
    }
    resolve("🐷 Billion loops are done");
  });
};
const codeBlockerMacroTask = () => {
  return Promise.resolve().then(() => {
    let i = 0;
    while (i < 1_000_000_000) {
      i++;
    }
    return "🐷 Billion loops are done";
  });
};

log("🥪 Synchronous 1");

// log(codeBlockerMainThread());
// codeBlockerMicroTask().then(log);
codeBlockerMacroTask().then(log);

log("🥪 Synchronous 2");
