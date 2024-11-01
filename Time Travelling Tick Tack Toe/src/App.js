import "./styles.css";
import { useState } from "react";

// square
function Square({ isX, onClick, value }) {
  return (
    <button className={"square"} onClick={onClick}>
      {value}
    </button>
  );
}

//Board
function Board() {
  const [isX, setIsX] = useState(true);
  const [squares, setSquares] = useState(Array(9).fill(null));
  const [win, setWin] = useState(false);
  let [history, setHistory] = useState(Array(0).fill(null));
  let move = 0;
  function handleXO(index) {
    if (!squares[index] && !win) {
      const newSquares = squares.slice();
      newSquares[index] = isX ? "X" : "O";
      history.push(newSquares);
      move += 1;
      setSquares(newSquares);
      if (checkWiner(newSquares)) {
        setWin(true);
      } else {
        setIsX(!isX);
      }
    }
  }

  function checkWiner(newSquares) {
    const lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (const [a, b, c] of lines) {
      if (
        newSquares[a] &&
        newSquares[a] == newSquares[b] &&
        newSquares[a] == newSquares[c]
      ) {
        return true;
      }
    }
    return false;
  }

  function resetHandle() {
    newSquares = Array(9).fill(null);
    setSquares(newSquares);
    setWin(false);
    setIsX(true);
    setHistory(Array(0));
  }

  const moves = history.map((squares, move) => {
    let description;
    if (move > 0) {
      description = `Go to #${move}`;
    } else {
      description = "Go to Start";
    }

    return (
      <li key={move}>
        <button onClick={() => jumpTo((newSquares = squares), (move = move))}>
          {description}
        </button>
      </li>
    );
  });

  function jumpTo(newSquares, move) {
    setSquares(newSquares);
    setIsX(move % 2 === 0);
    setHistory(history.slice(0, move + 1));
    setWin(false);
  }

  return (
    <div className="Overall">
      <div className="turn">
        {win ? "Winner" : "Turn"}: {isX ? "X" : "O"}
      </div>
      <div className={"ourGrid"}>
        <Square isX={isX} onClick={() => handleXO(0)} value={squares[0]} />
        <Square isX={isX} onClick={() => handleXO(1)} value={squares[1]} />
        <Square isX={isX} onClick={() => handleXO(2)} value={squares[2]} />
        <Square isX={isX} onClick={() => handleXO(3)} value={squares[3]} />
        <Square isX={isX} onClick={() => handleXO(4)} value={squares[4]} />
        <Square isX={isX} onClick={() => handleXO(5)} value={squares[5]} />
        <Square isX={isX} onClick={() => handleXO(6)} value={squares[6]} />
        <Square isX={isX} onClick={() => handleXO(7)} value={squares[7]} />
        <Square isX={isX} onClick={() => handleXO(8)} value={squares[8]} />
      </div>
      <button className={"resetButton"} onClick={resetHandle}>
        Reset
      </button>
      <ol>{moves}</ol>
    </div>
  );
}
export default function myApp() {
  return (
    <div>
      <Board />
    </div>
  );
}
