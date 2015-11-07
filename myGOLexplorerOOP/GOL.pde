// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class GOL {

  int w = 5;
  int columns, rows;
  int generationDuration = 100; // used by two methods
  int lastRecordedTime;
  boolean stepToggle;
  boolean pauseToggle;
  boolean randomToggle;

  // Game of life board
  Cell[][] board;


  GOL() {
    // Initialize rows, columns and set-up arrays
    columns = width/w;
    rows = height/w;
    stepToggle = false;
    pauseToggle = true;
    randomToggle = false;
    board = new Cell[columns][rows];
    randomizeGrid();
  }

  void randomizeGrid() {
    for (int i = 0; i < columns; i++) {
      for (int j = 0; j < rows; j++) {
        board[i][j] = new Cell(i*w, j*w, w);
      }
    }
  }

  // The process of creating the new generation
  void generate() {
    for ( int i = 0; i < columns; i++) {
      for ( int j = 0; j < rows; j++) {
        board[i][j].savePrevious();
      }
    }


    // Loop through every spot in our 2D array and check spots neighbors
    for (int x = 0; x < columns; x++) {
      for (int y = 0; y < rows; y++) {

        // Add up all the states in a 3x3 surrounding grid
        int neighbors = 0;
        for (int i = -1; i <= 1; i++) {
          for (int j = -1; j <= 1; j++) {
            neighbors += board[(x+i+columns)%columns][(y+j+rows)%rows].previous;
          }
        }

        // A little trick to subtract the current cell's state since
        // we added it in the above loop
        neighbors -= board[x][y].previous;

        // Rules of Life
        if      ((board[x][y].state == 1) && (neighbors <  2)) board[x][y].newState(0);           // Loneliness
        else if ((board[x][y].state == 1) && (neighbors >  3)) board[x][y].newState(0);           // Overpopulation
        else if ((board[x][y].state == 0) && (neighbors == 3)) board[x][y].newState(1);           // Reproduction
        // else do nothing!
      }
    }
  }



  // This is the easy part, just draw the cells, fill 255 for '1', fill 0 for '0'
  void display() {
    for ( int i = 0; i < columns; i++) {
      for ( int j = 0; j < rows; j++) {
        board[i][j].display();
      }
    }
  }



  void generationAtFrequency() { 
    // int lastRecordedTime = 0; // every run it will be 0 again, it is not what I want
    int interval;

    if (!pauseToggle) {
      interval = millis()-lastRecordedTime;
      if (interval > generationDuration) {          
        //println("interval is ", interval);

        generate();  

        lastRecordedTime = millis();
        //println("lastRecordedTime", lastRecordedTime);
      }
    }
  }




  void generateByStep() {   

    if (pauseToggle && stepToggle) {
      // println(iterateStepy);
      generate(); 
      stepToggle = !stepToggle;
    } else {
      // nothing happens, no iteration
    }
  }

  void randomizeGridPerform() {
    if (randomToggle) {
      randomizeGrid();
      randomToggle = !randomToggle;
    }
    
  }

  void generationDurationControl() { 

    if (key == '1') {
      generationDuration = 100;
    } else if (key == '2') {
      generationDuration = 50;
    } else if (key == '3') {
      generationDuration = 10;
    } else {
      generationDuration = 100;
    }
  }

  void randomControl() {
    if (key == 'r' || key == 'R') {
      randomToggle = !randomToggle;
    }
  }

  void stepControl() {

    if (key == 'n' || key == 'N') {
      stepToggle = !stepToggle;
    }
  }


  void pauseControl() {
    if (key == ' ') {
      pauseToggle = !pauseToggle;
    }
  }


  /* How to make multiple method constructors
   */
  void displaySelectedArea(int selectedWidth, int selectedHeight) {

    if (keyPressed == true && pauseToggle) {
      if (key == 'z' || key == 'Z') {

        int xCellOver = int(map(mouseX, 0, width, 0, (width)/w));
        xCellOver = constrain(xCellOver, 0, (width)/w - selectedWidth);         

        int yCellOver = int(map(mouseY, 0, (height), 0, (height)/w));
        yCellOver = constrain(yCellOver, 0, (height)/w - selectedHeight);  

        stroke(200, 0, 150);
        noFill();
        rect(xCellOver*w, yCellOver*w, selectedWidth*w-1, selectedHeight*w-1);
      }
    }
  }

  /* How to constrain the effective area for mouseX, mouseY
   How to press key to perform a function
   */
  void displaySelectedArea() {
    int selectedWidth = 60;
    int selectedHeight = 60;
    if (keyPressed == true && pauseToggle) {
      if (key == 'z' || key == 'Z') {

        int xCellOver = int(map(mouseX, 0, width, 0, (width)/w));
        xCellOver = constrain(xCellOver, 0, (width)/w-selectedWidth);         

        int yCellOver = int(map(mouseY, 0, (height), 0, (height)/w));
        yCellOver = constrain(yCellOver, 0, (height)/w-selectedHeight);  

        stroke(200, 0, 150);
        noFill();
        rect(xCellOver*w, yCellOver*w, selectedWidth*w-1, selectedHeight*w-1);
      }
    }
  }
}