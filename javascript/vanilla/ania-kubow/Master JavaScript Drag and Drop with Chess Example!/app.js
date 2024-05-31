const king = document.querySelector(".chess-piece");
const squares = document.querySelectorAll(".square");
const infoDisplay = document.querySelector("#info");

let draggedElement = null;

// First you have where you start the dragging
const dragStart = (event) => {
  draggedElement = event.target;
  console.info(`dragging has started on ${draggedElement.id}`);
};

const dragging = () => {
  console.info(`You're dragging a ${draggedElement.id}`);
  infoDisplay.textContent = `You are dragging a ${draggedElement.id}`;
};

const dragOver = (event) => {
  console.info(`You're dragging something over ${event.target.classList}`);
};

const dragEnter = (event) => {
  console.info(`You're entering the space of ${event.target.classList}`);
};

const dragLeave = (event) => {
  console.info(`You're leaving the space of ${event.target.classList}`);
};

const dragDrop = (event) => {
  console.info(`You've dropped something into ${event.target.classList}`);
};

const dragEnd = (event) => {
  console.info(`The drag has ended in ${event.target.classList}`);
};

king.addEventListener("drag", dragging);
king.addEventListener("dragstart", dragStart);

squares.forEach((square) => {
  square.addEventListener("dragover", dragOver);
  square.addEventListener("dragenter", dragEnter);
  square.addEventListener("dragleave", dragLeave);
  square.addEventListener("drop", dragDrop);
  square.addEventListener("dragend", dragEnd);
});
