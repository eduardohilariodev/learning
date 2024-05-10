const jQuery = require("jquery");
const lodash = require("lodash");
const bootstrapCSS = require("bootstrap/dist/css/bootstrap.min.css");

require("./styles.css");
require("./module-1");
require("./module-2");

document.getElementById("p3").innerText = "Set by entry.js";
jQuery("#p1").on("click", () => {
  alert("Clicked by expose-loader");
});
jQuery("#p2").on("click", () => {
  alert("Clicked by expose-loader");
});
jQuery("#p3").on("click", () => {
  alert("Clicked by expose-loader");
});
lodash.defaults({ a: 1 }, { a: 3, b: 2 });
