function sum(a, b) {
  return a + b;
}

a = sum;
b = sum(1, 2);

console.log(a);
console.log(b);

a(1, 5);
a(6, 2);
