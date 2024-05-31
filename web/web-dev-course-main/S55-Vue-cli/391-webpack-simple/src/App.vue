<template>
  <div id="app">
    {{ msg }}
    <Red />
    <White />
    <Blue />
  </div>
</template>

<script>
import Blue from "./components/blue";
import Red from "./components/red";
import White from "./components/white";

export default {
  components: {
    Red,
    White,
    Blue,
  },
  data() {
    return {
      msg: "Netherlands flag",
    };
  },
};
</script>

<style></style>
