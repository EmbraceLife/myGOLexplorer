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
// 7. there must be many toggle buttons: pause, enlarge



//****************** 1. cellSize and enlargeSize 
// Size of cells = 5 pixels X 5 pixel = Is it right            ????
int cellSize = 5;
// size for enlarged selected areas
int enlargeSize = cellSize * 2;



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



// ******************7. building toggles
// Pause = a special mechanism                       ????
boolean pause = false;
boolean enlarge = false;
boolean referenceLocation = false;  // key location to be remembered
boolean makeSelection = false; // key button to instantiate selectedSquare from cells
boolean iterateStepy = false; // key to allow iteration steps
// ***********************************************************************************************
// ***************************  what you want in setup()  ***********************************************
// ************************************************************************************************************


/*  
 1. make up your mind on the size of canvas
 2. setupGrids:  --> only set value for each cell in grids 
 (if make it a function, performance is going down!!!!!!!!!!!!!!!!!!!! check z function)
 2.1 instantiate the cols and rows of grids: cells and cellsBuffer
 2.2 specify each value of cells of grids: 
 below15% chance to be alive (value 1), more than 15% chance dead (value 0)
 2.3 shall we create selectedSquare and selectedSquareBuffer here too ????????????
 3. draw initial environment:  --> using values to draw all cells on grid
 4. set pause to be true, stop iteration at beginning
 
 */

void setup() {

  // ****************** 1. create canvas
  // create canvas 600x600 pixels

  size (600, 600);                            


  // setupGrids();


  // ****************** 2.1 Instantiate cells and cellsBuffer grids
  // create a grid with specified number of cols and rows
  // columns = width/cellSize; rows = height/cellSize; size of cell = 5pixel x 5pixel

  cells = new int[width/cellSize][height/cellSize];        

  // Instantiate cells buffer: just cope cells content

  cellsBuffer = new int[width/cellSize][height/cellSize];


  selectedSquare = new int[width/cellSize/2][height/cellSize/2];
  selectedSquareBuffer = new int[width/cellSize/2][height/cellSize/2];
  // don't hide edges/ jaggs
  noSmooth();                                 


  // ************************2.2 give each cell a random life and death value ************************
  randomizeCellsGrid();
  //// loop through every cell in grid
  //// x, y are index of cells, not index of pixels
  //for (int x=0; x<width/cellSize; x++) {              
  // for (int y=0; y<height/cellSize; y++) {           

  //   // each cell has its own (x,y) and its own random number: state
  //   float state = random (100);        

  //   // if its state > probabilityOfAlive(15)  ---> meaning 
  //   // ---> if among all cells, its probability of being chosen is above 15%
  //   if (state > probabilityOfAliveAtStart) {         

  //     // then this cell is declared death --> set it's value 0
  //     state = 0;

  //   } else {  // if its probability of being chosen is below or equal 15%                             
  //     // then it is declared alive and set value = 1
  //     state = 1;
  //   }

  //   // let's find a place for each cell and record their values inside cells[x][y]
  //   cells[x][y] = int(state);

  // }
  //}

  // draw black background only once, as later we are dealing with each cell's color 
  // we don't need to draw background in every run/frame
  //background(200);


  // **************************  3. let's draw cell grids1 ************************** 
  drawCellsGrid(cellSize, cells);
  //for (int x=0; x<width/cellSize; x++) {              
  // for (int y=0; y<height/cellSize; y++) { 
  //   if (cells[x][y] == 1) {
  //     fill(alive);
  //   } else {
  //     fill(dead);
  //   }
  //   rect(x*cellSize, y*cellSize, cellSize, cellSize);
  // }
  //}

  // ****************** 4. set pause true to stop iteration to run automatically ****************************
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


  // ************************ step 1: iterate with a speed (when pause false) ************************
  // if pause toggle true, iteration won't run
  // if pause toggle false, iterate only update values of cells not drawing

  // Iterate if timer ticks                    run iteration function every 100mills 
  if (millis()-lastRecordedTime>interval) {          // if 100 mills passed since lastRecordedTime,
    if (!pause) {                         // if user didn't pause it
      iteration();                        // do iteration
      lastRecordedTime = millis();             // mark this moment as lastRecordedTime (for iteration)
    } else if (iterateStepy) {
      println(iterateStepy);
      iteration(); 
      iterateStepy = !iterateStepy;
    }
    
  }


  // ****************************** step 1.5 toggle x to instantiate selectedSquare grid ******************************
  if (makeSelection) {
    createSelectedSquareBasedOnCells();
    // ************ Important 1!!!!
    // without the following code, you have to press x again to stop creating new selectedSquare while
    // mouse is moving
    makeSelection = !makeSelection;
    //int xCellOver = int(map(mouseX, 0, width, 0, width/cellSize));

    // // constrain mouseX or xCellOver only hover the first half cols of cells grid, 
    // // also it cannot hover on the last col of first half
    // xCellOver = constrain(xCellOver, 0, width/cellSize/2-1);         

    // // mouseY or yCellOver can hover over any cell of cells grid, but not on pixels
    // int yCellOver = int(map(mouseY, 0, height, 0, height/cellSize));

    // // constrain yCellOver/mouseY only hover on first half of rows of cells grid
    // yCellOver = constrain(yCellOver, 0, height/cellSize/2-1);  

    // // *********** from (mouseX, mouseY) right 60, down 60, is selectedSquare grid
    // for (int xCell=xCellOver; xCell<xCellOver+60; xCell++) {
    //   for (int yCell=yCellOver; yCell<yCellOver+60; yCell++) {

    //     // ***********as xCellOver is fixed by mouseX, xCell-xCellOver = 0 to 60*************

    //     // *********** transfer values of cells grid to them
    //     selectedSquare[xCell-xCellOver][yCell-yCellOver] = cellsBuffer[xCell][yCell];
    //     selectedSquareBuffer[xCell-xCellOver][yCell-yCellOver] = cellsBuffer[xCell][yCell];
    //   }
    // }
    // //}
    // //}

    // // ******* debug see above code of assigning working or not
    // println("target1: " + selectedSquare[0][0]);
    // println("mouse1: " + cellsBuffer[xCellOver][yCellOver]);
    // println("target2: " + selectedSquare[0][1]);
    // println("mouse2: " + cellsBuffer[xCellOver][yCellOver+1]);
    // println("target3: " + selectedSquare[0][2]);
    // println("mouse3: " + cellsBuffer[xCellOver][yCellOver+2]);

    // // enlargeSize = cellSize*2;
    // //enlarge = !enlarge;

    // // ********* let saveLocationX and Y to remember the selected (mouseX, mouseY) or (xCellOver,yCellOver) 
    // saveLocationX = xCellOver;
    // saveLocationY = yCellOver;
  }


  // ************************** step 2: if enlarge toggled true, draw selectedSquare grid ************* 
  if (enlarge) {



    drawCellsGrid(enlargeSize, selectedSquare);

    //for (int x=0; x<width/enlargeSize; x++) {
    //  for (int y=0; y<height/enlargeSize; y++) {
    //    stroke(34);
    //    // if any cell's value is 1, give it color alive
    //    if (selectedSquare[x][y]==1) {                 
    //      fill(alive);
    //    } else { 
    //      // if this cell's value is not 1, give it color dead
    //      fill(dead);
    //    }

    //    rect(x*enlargeSize, y*enlargeSize, enlargeSize, enlargeSize);  

    //  }
    // }

    // println("drawing selectedSquare grid");

    // ************************** step 3: if enlarge toggled false, draw cells grid **************************

    // ************** here cells are drew with update from iteration
    // ************** pause true only stops iteration not drawing grids
  } else {

    // ******************* important Note: first press s to insert changed selectedSquare into cells grid
    // ***************** and second press s is to toggle referenceLocation false to 
    // ***************** prevent repeatedly insert the same selectedSquare back to cells grid after continue iteration
    if (referenceLocation) {



      // println("referenceLocation is true for updating cells grid");

      for (int x=0; x<width/enlargeSize; x++) {
        for (int y=0; y<height/enlargeSize; y++) {
          cells[saveLocationX+x][saveLocationY+y] = selectedSquare[x][y];
        }
      }
      
      // **********Important ******** this code is key to make any press of 's' only has one-time effect
      referenceLocation = !referenceLocation;
      //println("now update cells grid");
    }

    drawCellsGrid(cellSize, cells);
    // loop through every cell in grid, each cell is a 5x5 pixels
    //for (int x=0; x<width/cellSize; x++) {
    //  for (int y=0; y<height/cellSize; y++) {

    //    stroke(34);
    //    // if any cell's value is 1, give it color alive
    //    if (cells[x][y]==1) {                 
    //      fill(alive);
    //    } else { 
    //      // if this cell's value is not 1, give it color dead
    //      fill(dead);
    //    }

    //    // ************  given their colors above, draw each cell with a rect 
    //    // x*cellSize = rect.x in pixel; y*cellSize = rect.y in pixel 
    //    // (rect.x, rect.y) is origin point for rect
    //    rect (x*cellSize, y*cellSize, cellSize, cellSize);  

    //  }
    //}

    //// ******************** step4: select area by drawing square with mouse hovering *********************

    // ************** toggle 'select' true as one condition for selection 
    // ************** given both pause and select being true, begin drawing rect

    if (keyPressed == true && pause) {
      if (key == 'z' || key == 'Z') {

        displaySelectedArea();

        //      // make sure mouse hover/click to not pixel but cell with 5pixel on x-axis
        //      int xCellOver = int(map(mouseX, 0, width, 0, width/cellSize));

        //      // make sure the last column of cell will not be clicked/shown
        //      xCellOver = constrain(xCellOver, 0, width/cellSize/2-1);         

        //      // make sure mouse click refer not pixel but cell with 5 pixel on y-axis
        //      int yCellOver = int(map(mouseY, 0, height, 0, height/cellSize));

        //      // make sure the last row of cell will not be clicked/shown
        //      yCellOver = constrain(yCellOver, 0, height/cellSize/2-1);  


        //        stroke(200, 0, 150);
        //        noFill();
        //        rect(xCellOver*cellSize, yCellOver*cellSize, 60*cellSize, 60*cellSize);
      }
    }
  }



  // ************** step 5: if pause and mousePress true, to change cell status  ***************
  // 1. if enlarge toggle true, change cell status of selectedSquare grid
  // 2. if enlarge toggle false, change cell status of cells grid
  // through mouse click, cells grid's value is updated

  if (pause && mousePressed) {  
    if (enlarge) {

      changeCellStatus(enlargeSize, selectedSquareBuffer, selectedSquare);
      //// ************** define and constrain xCellOver, yCellOver with mouseX, mouseY in selectedSquare
      //int xCellOver = int(map(mouseX, 0, width, 0, width/enlargeSize));

      //// make sure the last column of cell will not be clicked/shown
      //xCellOver = constrain(xCellOver, 0, width/enlargeSize-1);         

      //// make sure mouse click refer not pixel but cell with 5 pixel on y-axis
      //int yCellOver = int(map(mouseY, 0, height, 0, height/enlargeSize));

      //// make sure the last row of cell will not be clicked/shown
      //yCellOver = constrain(yCellOver, 0, height/enlargeSize-1);        

      //// ************** click to change status of cells of selectedSquare 
      //// when mouse licked, it is cell being clicked
      //// xCellOver, yCellOver --> cell.index.x and cell.index.y
      //// for the cell being clicked, if its buffer copy value = 1 alive, then set its value in cells dead
      ////if (selectedSquare[xCellOver][yCellOver] == selectedSquareBuffer[xCellOver][yCellOver]) {
      //if (selectedSquareBuffer[xCellOver][yCellOver]==1) { 
      //  selectedSquare[xCellOver][yCellOver]=0; // buffer copy is done when pause the iteration
      //  fill(dead); // Fill with kill color
      //} else { // if its buffer copy value is not 1, then set its cells' value as 1
      //  selectedSquare[xCellOver][yCellOver]=1; 
      //  fill(alive); // Fill alive color
      //}

      //println("enlarge is ", enlarge, " for change cell status for selectedSquare");




      // ************** define and constrain xCellOver, yCellOver with mouseX, mouseY in cells grid
    } else {
      // ******** how to make mouse click on cell not on pixel ********
      // ******** now click to change death and life status of cells' cell **********
      // ******** then above drawing code will draw the updated cells grid *********
      // make sure mouse hover/click to not pixel but cell with 5pixel on x-axis

      changeCellStatus(cellSize, cellsBuffer, cells);

      //int xCellOver = int(map(mouseX, 0, width, 0, width/cellSize));

      //// make sure the last column of cell will not be clicked/shown
      //xCellOver = constrain(xCellOver, 0, width/cellSize-1);         

      //// make sure mouse click refer not pixel but cell with 5 pixel on y-axis
      //int yCellOver = int(map(mouseY, 0, height, 0, height/cellSize));

      //// make sure the last row of cell will not be clicked/shown
      //yCellOver = constrain(yCellOver, 0, height/cellSize-1);        

      //// ********* click to change status of cell in cells **********
      //// when mouse licked, it is cell being clicked
      //// xCellOver, yCellOver --> cell.index.x and cell.index.y
      //// for the cell being clicked, if its buffer copy value = 1 alive, then set its value in cells dead
      //if (cellsBuffer[xCellOver][yCellOver]==1) { 
      //  cells[xCellOver][yCellOver]=0; // buffer copy is done when pause the iteration
      //  fill(dead); // Fill with kill color
      //} else { // if its buffer copy value is not 1, then set its cells' value as 1
      //  cells[xCellOver][yCellOver]=1; 
      //  fill(alive); // Fill alive color
      //}

      //println("enlarge is ", enlarge, " for changing cell status in cells grid");
    }
  }


  // **************************** step 6: pause toggle true, copy cells for cellsBuffer****************************
  // ************************ pause only to cope cells to bufferCells ************************
  // ************************ through pause, cells grid values are copied to bufferCells grid 
  else if (pause && !mousePressed) { // if pause and not yet press mouse, copy current cells to buffer
    //else if (pause) {
    // Save cells to buffer (so we opeate with one array keeping the other intact)
    updateBuffersWithGrids();
    //for (int x=0; x<width/cellSize; x++) {
    //  for (int y=0; y<height/cellSize; y++) {
    //    cellsBuffer[x][y] = cells[x][y];      // copy cells exact to cellsBuffer
    //  }
    //}

    //for (int x=0; x<width/enlargeSize-1; x++) {
    //  for (int y=0; y<height/enlargeSize-1; y++) {
    //    selectedSquareBuffer[x][y] = selectedSquare[x][y];
    //  }
    //}
  }
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

   if (key == 'n' || key == 'N') {
      
     
        
       iterateStepy = !iterateStepy;
       
       println("iterateStepy is set ", iterateStepy);
     
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
    //println("at toggle: referenceLocation is ", referenceLocation);

    //for (int x=0; x<width/enlargeSize; x++) {
    //  for (int y=0; y<height/enlargeSize; y++) {
    //     cells[saveLocationX+x][saveLocationY+y] = selectedSquare[x][y];
    //  }
    //}
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
    //for (int x=0; x<width/cellSize; x++) {
    //  for (int y=0; y<height/cellSize; y++) {

    //    // randomize the life and death of each cell
    //    float state = random (100);
    //    if (state > probabilityOfAliveAtStart) {
    //      state = 0;
    //    } else {
    //      state = 1;
    //    }
    //    cells[x][y] = int(state); // Save state of each cell
    //  }
    //}
  }

  // ************************ use space to toggle pause ************************
  if (key==' ') {                         //  press spacebar to toggle pause
    pause = !pause;
  }

  // ************************ press c to set all cells to death value ************************

  if (key=='c' || key == 'C') {               // press C or c to Clear all
    for (int x=0; x<width/cellSize; x++) {
      for (int y=0; y<height/cellSize; y++) {
        cells[x][y] = 0; // Save all to zero
      }
    }
  }
}