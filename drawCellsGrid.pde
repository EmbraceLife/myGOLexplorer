  // **************************  3. let's draw cell grids1 ************************** 
void drawCellsGrid(int cellSize, int[][] cells) {
  for (int x=0; x<width/cellSize; x++) {              
   for (int y=0; y<height/cellSize; y++) { 
     if (cells[x][y] == 1) {
       fill(alive);
     } else {
       fill(dead);
     }
     stroke(34);
     rect(x*cellSize, y*cellSize, cellSize, cellSize);
   }
  }
}

   