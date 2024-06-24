/*#################################################################
 #                                                                 #
 #  ICS4U - 01 FINAL SUMMATIVE                                     #
 #                                                                 #
 #  MAZE GENERATOR (Recursive backtracking) + SOLVER (Dijkstra's)  #
 #                                                                 #
 #  BY: MUSTAFA QASIM                                              #
 #                                                                 #
 #################################################################*/

import g4p_controls.*;
maze maze;
int step = 0;
ArrayList<PVector> path;
boolean solve = false;

void settings() {
  size(700, 700);
  maze = new maze();
}


void setup() {
  frameRate(60);
  maze.initialize();
  createGUI();
}

void draw() {
  maze.drawmaze();
  if (solve) {
    path = dijkstra();

    drawPath();
    if (step < path.size() - 1) {
      step++;
    }
  }
}
