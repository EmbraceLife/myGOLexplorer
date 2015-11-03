// releaseCreatureMode


void releaseCreature() {
  
  //Table creature1;
  
  //int R = 0;
  //int C = 0;
  //int[][] creatureGrid1 = new int[R][C];
  
  if (pause && loadCreatureMode) {
    // load creature1 from csv to a small grid starting at (0,0)
    creature1 = loadTable("simpleCreature1.csv", "header");
  
    R = creature1.getRowCount();  // it is really just num of cells on y-axis
    C = creature1.getColumnCount(); // it is really just num of cells on x-axis
    println(R, C);
    //creatureGrid1 = new int[R][C];
    
    
    //println(R + " total rows in table"); 
    //noLoop();
    for (int i=0; i<C; i++) {
      for (int j=0; j<R; j++) {
        int num = creature1.getInt(j, i);
        //println("row"+i+"col"+j, ":", num);
        creatureGrid1[i][j] = num;
      }
    }
    
   loadCreatureMode = !loadCreatureMode;
  }
  
  
  
  
  
  // display creatureBox and moving it with mouse
  int xCellOver = int(map(mouseX, 0, width, 0, (width-1)/cellSize));

  int yCellOver = int(map(mouseY, 0, height, 0, (height-1)/cellSize));
  
  println(xCellOver, yCellOver);
  //noLoop();
  
   if (keyPressed == true && pause) {
   
    if (key == 'v' || key == 'V') {
      noFill();
      stroke(0,0,255);
      rect(xCellOver*cellSize, yCellOver*cellSize, C*cellSize, R*cellSize);
    }
   }

  // insert createGrid1 into cells grid at the cell where mouse clicks, the grid will be drew by other func
  if (pause && releaseCreatureMode) {
    for (int i = xCellOver; i < xCellOver+C; i++) {
      for (int j = yCellOver; j < yCellOver+R; j++) {
        cells[i][j] = creatureGrid1[j-yCellOver][i-xCellOver];
      }
    }
    releaseCreatureMode = !releaseCreatureMode;
  }
  
 
}