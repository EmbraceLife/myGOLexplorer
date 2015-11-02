    
void createSelectedSquareBasedOnCells() {  
 
   // ***** if xCellOver as local variable, every frame-run through this function, xCellOver is new
 
  // let mouse hovering on cells not on pixels
  int xCellOver = int(map(mouseX, 0, width-1, 0, (width-1)/cellSize));

  // constrain mouseX or xCellOver only hover the first half cols of cells grid, 
  // also it cannot hover on the last col of first half
  // ??? decide between width/cellSize/2-1 and width/cellSize/2 ????
  xCellOver = constrain(xCellOver, 0, (width-1)/cellSize/2);         

  // mouseY or yCellOver can hover over any cell of cells grid, but not on pixels
  int yCellOver = int(map(mouseY, 0, height-1, 0, (height-1)/cellSize));

  // constrain yCellOver/mouseY only hover on first half of rows of cells grid
  yCellOver = constrain(yCellOver, 0, (height-1)/cellSize/2);  

  
  if (makeSelection) {  
     
    xZoom = xCellOver;
    yZoom = yCellOver;
    makeSelection = !makeSelection;
  }
  
  if (enlarge) {
      
      // *********** from (mouseX, mouseY) right 60, down 60, is selectedSquare grid
      for (int xCell=xZoom; xCell<xZoom+60; xCell++) {
        for (int yCell=yZoom; yCell<yZoom+60; yCell++) {
          
          // ***********as xCellOver is fixed by mouseX, xCell-xCellOver = 0 to 60*************
          
          // *********** transfer values of cells grid to them
          selectedSquare[xCell-xZoom][yCell-yZoom] = cellsBuffer[xCell][yCell];
          selectedSquareBuffer[xCell-xZoom][yCell-yZoom] = cellsBuffer[xCell][yCell];
        }
      }
      //}
      //}

      // ******* debug see above code of assigning working or not
      //println("target1: " + selectedSquare[0][0]);
      //println("mouse1: " + cellsBuffer[xCellOver][yCellOver]);
      //println("target2: " + selectedSquare[0][1]);
      //println("mouse2: " + cellsBuffer[xCellOver][yCellOver+1]);
      //println("target3: " + selectedSquare[0][2]);
      //println("mouse3: " + cellsBuffer[xCellOver][yCellOver+2]);

      // enlargeSize = cellSize*2;
      //enlarge = !enlarge;

      // ********* let saveLocationX and Y to remember the selected (mouseX, mouseY) or (xCellOver,yCellOver) 
      saveLocationX = xZoom;
      saveLocationY = yZoom;
      
      
      

      drawCellsGrid(enlargeSize, selectedSquare);
  
  
  }

}
      