
void changeCellStatus(int enlargeSize, int[][] selectedSquareBuffer, int[][] selectedSquare) {


      // ************** define and constrain xCellOver, yCellOver with mouseX, mouseY in selectedSquare
      
      // make sure mouse hover on enlarged cells not on pixels
      int xCellOver = int(map(mouseX, 0, width, 0, width/enlargeSize));
  
      // make sure the last column of cell will not be clicked/shown
      xCellOver = constrain(xCellOver, 0, width/enlargeSize-1);         
  
      // make sure mouse click refer not pixel but cell with 5 pixel on y-axis
      int yCellOver = int(map(mouseY, 0, height, 0, height/enlargeSize));
  
      // make sure the last row of cell will not be clicked/shown
      yCellOver = constrain(yCellOver, 0, height/enlargeSize-1);        
  
      // ************** click to change status of cells of selectedSquare 
      // when mouse licked, it is cell being clicked
      // xCellOver, yCellOver --> cell.index.x and cell.index.y
      // for the cell being clicked, if its buffer copy value = 1 alive, then set its value in cells dead
      //if (selectedSquare[xCellOver][yCellOver] == selectedSquareBuffer[xCellOver][yCellOver]) {
      if (selectedSquareBuffer[xCellOver][yCellOver]==1) { 
        selectedSquare[xCellOver][yCellOver]=0; // buffer copy is done when pause the iteration
        fill(dead); // Fill with kill color
      } else { // if its buffer copy value is not 1, then set its cells' value as 1
        selectedSquare[xCellOver][yCellOver]=1; 
        fill(alive); // Fill alive color
      }
      
      // println("enlarge is ", enlarge, " for change cell status for selectedSquare");
    
  }