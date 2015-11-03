 //<>// //<>//



void iteration() { 


  // save cells to cellsBuffer before every iteration
  for (int x=0; x<(width-1)/cellSize; x++) {
    for (int y=0; y<(height-1)/cellSize; y++) {
      cellsBuffer[x][y] = cells[x][y];
    }
  }

  // for every cell
  for (int x=0; x<(width-1)/cellSize; x++) {
    for (int y=0; y<(height-1)/cellSize; y++) {

      // number of its neighbours set 0 at first
      int neighbours = 0; 

      // loop around each cell to count up its living neighbours
      for (int xx=x-1; xx<=x+1; xx++) { //<>//

        if (xx == (width-1)/cellSize) {
          xx = 0;
        }

        if (xx == -1) {
          xx = (width-1)/cellSize-1;
        }

        for (int yy=y-1; yy<=y+1; yy++) {  

          if (yy == -1) {
            yy = (height-1)/cellSize-1;
          }
          if (yy == (height-1)/cellSize) {
            yy = 0;
          }

          // first, only consider neighbours(xx, yy) inside canvas
         // if (((xx>=0)&&(xx<(width-1)/cellSize))&&((yy>=0)&&(yy<(height-1)/cellSize))) { 
            // also not counting self
            if (!((xx==x)&&(yy==y))) { 
              // if a neighbour's value is 1, set count it as adding 1
              if (cellsBuffer[xx][yy]==1) { 
                neighbours ++; //<>//
              }
            }
          //}
        }
      }



      // ***** apply rules to each cell

      // if it is alive, but living neighbours are less than 2 or more than 3, make it dead
      if (cellsBuffer[x][y]==1) { 
        if (neighbours < 2 || neighbours > 3) { 
          cells[x][y] = 0;
        } else {
          // nothing changes
        }
      } else { // if it is dead 

        // but if its living neighbour are exactly 3, then make it alive
        if (neighbours == 3 ) { 
          cells[x][y] = 1;
        } else {
          // nothing changes
        }
      }
    }
  }
} 