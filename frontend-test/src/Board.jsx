import Square from './Square';

function Board({ rows, cols, knightPos, onSquareClick }) {
    const grid = [];

    for (let r = 0; r < rows; r++) {
        for (let c = 0; c < cols; c++) {
            grid.push(
                <Square
                    key={`${r}-${c}`}
                    row={r}
                    col={c}
                    knightPos={knightPos}
                    onClick={() => onSquareClick(r, c)}
                />
            );
        }
    }

    return (
        <div
            className="board"
            style={{
                gridTemplateRows: `repeat(${rows}, 40px)`,
                gridTemplateColumns: `repeat(${cols}, 40px)`,
            }}
        >
            {grid}
        </div>
    )
}

export default Board;