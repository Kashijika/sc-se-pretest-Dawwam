function Square({ row, col, knightPos, onClick }) {
    const isKnightHere = knightPos.row === row && knightPos.col === col;

    const dr = Math.abs(knightPos.row - row);
    const dc = Math.abs(knightPos.col - col);
    const isValidMove = (dr === 2 && dc === 1) || (dr === 1 && dc === 2);

    let className = "square";
    className += (row + col) % 2 === 0 ? " square-light" : " square-dark";

    if (isKnightHere) {
        className += " is-knight";
    } else if (isValidMove) {
        className += " is-valid-move";
    } else {
        className += " is-invalid-move";
    }

    return (
        <div className={className} onClick={onClick}>
            {isKnightHere && <span className="knight-icon">K</span>}
        </div>
    );
}

export default Square;