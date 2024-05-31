const king = document.querySelector(".chess-piece");
const squares = document.querySelectorAll(".square");
const infoDisplay = document.querySelector("#info");

let draggedElement = null;

// First you have where you start the dragging
/**
 * Handles the drag start event.
 * @param {DragEvent} event - The drag start event.
 */
const dragStart = (event) => {
  draggedElement = event.target;
  console.info(`dragging has started on ${draggedElement.id}`);
};

/**
 * Function that handles the dragging of an element.
 */
const dragging = () => {
  console.info(`You're dragging a ${draggedElement.id}`);
  infoDisplay.textContent = `You are dragging a ${draggedElement.id}`;
};

/**
 * Handles the dragover event.
 * @param {DragEvent} event - The dragover event object.
 */
const dragOver = (event) => {
  event.preventDefault();
  console.info(`You're dragging something over ${event.target.classList}`);
};

/**
 * Handles the drag enter event.
 *
 * Adds a `highlight` class to the hovered element.
 *
 * @param {DragEvent} event - The drag enter event object.
 */
const dragEnter = (event) => {
  event.target.classList.add("highlight");
  console.info(`You're entering the space of ${event.target.classList}`);
};

/**
 * Handles the drag leave event.
 *
 * Removes the `highlight` class when the dragged element leaves.
 *
 * @param {DragEvent} event - The drag leave event object.
 */
const dragLeave = (event) => {
  console.info(`You're leaving the space of ${event.target.classList}`);
  event.target.classList.remove("highlight");
};

/**
 * Append the piece to the dropped element.
 *
 * To drop it, there needs to prevent lots of default behaviours, such as
 * preventing {@link dragOver}'s one.
 *
 * Remooves the `highlight` class when the element is dropped.
 *
 * @param {DragEvent} event
 */
const dragDrop = (event) => {
  event.target.append(draggedElement);
  event.target.classList.remove("highlight");
};

/**
 * Handles the drag end event.
 * @param {DragEvent} event - The drag end event object.
 */
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
