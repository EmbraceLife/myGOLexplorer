/*



1. having the following variables in global setting
    1.0 captureMode is true (define boolean captureMode = false; )
    1.1 int startX, startY, endX, endY;
    1.2 int[][] creatureGrid;
    1.3 int[] creatureString;

2. given pause, press q to record start point, press hold a and move mouse to select area, 
     press w to record end point

    
3. press p to 
     3.1 create a creature grid and save the values in this area into creature grid
     3.2find values of all cells in the selected square and save them to creatureGrid
          find values from cells
          save values into creatureGrid
    
     3.3. save values from creatureGrid to creatureString

     3.4. save creatureString into a .txt

*/

void captureCreatures() {
  
  //   // 1.0 captureMode is true (define boolean captureMode = false; )
  //int startX = 0;
  //int startY = 0; 
  //int endX = 0;
  //int endY = 0;
  //int[][] creatureGrid;
  //String[] creatureString;

  // ********* 2. mouse hovering to choose a starting point to click/record ********* 
  // 2.1 mouseX can hover from most left pixel to most right pixel
  // 2.2 xCellOver can indirect hover from most left cell to most right cell
  // 2.3 mouseX can touch on the right edge pixel, not for xCellOver
  xCellOver = int(map(mouseX, 0, width, 0, (width-1)/cellSize));
       

  // 2.4 mouseY can hover from most top pixel to most bottom pixel
  // 2.5 yCellOver can indirect hover from most top cell to most bottom cell
  // 2.6 mouseY can touch on the bottom edge pixel, not for yCellOver
  yCellOver = int(map(mouseY, 0, height, 0, (height-1)/cellSize));


 // both mouseX, mouseY, xCellOver, yCellOver are updating by moving mouse automatically 
 // ***Import***: we must store xCellOver, yCellOver values as copies into new variables
 // as any move of mouse will change mouseX, mouseY, xCellOver, yCellOver
 // ******************2.7 when captureMode is toggled true, copy the selected/hovering point as starting point
 // ***** then automatically captureMode is toggled false to lock starting point ********

 if (pause && recordStartPoint) {
   startX = xCellOver;
   startY = yCellOver;
   recordStartPoint = !recordStartPoint;
 }
   
 // ******* 2.8 now drawing yellow rect with starting point, mouse and 'a' key ***********  
 if (keyPressed == true && pause) {
     
      if (key == 'a' || key == 'A') {
       // as long as 'a' is pressed, ending point is following mouse hovering, and rect is drew
       
         stroke(0, 200, 150);
         noFill();
         
         rect(startX*cellSize, startY*cellSize, (xCellOver-startX+1)*cellSize, (yCellOver-startY+1)*cellSize);
      }
 }
      // toggle recordEndPoint with 'w' to record endX, endY point
      // ***** then automatically captureMode is toggled false to lock starting point ********
  if (recordEndPoint && pause) {
    endX = xCellOver;
    endY = yCellOver;
    recordEndPoint = !recordEndPoint;
  }
 
 


  if (captureMode) {
  
  // ******************************** 3. initialize creatureGrid ***************** 
  // e.g. from cell.x1 to cell.x10, the square takes 10 cells on x-axis --> 10-1+1
    //creatureGrid = new int[endX-startX+1][endY-startY+1]; 
  
  
  
  // ******************************** 4. save cell values and save to creatureGrid ***************** 
  // 4.1 extrieve cell values from cells grid
  Table creatureTable = new Table();
    for (int i = startX; i < endX+1; i++) {
      
      creatureTable.addColumn((i-startX)+"", Table.INT);
      for (int j = startY; j < endY+1; j++) {
        
         

         creatureTable.setInt((j-startY), (i-startX), cells[i][j]);
        // *********** we do not remember saveLocation to bring creatureGrid back to cells **********
               //table.setInt((i-startX), (j-startY), creatureGrid[i-startX][j-startY]);
      }
    }
    
    //int s = second();  
    //int m = minute();  
    //int h = hour(); 
    saveTable(creatureTable, "data/simpleCreature1.csv");
  captureMode = !captureMode;
  
  }
}
  
  // ************* 5. save creatureGrid values into creatureString ***************
  // ignore the absolute value of startX, startY, endX, endY; 
  // ignore location of creatureSquare in cells grid;
  // only care about their internal distance: 
  // number/length of cols of creatureSquare = endX-startX+1
  // number/length of rows of creatureSquare = endY-startY+1
  // number of rows before a creature's cell (creatureSquare[I][J] or cells[i][j]) = j-startY
  // length of cols to the creature's cell (creatureSquare[I][J] or cells[i][j]) = i-startX+1
  // total length of cells to get to a particular creature cell = (j-startY)*(endX-startX+1)+(i-startX+1)
  // index of this particular cell = (j-startY)*(endX-startX+1)+(i-startX+1)-1
  // int[] creatureString
  
  // ********** PROBLEM IS HERE ********************
    //creatureString = new String[(endX-startX+1)*(endY-startY+1)];
    //for (int i = startX; i < (endX+1); i++) {
    //  for (int j = startY; j < (endY+1); j++) {
    //    // ***********  here everything seems fine *************
    //    println(cells[i][j]); 
        
    //    // something wrong here ************************ ??????????????????????
    //    creatureString[(i-startX)*(j-startY+1)+(j-startY)] = cells[i][j] + "";
        
    //  }
    //}
  
  ////  ******************* 6. save creatureString into .txt *******************
  
    //int s = second();  
    //int m = minute();  
    //int h = hour(); 
    
    //saveStrings("assets/data/creature"+m+"-"+s+".txt", creatureString);
    
    //captureMode = !captureMode;
   
   