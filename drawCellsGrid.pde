  // **************************  3. let's draw cell grids1 ************************** 
  
// set parameters to cellSize, cells for drawing cells grid
// set parameters to enlargeSize, selectedSquare, for drawing selectedSquare grid

void drawCellsGrid(int cellSize, int[][] cells) {
  
  // loop through every cell in grid
  for (int x=0; x<(width-1)/cellSize; x++) {              
   for (int y=0; y<(height-1)/cellSize; y++) { 
     
     // check value of each cell and set fill color accordingly
     if (cells[x][y] == 1) {
       fill(alive);
     } else {
       fill(dead);
     }
     stroke(34);
     
     // draw a rect for each cell
     // rect is not based on cell.x cell.y, but on pixels --> x*cellSize, y*cellSize
     rect(x*cellSize, y*cellSize, cellSize, cellSize);
   }
  }
}