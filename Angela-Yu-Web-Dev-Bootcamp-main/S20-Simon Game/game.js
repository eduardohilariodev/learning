// how to trigger alert on page load using jquery
const buttonColors = ["red", "blue", "green", "yellow"];
let gamePattern = [];
let userClickedPattern = [];
let level = 0;
let started = false;

$(document).keypress(function () {
  if (!started) {
    changeTitle(level);
    nextSequence();
    started = true;
  }
});

function nextSequence() {
  const randomNumber = Math.floor(Math.random() * 4);
  const randomChosenColor = buttonColors[randomNumber];

  userClickedPattern = [];

  level++;
  changeTitle(level);

  animatePress(randomChosenColor);
  gamePattern.push(randomChosenColor);
}

$(".btn").click(function (event) {
  const userChosenColor = event.target.id;
  userClickedPattern.push(userChosenColor);

  playSound(userChosenColor);
  animatePress(userChosenColor);

  checkAnswer(userClickedPattern.length - 1);
});

function playSound(name = "") {
  new Audio(`sounds/${name}.mp3`).play();
}

function animatePress(currentColor = "") {
  $(`#${currentColor}`).addClass("pressed");
  setTimeout(() => {
    $(`#${currentColor}`).removeClass("pressed");
  }, 100);
}

function changeTitle(number) {
  $("#level-title").text(`Level ${number}`);
}

function checkAnswer(currentLevel) {
  if (gamePattern[currentLevel] === userClickedPattern[currentLevel]) {
    if (gamePattern.length === userClickedPattern.length) {
      setTimeout(function () {
        nextSequence();
      }, 1000);
    }
  } else {
    startOver();
    playSound("wrong");
    $("#level-title").text("Game Over, Press Any Key to Restart");
    $("body").addClass("game-over");
    setTimeout(() => {
      $("body").removeClass("game-over");
    }, 200);
  }
}

function startOver() {
  started = false;
  level = 0;
  gamePattern = [];
}
