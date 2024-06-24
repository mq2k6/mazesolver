class maze {
  PVector start;
  PVector end;
  int cellSize;
  int cols = 20;
  int rows = cols;
  Cell[][] grid = new Cell[cols][rows];
  ArrayList<Cell> path = new ArrayList<Cell>();
  ArrayList<Cell> visited = new ArrayList<Cell>();

  maze() {

    this.cellSize = width / cols;  // Set cellSize based on window size (700x700)

    for (int i = 0; i < cols; i++) {    // Fill maze grid with walls to start
      for (int j = 0; j < rows; j++) {
        grid[i][j] = new Cell(new PVector(i, j), 1);
      }
    }
  }

  void resetMaze() {
    for (int i = 0; i < cols; i++) {    // Fill maze grid with walls to start
      for (int j = 0; j < rows; j++) {
        grid[i][j] = new Cell(new PVector(i, j), 1);
      }
    }
    solve = false;
  }

  void initialize() {
    println("Generating maze...");
    pathGen((int) random(cols), (int) random(rows));  //Generate maze path
    setpoints();    // Set start & endpoints
    println("Maze generation complete!");
  }

  void pathGen(int x, int y) {

    // Set the inputted grid point to "visited", also set it to a path instead of a wall

    grid[x][y].visited = true;
    grid[x][y].state = 0;

    // Create an ArrayList of possible neighbors for each cell

    ArrayList<PVector> neighbors = new ArrayList<PVector>();
    neighbors.add(new PVector(x + 2, y));
    neighbors.add(new PVector(x - 2, y));
    neighbors.add(new PVector(x, y + 2));
    neighbors.add(new PVector(x, y - 2));
    shufflePath(neighbors);

    for (PVector neighbor : neighbors) {
      int xNeighbor = (int) neighbor.x;
      int yNeighbor = (int) neighbor.y;

      if (xNeighbor >= 0 && yNeighbor >= 0 && xNeighbor < cols && yNeighbor < rows && !grid[xNeighbor][yNeighbor].visited) {      // If the x & y values of a given neighboring cell are valid cells within the grid, and the cell has NOT been visited...
        grid[(x + xNeighbor) / 2][(y + yNeighbor) / 2].state = 0;      // Remove the wall between currently selected cell & neighboring cell
        pathGen(xNeighbor, yNeighbor);    // Recursively call neighborSelect
      }
    }
  }

  // Shuffle the viable path candidates by randomly swapping their positions

  void shufflePath(ArrayList<PVector> list) {
    for (int i = list.size() - 1; i > 0; i--) {
      int j = int(random(i + 1));
      PVector temp = list.get(i);
      list.set(i, list.get(j));
      list.set(j, temp);
    }
  }

  // Randomly select 2 points for start & end

  void setpoints() {
    this.start = getRandomCellWithState(0);
    this.end = getRandomCellWithState(0);
  }

  // Select a random cell, whose state matches the input
  // Used for selecting start & endpoint

  PVector getRandomCellWithState(int state) {
    while (true) {
      int a = int(random(this.cols));
      int b = int(random(this.rows));
      if (grid[a][b].state == state) {
        return new PVector(a, b);
      }
    }
  }

  void drawmaze() {    // Take generated 2D array for the maze, and convert to a visual grid of paths and walls
    int x = 0;
    int y = 0;
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        if (grid[i][j].state == 1) {    // Walls are filled with black
          stroke(0);
          fill(0);
        } else {
          stroke(255);    // Paths are filled with white
          fill(255);
        }
        square(x, y, this.cellSize);
        x += this.cellSize;
      }
      x = 0;
      y += this.cellSize;
    }
    stroke(255);
    fill(0, 255, 0);
    square(start.x * this.cellSize, start.y * this.cellSize, this.cellSize);    // Redraw start cell with green
    fill(255, 0, 0);
    square(end.x * this.cellSize, end.y * this.cellSize, this.cellSize);        // Redraw end cell with red
  }
}
