    
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
    
    // press x to remember the start point of selection square
    xZoom = xCellOver;
    yZoom = yCellOver;
     
    // record the selected square only once for all frame loops later
    for (int xCell=xZoom; xCell<xZoom+60; xCell++) {
      for (int yCell=yZoom; yCell<yZoom+60; yCell++) {
        
        // ***********as xCellOver is fixed by mouseX, xCell-xCellOver = 0 to 60*************
        
        // *********** transfer values of cells grid to them
        selectedSquare[xCell-xZoom][yCell-yZoom] = cellsBuffer[xCell][yCell];
        selectedSquareBuffer[xCell-xZoom][yCell-yZoom] = cellsBuffer[xCell][yCell];
      }
  }
    
    makeSelection = !makeSelection;

  }
  
  // press e to draw the selected square on full canvas
  if (enlarge) {
      

      // ********* let saveLocationX and Y to remember the selected (mouseX, mouseY) or (xCellOver,yCellOver) 
      saveLocationX = xZoom;
      saveLocationY = yZoom;
      
      
      
      // draw the selected square
      drawCellsGrid(enlargeSize, selectedSquare);
      
      
      // console: zoom x y coordinates
      int xCellOverZoom = int(map(mouseX, 0, width-1, 0, (width-1)/enlargeSize));
      int yCellOverZoom = int(map(mouseY, 0, height-1, 0, (height-1)/enlargeSize));
      println("zoom ", xCellOverZoom, ":", yCellOverZoom);
  
  
  }

}
      