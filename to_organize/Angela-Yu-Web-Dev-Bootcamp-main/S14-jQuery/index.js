$("h1").click(function (e) {
  e.preventDefault();

  if ($(this).attr("style") === "color: purple;") {
    $(this).css("color", "black");
  } else $(this).css("color", "purple");

  //how to get style with jquery
});
