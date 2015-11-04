 //<>// //<>// //<>//



void iteration() { 


 // save cells to cellsBuffer before every iteration
 for (int x=0; x<nx; x++) {
   for (int y=0; y<ny; y++) {
     cellsBuffer[x][y] = cells[x][y];
   }
 }

 // for every cell
 for (int x=0; x<nx; x++) {
   for (int y=0; y<ny; y++) {

     // number of its neighbours set 0 at first
     int neighbours = 0; 

     // loop around each cell to count up its living neighbours
     for (int xx=-1; xx<=1; xx++) { //<>// //<>//

       int px = (x + xx + nx) % nx;

       for (int yy=-1; yy<=1; yy++) {  

          int py = (y + yy + ny) % ny;
           
           // as long as neighbour position is not the same as cell(x,y)
           if (px != x || py != y) { 
             // if a neighbour's value is 1, set count it as adding 1
             if (cellsBuffer[px][py]==1) { 
               neighbours++;  //<>//
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
       } 
     } else { // if it is dead 

       // but if its living neighbour are exactly 3, then make it alive
       if (neighbours == 3 ) { 
         cells[x][y] = 1;
       } 
     }
   }
 }
}// 