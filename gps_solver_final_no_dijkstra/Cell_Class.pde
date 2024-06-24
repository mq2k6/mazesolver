class Cell {
  PVector loc;   // Where the cell is located
  int state;     // 0 for path, 1 for wall
  boolean visited;  // Whether the cell has been visited or not

  Cell(PVector loc, int state) {
    this.loc = loc;
    this.state = state;
    this.visited = false;
  }
}
