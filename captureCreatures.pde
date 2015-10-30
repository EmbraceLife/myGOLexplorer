/*
1. when pause is true:
    1.0 captureMode is true (define boolean captureMode = false; )
    1.1 int startX, startY, endX, endY;
    1.2 int[][] creatureGrid;

2. click to select initial point and end point of a rect
    2.0 if (mousePressed == true) {}, then copy the starting point
    
3. create a creature grid and save the values in this area into creature grid
    3.0 instantiate creature grid with start and end points

4. find values of all cells in the selected square and save them to creatureGrid
    4.1 find values from cells
    4.2 save into creatureGrid
    
5. save this creatureGrid array into a file


6. extrieve this file to display creature on an empty grid 
7. click anywhere in grid to paste the creature


*/

void captureCreatures() {

  // ********* 2. mouse hovering to choose a starting point to click/record ********* 
  // 2.1 mouseX can hover from most left pixel to most right pixel
  // 2.2 xCellOver can indirect hover from most left cell to most right cell
  // 2.3 mouseX can touch on the right edge pixel, not for xCellOver
  int xCellOver = int(map(mouseX, 0, width, 0, (width-1)/cellSize));
       

  // 2.4 mouseY can hover from most top pixel to most bottom pixel
  // 2.5 yCellOver can indirect hover from most top cell to most bottom cell
  // 2.6 mouseY can touch on the bottom edge pixel, not for yCellOver
  int yCellOver = int(map(mouseY, 0, height, 0, (height-1)/cellSize));


  // both mouseX, mouseY, xCellOver, yCellOver are updating by moving mouse automatically 
  // ***Import***: we must store xCellOver, yCellOver values as copies into new variables
  // as any move of mouse will change mouseX, mouseY, xCellOver, yCellOver
  // 2.7 when mousePressed, copy the selected/hovering point as starting point
  if (mousePressed == true) {
    startX = xCellOver;
    startY = yCellOver;
  }

  // 2.8 when mouseReleased, copy the selected/hovering point as ending point
  if (mouseReleased == true) {
    endX = xCellOver;
    endY = yCellOver;
  }
  
  
  
  // ******************************** 3. initialize creatureGrid ***************** 
  // e.g. from cell.x1 to cell.x10, the square takes 10 cells on x-axis --> 10-1+1
  creatureGrid = new int[endX-startX+1][endY-startY+1]; 
  
  
  
  // ******************************** 4. save cell values and save to creatureGrid ***************** 
  // 4.1 extrieve cell values from cells grid
  for (int i = startX; i < endX+1; i++) {
    for (int j = startY; j < endY+1; j++) {
      
      // [i-startX] --> index0 to index(endX-startX) note: it is not index(endX-startX+1)
      creatureGrid[i-startX][j-startY] = cells[i][j];
    }
  }
  
  // draw and display the red rect for selected area
  stroke(200, 0, 150);
  noFill();
  
  // 60*cellSize-1, 60*cellSize-1 can bring right and bottom side of red rect to vision
  // but it will ignore the right and bottom edge lines
  rect(xCellOver*cellSize, yCellOver*cellSize, 60*cellSize, 60*cellSize);
}