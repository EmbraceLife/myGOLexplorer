
//// this function goes inside void setup() {}

//// 2. setupGrids: 
//// 2.1 instantiate the cols and rows of grids: cells and cellsBuffer
//// 2.2 specify each value of cells of grids: 
//// below15% chance to be alive, more than 15% chance dead
//// 2.3 shall we create selectedSquare and selectedSquareBuffer here too ????????????


//void setupGrids() {

//  // ****************** 2.1 Instantiate cells and cellsBuffer grids
//  // create a grid with specified number of cols and rows
//  // columns = width/cellSize; rows = height/cellSize; size of cell = 5pixel x 5pixel

//  cells = new int[width/cellSize][height/cellSize];        

//  // Instantiate cells buffer: just cope cells content

//  cellsBuffer = new int[width/cellSize][height/cellSize];

//  // don't hide edges/ jaggs
//  // noSmooth();                                 


//  // ************************2.2 give each cell a random life and death value ************************
//  // loop through every cell in grid
//  // x, y are index of cells, not index of pixels
//  for (int x=0; x<width/cellSize; x++) {              
//    for (int y=0; y<height/cellSize; y++) {           

//      // each cell has its own (x,y) and its own random number: state
//      float state = random (100);        

//      // if its state > probabilityOfAlive(15)  ---> meaning 
//      // ---> if among all cells, its probability of being chosen is above 15%
//      if (state > probabilityOfAliveAtStart) {         

//        // then this cell is declared death --> set it's value 0
//        state = 0;
//      } else {  // if its probability of being chosen is below or equal 15%                             
//        // then it is declared alive and set value = 1
//        state = 1;
//      }

//      // let's find a place for each cell and record their values inside cells[x][y]
//      cells[x][y] = int(state);
//    }
//  }

//  // draw black background only once, as later we are dealing with each cell's color 
//  // we don't need to draw background in every run/frame
//  //background(200);
//}