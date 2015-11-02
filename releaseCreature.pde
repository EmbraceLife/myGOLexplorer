// releaseCreatureMode


void releaseCreature() {

  
  // load creature1 from csv to a small grid starting at (0,0)
  Table creature1 = loadTable("simpleCreature1.csv", "header");

  int[][] creatureGrid1;
  
  int R = creature1.getRowCount();  // it is really just num of cells on y-axis
  int C = creature1.getColumnCount(); // it is really just num of cells on x-axis
  
  creatureGrid1 = new int[R][C];
  
  
  println(R + " total rows in table"); 

  for (int i=0; i<C; i++) {
    for (int j=0; j<R; j++) {
      int num = creature1.getInt(j, i);
      println("row"+i+"col"+j, ":", num);
      creatureGrid1[i][j] = num;
    }
  }
  
  
  // display creatureBox and moving it with mouse
  xCellOver = int(map(mouseX, 0, width, 0, (width-1)/cellSize));

  yCellOver = int(map(mouseY, 0, height, 0, (height-1)/cellSize));
  
   if (keyPressed == true && pause) {
   
    if (key == 'v' || key == 'V') {
      noFill();
      stroke(0,0,255);
      rect(xCellOver, yCellOver, C, R);
    }
   }

  // insert createGrid1 into cells grid at the cell where mouse clicks
  for (int i = xCellOver; i < xCellOver+C; i++) {
    for (int j = yCellOver; j < yCellOver+R; j++) {
      cells[i][j] = creatureGrid1[j-yCellOver][i-xCellOver];
    }
  }
  
 
}