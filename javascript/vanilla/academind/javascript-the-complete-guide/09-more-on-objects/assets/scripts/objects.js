const addMovieButton = document.getElementById("add-movie-btn");
const searchButton = document.getElementById("search-btn");

const movies = [];

const renderMovies = () => {
  const movieList = document.getElementById("movie-list");

  if (movies.length === 0) {
    movieList.classList.remove("visible");
    return;
  }

  movieList.classList.add("visible");
  movieList.innerHTML = "";
  movies.forEach((movie) => {
    const movieElement = document.createElement("li");
    movieElement.textContent = movie.info.title;
    movieList.append(movieElement);
  });
};

const handleAddMovie = () => {
  const title = document.getElementById("title").value;
  const extraName = document.getElementById("extra-name").value;
  const extraValue = document.getElementById("extra-value").value;

  if (
    title.trim() === "" ||
    extraName.trim() === "" ||
    extraValue.trim() === ""
  ) {
    return;
  }

  const newMovie = {
    info: { title, [extraName]: extraValue },
    id: Math.random(),
  };

  movies.push(newMovie);
  renderMovies();
};

addMovieButton.addEventListener("click", handleAddMovie);
