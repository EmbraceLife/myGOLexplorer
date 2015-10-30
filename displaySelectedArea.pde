
void displaySelectedArea() {


  // make sure mouse hover/click to not pixel but cell with 5pixel on x-axis
  int xCellOver = int(map(mouseX, 0, width-1, 0, (width-1)/cellSize));

  // make sure the last column of cell will not be clicked/shown 
  // width/cellSize/2-1 ???
  // ??? why I cannot see the right and bottom side of red square??????
  xCellOver = constrain(xCellOver, 0, (width-1)/cellSize/2);         

  // make sure mouse click refer not pixel but cell with 5 pixel on y-axis
  int yCellOver = int(map(mouseY, 0, (height-1), 0, (height-1)/cellSize));

  // make sure the last row of cell will not be clicked/shown
  yCellOver = constrain(yCellOver, 0, (height-1)/cellSize/2);  


  // draw and display the red rect for selected area
  stroke(200, 0, 150);
  noFill();
  
  // 60*cellSize-1, 60*cellSize-1 can bring right and bottom side of red rect to vision
  // but it will ignore the right and bottom edge lines
  rect(xCellOver*cellSize, yCellOver*cellSize, 60*cellSize, 60*cellSize);
}