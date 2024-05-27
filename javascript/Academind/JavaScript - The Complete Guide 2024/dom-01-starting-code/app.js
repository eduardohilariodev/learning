// const listItemElements = document.querySelectorAll("li");
const listItemElements = document.getElementsByTagName("li");

for (const listItemEl of listItemElements) {
  console.dir(listItemEl);
}
