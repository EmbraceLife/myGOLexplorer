
// under enlarge Mode to capture creatures
void captureCreatures() {
  
  if (enlarge) {
    
      // ********* 2. mouse hovering to choose a starting point to click/record ********* 
       int xCellOver = int(map(mouseX, 0, width, 0, (width-1)/enlargeSize));     
       int yCellOver = int(map(mouseY, 0, height, 0, (height-1)/enlargeSize));
    
    
    
     // press 'q' to record start point
       if (pause && recordStartPoint) {
         startX = xCellOver;
         startY = yCellOver;
         recordStartPoint = !recordStartPoint;
       }
       
     // *******draw capture rect with 'a' and mouse moving ***********  
       if (keyPressed == true && pause) {
           
            if (key == 'a' || key == 'A') {
             // as long as 'a' is pressed, ending point is following mouse hovering, and rect is drew
             
               stroke(0, 200, 150);
               noFill();
               
               rect(startX*enlargeSize, startY*enlargeSize, (xCellOver-startX+1)*enlargeSize, 
                   (yCellOver-startY+1)*enlargeSize);
            }
       }
    
      
      // press 'w' to record the end point
        if (recordEndPoint && pause) {
          endX = xCellOver;
          endY = yCellOver;
          recordEndPoint = !recordEndPoint;
        }
     
     
    
    
      if (captureMode && pause) {
      
      
      // 4.1 extrieve cell values from selectedSquare grid
      Table creatureTable = new Table();
        for (int i = startX; i < endX+1; i++) { 
          creatureTable.addColumn((i-startX)+"", Table.INT);
          
          for (int j = startY; j < endY+1; j++) {
            creatureTable.setInt((j-startY), (i-startX), selectedSquare[i][j]); // ***** table and grid reverse 
          }
        }
        
    
        saveTable(creatureTable, "data/simpleCreature1.csv");
      captureMode = !captureMode;
      
      }
  }
}
 