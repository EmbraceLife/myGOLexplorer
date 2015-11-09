// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class GOL {

  GOLdata data;


  GOL() {

    data = new GOLdata();
    regenerateRandomCellsInGrid();
  }

  void regenerateRandomCellsInGrid() {
    for (int i = 0; i < data.columns; i++) {
      for (int j = 0; j < data.rows; j++) {
        data.board[i][j] = new Cell(i*data.w, j*data.w, data.w);
        //data.board[i][j].display();
      }
    }
  }


  // The process of creating the new generation
  void generate() {
    for ( int i = 0; i < data.columns; i++) {
      for ( int j = 0; j < data.rows; j++) {
        data.board[i][j].savePrevious();
      }
    }


    // Loop through every spot in our 2D array and check spots neighbors
    for (int x = 0; x < data.columns; x++) {
      for (int y = 0; y < data.rows; y++) {

        // Add up all the states in a 3x3 surrounding grid
        int neighbors = 0;
        for (int i = -1; i <= 1; i++) {
          for (int j = -1; j <= 1; j++) {
            neighbors += data.board[(x+i+data.columns)%data.columns][(y+j+data.rows)%data.rows].previous;
          }
        }

        // A little trick to subtract the current cell's state since
        // we added it in the above loop
        neighbors -= data.board[x][y].previous;

        // Rules of Life
        if      ((data.board[x][y].state == 1) && (neighbors <  2)) data.board[x][y].newState(0);           // Loneliness
        else if ((data.board[x][y].state == 1) && (neighbors >  3)) data.board[x][y].newState(0);           // Overpopulation
        else if ((data.board[x][y].state == 0) && (neighbors == 3)) data.board[x][y].newState(1);           // Reproduction
        // else do nothing!
      }
    }
  }



  //// This is the easy part, just draw the cells, fill 255 for '1', fill 0 for '0'
  void display() {


    for ( int i = 0; i < data.columns; i++) {
      for ( int j = 0; j < data.rows; j++) {
        data.board[i][j].display();
      }
    }
  }

  void displaySelectedSquare() {
    if (data.displaySelectedToggle) { 
      for ( int i = 0; i < data.selectedWidth; i++) {
        for ( int j = 0; j < data.selectedWidth; j++) {
          data.selectedSquare[i][j].display();
        }
      }
    }
  }


  void generationAtFrequency() { 
    // int lastRecordedTime = 0; // every run it will be 0 again, it is not what I want
    int interval;

    if (!data.pauseToggle) {
      interval = millis()-data.lastRecordedTime;
      if (interval > data.generationDuration) {          
        //println("interval is ", interval);

        generate();  

        data.lastRecordedTime = millis();
        //println("lastRecordedTime", lastRecordedTime);
      }
    }
  }




  void generateByStep() {   

    if (data.pauseToggle && data.stepToggle) {
      // println(iterateStepy);
      generate(); 
      data.stepToggle = !data.stepToggle;
    } else {
      // nothing happens, no iteration
    }
  }

  void regenerateRandomCellsInGridPerform() {
    if (data.randomToggle) {
      regenerateRandomCellsInGrid();
      data.randomToggle = !data.randomToggle;
    }
  }


  /* How to make multiple method constructors
   */
  void displaySelectedArea() {

    if (keyPressed == true && data.pauseToggle) {
      if (key == 'z' || key == 'Z') {

        int xCellOver = int(map(mouseX, 0, width, 0, (width)/data.w));
        xCellOver = constrain(xCellOver, 0, (width)/data.w - data.selectedWidth);         

        int yCellOver = int(map(mouseY, 0, (height), 0, (height)/data.w));
        yCellOver = constrain(yCellOver, 0, (height)/data.w - data.selectedWidth);  

        stroke(200, 0, 150);
        noFill();
        rect(xCellOver*data.w, yCellOver*data.w, data.selectedWidth*data.w-1, data.selectedWidth*data.w-1);
      }
    }
  }



  void captureSelectedSquare() {  

    // ***** if xCellOver as local variable, every frame-run through this function, xCellOver is new

    // let mouse hovering on cells not on pixels
    int xCellOver = int(map(mouseX, 0, width, 0, (width)/data.w));

    xCellOver = constrain(xCellOver, 0, (width)/data.w-data.selectedWidth);         

    // mouseY or yCellOver can hover over any cell of cells grid, but not on pixels
    int yCellOver = int(map(mouseY, 0, height, 0, (height)/data.w));

    // constrain yCellOver/mouseY only hover on first half of rows of cells grid
    yCellOver = constrain(yCellOver, 0, (height)/data.w-data.selectedWidth);  



    if (data.selectToggle) {  
      for (int i = 0; i < data.selectedWidth; i++) {
        for (int j = 0; j < data.selectedWidth; j++) {
          data.selectedSquare[i][j] = new Cell(i*(width/data.selectedWidth), j*(width/data.selectedWidth), width/data.selectedWidth);
        }
      }


      // press x to remember the start point of selection square
      data.xZoom = xCellOver;
      data.yZoom = yCellOver;

      // record the selected square only once for all frame loops later
      for (int xCell=data.xZoom; xCell<data.xZoom+data.selectedWidth; xCell++) {
        for (int yCell=data.yZoom; yCell<data.yZoom+data.selectedWidth; yCell++) {

          data.selectedSquare[xCell-data.xZoom][yCell-data.yZoom].state = data.board[xCell][yCell].state;
          data.selectedSquare[xCell-data.xZoom][yCell-data.yZoom].savePrevious();
          //data.selectedSquare[xCell-data.xZoom][yCell-data.yZoom].display();
        }
      }
      data.selectToggle = !data.selectToggle;
    }
  }

  // // press e to draw the selected square on full canvas
  // if (data.enlargeToggle) {


  //     // ********* let saveLocationX and Y to remember the selected (mouseX, mouseY) or (xCellOver,yCellOver) 
  //     saveLocationX = xZoom;
  //     saveLocationY = yZoom;



  //     // draw the selected square
  //     data.selectedSquare.


  //     // console: zoom x y coordinates
  //     int xCellOverZoom = int(map(mouseX, 0, width-1, 0, (width-1)/enlargeSize));
  //     int yCellOverZoom = int(map(mouseY, 0, height-1, 0, (height-1)/enlargeSize));
  //     println("zoom ", xCellOverZoom, ":", yCellOverZoom);


  // }

  //}


  void displaySelectedSquareControl() {
    if (key == 'e' || key == 'E') {
      data.displaySelectedToggle = !data.displaySelectedToggle;
    }
  }




  void selectControl() {
    if (key == 'x' || key == 'X') {
      data.selectToggle = !data.selectToggle;
    }
  }

  void generationDurationControl() { 

    if (key == '1') {
      data.generationDuration = 100;
    } else if (key == '2') {
      data.generationDuration = 50;
    } else if (key == '3') {
      data.generationDuration = 10;
    } else {
      data.generationDuration = 100;
    }
  }

  void randomControl() {
    if (key == 'r' || key == 'R') {
      data.randomToggle = !data.randomToggle;
    }
  }

  void stepControl() {

    if (key == 'n' || key == 'N') {
      data.stepToggle = !data.stepToggle;
    }
  }


  void pauseControl() {
    if (key == ' ') {
      data.pauseToggle = !data.pauseToggle;
    }
  }
}