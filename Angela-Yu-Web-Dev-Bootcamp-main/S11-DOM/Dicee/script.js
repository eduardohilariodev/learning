const playerOne = Math.floor(Math.random() * 6) + 1;
const playerTwo = Math.floor(Math.random() * 6) + 1;

if (playerOne > playerTwo) {
  document.querySelector("h1").innerText = "🚩 Player 1 wins!";
} else if (playerOne < playerTwo) {
  document.querySelector("h1").innerText = "Player 2 wins! 🚩";
} else {
  document.querySelector("h1").innerText = "Draw!";
}

document.querySelector(".img1").setAttribute("src", `images/dice${playerOne}.png`);
document.querySelector(".img2").setAttribute("src", `images/dice${playerTwo}.png`);

setTimeout(() => {
  document.querySelector("h1").innerText = "Refresh Me!";
}, 5000);
