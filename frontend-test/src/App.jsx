import { useState } from "react";
import Board from "./Board";
import "./App.css";

function App() {
  const [inputRow, setInputRow] = useState("8");
  const [inputCol, setInputCol] = useState("8");

  const [boardSize, setBoardSize] = useState({ rows: 8, cols: 8 });
  const [knightPos, setKnightPos] = useState({ row: 0, col: 0 });

  const handleGenerate = (e) => {
    let r = parseInt(inputRow, 10);
    let c = parseInt(inputCol, 10);

    if (isNaN(r) || r < 1) r = 1;
    if (r > 100) r = 100;
    if (isNaN(c) || c < 1) c = 1;
    if (c > 100) c = 100;

    setBoardSize({ rows: r, cols: c });
    setInputRow(r)
    setInputCol(c)

    setKnightPos({ row: 0, col: 0 })
  }

  const handleSquareClick = (r, c) => {
    const dr = Math.abs(knightPos.row - r);
    const dc = Math.abs(knightPos.col - c);
    const isValidMove = (dr === 2 && dc === 1) || (dr === 1 && dc === 2);

    if (isValidMove) {
      setKnightPos({ row: r, col: c });
    }
  }

  return (
    <div className="container">
      <h2>Chess Lonely Knight</h2>
      <div className="form-group">
        <label>
          Rows:
          <input
            type="number"
            min="1"
            max="100"
            value={inputRow}
            onChange={(e) => setInputRow(e.target.value)}
          />
        </label>
        <label>
          Columns:
          <input
            type="number"
            min="1"
            max="100"
            value={inputCol}
            onChange={(e) => setInputCol(e.target.value)}
          />
        </label>
        <button onClick={handleGenerate}>Generate Board</button>
      </div>

      <Board
        rows={boardSize.rows}
        cols={boardSize.cols}
        knightPos={knightPos}
        onSquareClick={handleSquareClick}
      />
    </div>
  );
}

export default App;

