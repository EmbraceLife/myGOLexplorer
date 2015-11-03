/*
1. space: pause/ continue
 2. c/C : clear up grid
 3. r/R : reset a new random grid
 4. z/Z : display red square, move mouse to select an area you want to zoom in
 5. x/X : remember the area you selected
 6. e/E : zoom in the area with full canvas
 7. click to change life/death status of cells in zoom-in grid
 8. s/S : save the changes 
 9. e/E : zoom out 
 10. space: to run or continue iterations on altered grid
 11. n: to allow iteration step by step
 11. press "1": run an iteration every 100 millis
 12. press "2": run an iteration every 50 millis
 13. press "3": run an iteration every 10 millis
 14. press other keys: 100 millis every iteration
 
 
 */
//*****************************************************************************************************************************
// ************************* set up global variables for use *************************
//*****************************************************************************************************************************

// 1. there must be cells: cellSize, enlargedSize(for selectedSquare)...
// 2. there must be grids: cells, cellsBuffer, selectedSquare, selectedSquareBuffer
// 3. there must be key location to remember: saveLocationX, saveLocationY for origin of selectedSquare in cells
// 4. there must set probability of alive cells at initial stage: probabilityOfAliveAtStart
// 5. there must set speed of regeneration of all cells: interval, lastRecordedTime
// 6. there must differ alive and death color: alive, dead
// 7. there must be many toggle buttons: pause, enlarge, referenceLocation, makeSelection, iterateStepy


    
    




Table creature1;

int R = 0;
int C = 0;
int[][] creatureGrid1 = new int[C][R];



//****************** 1. cellSize and enlargeSize 
// Size of cells = 5 pixels X 5 pixel = Is it right            ????
int cellSize = 5;
// size for enlarged selected areas
int enlargeSize = cellSize * 2;

int xZoom = 0;
int yZoom = 0;




// *************** 2. start and end points of creatureGrid
int startX = 1;
int startY = 1;
int endX = 2;
int endY = 2;
//int xCellOver, yCellOver;

//****************** 3. saveLocationX, saveLocationY
// when select an area, we need to remember/buffer the mouse Over location for cells
int saveLocationX;
int saveLocationY;



//****************** 4. probabilityOfAliveAtStart 
// How likely for a cell to be alive at start (in percentage)
float probabilityOfAliveAtStart = 15;



// ****************** 5. interval, lastRecordedTime
// Variables for timer                                   ????
int interval = 100;
int lastRecordedTime = 0;



// ****************** 6. Colors for active/inactive cells
//color alive = color(200, 0, 200); // make alive cells pink
color alive = color(random(255), random(255), random(255));      // make it shining
color dead = color(0);



// ****************** 2. cells, cellsBuffer, selectedSquare, selectedSquareBuffer 
// 1. building grids
// Array of cells = to create a grid = the largest grid with smallest cells
int[][] cells; 
// array of cells for selected area
int[][] selectedSquare;

// 2. copy or reference for cells and selectedSquare arrays
// Buffer to record the state of the cells and use this while changing the others in the interations
int[][] cellsBuffer; 
int[][] selectedSquareBuffer;

//// 3. creatureGrid for selected creature square; creatureString for turning grid into string array
int[][] creatureGrid;
String[] creatureString;


// ******************7. building toggles
// Pause = a special mechanism                       ????
boolean pause = false;
boolean enlarge = false;
boolean referenceLocation = false;  // key location to be remembered
boolean makeSelection = false; // key button to instantiate selectedSquare from cells
boolean iterateStepy = false; // key to allow iteration steps
boolean captureMode = false; // press p to toggle captureMode
boolean recordEndPoint = false; // press w to toggle
boolean recordStartPoint = false; // press q to toggle
//boolean debugStartEnd = false; // press d to debug by println
boolean releaseCreatureMode = false; // press m to toggle releaseCreatureMode
boolean loadCreatureMode = false; // press l to toggle loadCreatureMode
// ***********************************************************************************************
// ***************************  what you want in setup()  ***********************************************
// ************************************************************************************************************


/*  
 1. make up your mind on the size of canvas
 2. setupGrids:  --> only set value for each cell in grids 
   2.1 instantiate the cols and rows of grids: cells and cellsBuffer
   2.2 specify each value of cells of grids: 
     below15% chance to be alive (value 1), more than 15% chance dead (value 0)
   2.3 shall we create selectedSquare and selectedSquareBuffer here too ????????????
 3. draw initial environment:  --> using values to draw all cells on grid
 4. set pause to be true, stop iteration at beginning
 
 */

void setup() {

  // setup Canvas, cells grid, and selectedSquare grid
  size (601, 601);                            

  cells = new int[(width-1)/cellSize][(height-1)/cellSize];        
  cellsBuffer = new int[(width-1)/cellSize][(height-1)/cellSize];
  //cellsBuffer = cells;   <-- This is problematic!!!


  selectedSquare = new int[(width-1)/cellSize/2][(height-1)/cellSize/2];
  selectedSquareBuffer = new int[(width-1)/cellSize/2][(height-1)/cellSize/2];
  
  
  noSmooth();                                 


  // *****************2.2 give each cell a random life and death value ************************
  randomizeCellsGrid();
  


  // *****************  3. let's draw cell grids1 ************************** 
  drawCellsGrid(cellSize, cells);



  // ****************** 4. pause iteration ****************************
  pause = !pause;
}



// ***********************************************************************************************
// ******************** let's draw something ************************************************************
// ***********************************************************************************************

/*
1. when to iterate: when pause is false, iterate; otherwise, no iteration      
 2. press spacebar to pause
 3. press c to clear grid
 4. press r to reset grid
 5. press and hold z to display red square for area selected while mouse is moving
 6. press x to create the selectedSquare grid 
 7. press e to toggle 'enlarge' (switch to draw the selectedSquare grid to full canvas)
 8. click to change life and dead status of cells in seletedSquare gird
 9. press s to save changed status into selectedSquare grid and save selectedSquare grid into cells grid
 10. press e to change 'enlarge' status (switch to draw cells grid on full canvas)
 11. press 1, 2, 3, to toggle between three different speed of iteration
 
 
 */

void draw() {


  // ************************ auto-iterate frequency, or iterate by hand ************************
  //global parameter: interval, pause, iterateStepy
  iterateFrequency();
 


  // let's draw the grid
  drawCellsGrid(cellSize, cells);

  // press 'z' to draw a mouse-moving-selecting red square upon it 
  displaySelectedArea();

 
  // press x to record the selected square
  // press e to zoom the selected to full canvas (drawing the selected to full canvas)  
  createSelectedSquareBasedOnCells();


  // *******mouse click to change cell status *********************

  if (pause && mousePressed) {  
    
    // under enlarge mode, click to change cell status in selectedSquare
    if (enlarge) {
      changeCellStatus(enlargeSize, selectedSquareBuffer, selectedSquare);

    // if not, change for cell status in cells grid
    } else {
      changeCellStatus(cellSize, cellsBuffer, cells);
  
    }
  }


  // press s to insert changed selected square back to cells
  // press e to toggle enlarge mode false, go back to draw cells grid
  insertSelectedSquareBackToCells();
   
   
   
  // while pause true and there is no mouseClick
  // update cells and selectedSquares to cellsBuffer and selectedSquareBuffer
  updateBuffersWithGrids();

  
  
  // ************ ************ step 7: capturing and display creatures ************ ************ ************ 
  // capture and save creature String into txt

    
    captureCreatures();
    
    //if (debugStartEnd) {
    //  println("startX:", startX, "; startY:", startY, "; endX:", endX, "; endY:", endY);
      
    //  for (int i = 0; i < creatureString.length-1; i++) {
        
    //    // ******** there are 0s and 1s and a lot of Nulls ************* why ??????????
    //    println("value ", i, ":", creatureString[i]);
    //  }
    //  debugStartEnd = !debugStartEnd;
    //}
    
    releaseCreature();
  
}


// ***********************************************************************************************
// *******************************special function keyPressed *****************************
// ***********************************************************************************************

/*
1. press 1, 2, 3 to switch between different speeds
 2. press s to toggle referenceLocation true
 3. press e to toggle enlarge
 4. press x to toggle makeSelection
 5. press r to reset cells grid for a new randomized state
 6. press c to clean up or set values of cells to 0 in cells grid
 7. press spacebar to toggle pause
 8. press n to allow iteration step by step
 
 
 */

void keyPressed() {
  

    
  
  
  
 if (pause) {
   
   if (key == 'w' || key == 'W') {
     recordEndPoint = !recordEndPoint;
   }
   
   if (key == 'q' || key == 'Q') {
     recordStartPoint = !recordStartPoint;
   }
   
   //if (key == 'd' || key == 'D') {
   //  debugStartEnd = !debugStartEnd;
   //}
   
   if (key == 'm' || key == 'M') {
    releaseCreatureMode = !releaseCreatureMode;
    }
    
   if (key == 'l' || key == 'L') {
     loadCreatureMode = !loadCreatureMode;
   }
 }

 // *************** press p to toggle captureMode
 if (pause) {
   
   if (key == 'p' || key == 'P') {
     
     captureMode = !captureMode;
     
   }
 }
  
  
 // *************** press n to iterate step by step ********************* 
 if (pause) {

   if (key == 'n' || key == 'N') {
      
     
        
       iterateStepy = !iterateStepy;
       
       //println("iterateStepy is set ", iterateStepy);
     
   }
 }



  // ***************** 1. speedup 1, 2, 3 to from 100mills interval to 50mills and 10mills ***********

  if (key == '1') {
    interval = 100;
  } else if (key == '2') {
    interval = 50;
  } else if (key == '3') {
    interval = 10;
  } else {
    interval = 100;
  }

  // *********************** 2. press s to toggle referenceLocation true *************
  // using saveLocationX, saveLocationY to insert selectedSquare grid back into appropriate place of cells grid
  // after insertion, cells grid can be drew 
  if (key == 's' || key == 'S') {
    referenceLocation = !referenceLocation;
    
    
  } 



  // **********************************3. press e to toggle enlarge *******************************************
  if (key == 'e' || key == 'E') {                         //  press spacebar to toggle pause
    enlarge = !enlarge;
  }



  // ******************** 4. press x to toggle 'makeSelection' *********************
  // with pause, press x to create and instantiate selectedSquare/Buffer
  // 1. actually, we can make x to toggle 'makeSelection' true
  // 2. when pause + makeSelection, create, instantiate and draw selectedSquare in step 2 part 1

  if (pause) {
    if (key == 'x' || key == 'X') {

      makeSelection = !makeSelection;
    }
  }


  // ************ 5. press r to reset each cell in the grid a new random value ************


  if (key=='r' || key == 'R') {  // press R or r to reset a random initial grid

    // Restart: reinitialization of cells

    randomizeCellsGrid();
    
    
  }

  // ************************ use space to toggle pause ************************
  if (key==' ') {                         //  press spacebar to toggle pause
    pause = !pause;
  }

  // ************************ press c to set all cells to death value ************************

  if (key=='c' || key == 'C') {               // press C or c to Clear all
    for (int x=0; x<(width-1)/cellSize; x++) {
      for (int y=0; y<(height-1)/cellSize; y++) {
        cells[x][y] = 0; // Save all to zero
      }
    }
  }
}