


  // ************************2.2 give each cell a random life and death value ************************
  
void randomizeCellsGrid() {
  // loop through every cell in grid
  // x, y are index of cells, not index of pixels
  for (int x=0; x<width/cellSize; x++) {              
   for (int y=0; y<height/cellSize; y++) {           

     // each cell has its own (x,y) and its own random number: state
     float state = random (100);        

     // if its state > probabilityOfAlive(15)  ---> meaning 
     // ---> if among all cells, its probability of being chosen is above 15%
     if (state > probabilityOfAliveAtStart) {         

       // then this cell is declared death --> set it's value 0
       state = 0;
        
     } else {  // if its probability of being chosen is below or equal 15%                             
       // then it is declared alive and set value = 1
       state = 1;
     }

     // let's find a place for each cell and record their values inside cells[x][y]
     cells[x][y] = int(state);
    
   }
  }
}