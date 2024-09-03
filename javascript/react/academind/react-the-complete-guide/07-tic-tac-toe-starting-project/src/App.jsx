import Player from "./components/Player";

export default function App() {
  return (
    <div id="game-container">
      <ol id="players">
        <Player
          initialName="Player 1"
          symbol="X"
        />
        <Player
          initialName="Player 2"
          symbol="O"
        />
      </ol>
      GAME BOARD
    </div>
  );
}
