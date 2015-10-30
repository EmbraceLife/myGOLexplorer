

void displaySelectedArea() {


  // make sure mouse hover/click to not pixel but cell with 5pixel on x-axis
  int xCellOver = int(map(mouseX, 0, width, 0, width/cellSize));

  // make sure the last column of cell will not be clicked/shown
  xCellOver = constrain(xCellOver, 0, width/cellSize/2-1);         

  // make sure mouse click refer not pixel but cell with 5 pixel on y-axis
  int yCellOver = int(map(mouseY, 0, height, 0, height/cellSize));

  // make sure the last row of cell will not be clicked/shown
  yCellOver = constrain(yCellOver, 0, height/cellSize/2-1);  


  stroke(200, 0, 150);
  noFill();
  rect(xCellOver*cellSize, yCellOver*cellSize, 60*cellSize, 60*cellSize);
}