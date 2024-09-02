import Player from "./components/Player";

function App() {
  return (
    <div id="game-container">
      <ol id="players">
        <Player
          name="Player 1"
          symbol="X"
        />
        <Player
          name="Player 2"
          symbol="O"
        />
      </ol>
      GAME BOARD
    </div>
  );
}

export default App;
