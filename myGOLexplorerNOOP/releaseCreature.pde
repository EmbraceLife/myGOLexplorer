// releaseCreatureMode


void releaseCreature() {
  

  // conditions for loading creature
  if (pause && loadCreatureMode) {
    
    // load csv creature into a table
    Table creature1 = loadTable("simpleCreature1.csv", "header");
  
    // turn Table int grid
    R = creature1.getRowCount();  // it is really just num of cells on y-axis
    C = creature1.getColumnCount(); // it is really just num of cells on x-axis
    creatureGrid1 = new int[C][R]; // ***make sure to define the length of int[][] here not at beginning
    
    
    // transfer value from Table to grid
    for (int i=0; i<C; i++) {
      for (int j=0; j<R; j++) {
        int num = creature1.getInt(j, i); // table.getInt(row, col);
        creatureGrid1[i][j] = num; // grid[x][y] --> grid[col][row]
      }
    }
    
   // loading creature allowed only once 
   loadCreatureMode = !loadCreatureMode;
  }
  
  
  
  
  
  // display creatureBox and moving it with mouse
  int xCellOver = int(map(mouseX, 0, width, 0, (width-1)/cellSize));
  int yCellOver = int(map(mouseY, 0, height, 0, (height-1)/cellSize));
  

  // press v to choose a position to release creature
   if (keyPressed == true && pause) {
   
    if (key == 'v' || key == 'V') {
      noFill();
      stroke(0,0,255);
      rect(xCellOver*cellSize, yCellOver*cellSize, C*cellSize, R*cellSize);
      println("releaseCreatureAt:", xCellOver, yCellOver);
    }
   }

  // press m to insert creature in grid into cells grid of canvas
  if (pause && releaseCreatureMode) {
    for (int i = xCellOver; i < xCellOver+C; i++) {
      for (int j = yCellOver; j < yCellOver+R; j++) {
        
        i = constrain(i, 0, width-1-C);
        j = constrain(j, 0, height-1-R);
        cells[i][j] = creatureGrid1[i-xCellOver][j-yCellOver]; // careful of [][] inside order
      }
    }
    releaseCreatureMode = !releaseCreatureMode;
  }
  
 
}