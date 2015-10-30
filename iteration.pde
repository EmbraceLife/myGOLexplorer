/*
What should iteration function do? 

simply: update value of each cell for next time drawing cells

1. copy all values of cells into cellsBuffer
2. looping through every cell: 
  2.1 loop through every cell's neighbour and sum up alive cells (excluding itself)
  2.2 for each cell, apply rule 4 rules:
      2.2.1 -> if this cell is alive:
            2.2.1.1 -> if this cell's alive neighbours are less than 2 or more than 3:
                      -> then make it dead
            2.2.1.2 -> if not --> meaning alive neighbours are either 2 or 3
                      -> then nothing happens --> leave it alone
      2.2.2 if this cell is dead:
            2.2.2.1 -> if this cell's alive neighbours are exactly 3:
                      -> then make this cell alive
            2.2.2.2 -> if not --> meaning not exactly 3 alive neighbours
                      -> then leave it dead alone


*/



void iteration() { 
  
  
 // *************************** 1. save a copy to buffer first, then iterate ***************************

 // Save cells to buffer (so we opeate with one array keeping the other intact)
 for (int x=0; x<(width-1)/cellSize; x++) {
   for (int y=0; y<(height-1)/cellSize; y++) {
     cellsBuffer[x][y] = cells[x][y];
   }
 }

 //  ****************************** 2. Visit each cell: *********************************************
 for (int x=0; x<(width-1)/cellSize; x++) {
   for (int y=0; y<(height-1)/cellSize; y++) {
      
      
     // ************************ 2.1 sum up alive neighbours for each cell ************************
      
     // declare num of neighbours, initial value = 0
     int neighbours = 0; 
      
      
     // ************ first We'll count the neighbours
      
     // if count a cell's column is at x, there are three columns to count neighbours: x-1, x, x+1
     for (int xx=x-1; xx<=x+1;xx++) {
        
       // if the cell's row is at y, there are three rows to count neighbours: y-1, y, y+1
       for (int yy=y-1; yy<=y+1;yy++) {  
          
         // ************ if (xx,yy) as neighbour cell's x and y are within grid, not outside
         if (((xx>=0)&&(xx<(width-1)/cellSize))&&((yy>=0)&&(yy<(height-1)/cellSize))) { 
           // Make sure you are not out of bounds, but it can be on the edge cell either 0 or 
           // width/cellSize-1 and height/cellSize-1 are edge cell lines
            
           // ************ Make sure to to check against self
           if (!((xx==x)&&(yy==y))) { 
              
             // ************ if a neighbour of bufferCells(cells as well) is alive, add 1 to neighbours
             if (cellsBuffer[xx][yy]==1){ 
               neighbours ++; 
             }
           } // End of if
         } // End of if
       } // End of yy loop
     } //End of xx loop  --  by now, all neighbours of a single cell are checked
      
      
      
     // *************************** 2.2 then apply rules for iterating generations ***************************
     // using cellsBuffer to check out values of cell
      
      
     // ************************ rule 2.2.1
      
     // ************ if a cell's value if alive 1
     if (cellsBuffer[x][y]==1) { 
      
       //************ also there are either less than 2 or more than 3 neighbours alive
       if (neighbours < 2 || neighbours > 3) { 
          
         // ************ make this cell on cells die, not this cell on cellsBuffer
         cells[x][y] = 0; 
       }
        
        // for neighbours == 2 || neighbours == 3, cells[x][y] = 1 is ignored or as default  ????
     } 
      
     // ************************ rule 2.2.2
     else { // if the cell in cellsBuffer is dead  
      
       // and if its neighbours have exactly three alive
       if (neighbours == 3 ) { 
        
         // make this cell on cells alive
         cells[x][y] = 1; 
       }
        
       // for neighbours != 3, cells[x][y] = 0 remain the same is ignored or thought as default ????
        
     } // End of if
   } // End of y loop
 } // End of x loop        --> by now, all neighbours of all cells are checked
} // End of function