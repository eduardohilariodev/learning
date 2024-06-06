const app = Vue.createApp({
  data() {
    return {
      name: "Eduardo",
      age: 25,
      image: "https://www.udemy.com/staticx/udemy/images/v7/logo-udemy-inverted.svg"
    };
  },
  computed: {
    random: () => {
      return Math.random();
    },
  },
});
app.mount("#assignment");
