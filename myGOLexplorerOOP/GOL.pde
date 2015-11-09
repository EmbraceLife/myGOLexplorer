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
    for (int i = 0; i < data.boardColumns; i++) {
      for (int j = 0; j < data.boardRows; j++) {
        data.board[i][j] = new Cell(i*data.cellWidth, j*data.cellWidth, data.cellWidth);
      }
    }
  }


  void display() {


    for ( int i = 0; i < data.boardColumns; i++) {
      for ( int j = 0; j < data.boardRows; j++) {
        data.board[i][j].display();
      }
    }
  }



  void generate() {
    for ( int i = 0; i < data.boardColumns; i++) {
      for ( int j = 0; j < data.boardRows; j++) {
        data.board[i][j].savePrevious();
      }
    }

    for (int x = 0; x < data.boardColumns; x++) {
      for (int y = 0; y < data.boardRows; y++) {

        int neighbors = 0;
        for (int i = -1; i <= 1; i++) {
          for (int j = -1; j <= 1; j++) {
            neighbors += data.board[(x+i+data.boardColumns)%data.boardColumns][(y+j+data.boardRows)%data.boardRows].previous;
          }
        }

        neighbors -= data.board[x][y].previous;

        // Rules of Life
        if      ((data.board[x][y].state == 1) && (neighbors <  2)) data.board[x][y].newState(0);           // Loneliness
        else if ((data.board[x][y].state == 1) && (neighbors >  3)) data.board[x][y].newState(0);           // Overpopulation
        else if ((data.board[x][y].state == 0) && (neighbors == 3)) data.board[x][y].newState(1);           // Reproduction
        // else do nothing!
      }
    }
  }


  void generationAtFrequency() { 

    if (!data.pauseToggle) {

      int interval = millis()-data.lastRecordedTime;
      if (interval > data.generationDuration) {          

        generate();  
        data.lastRecordedTime = millis();
      }
    }
  }


  void generateByStep() {   

    if (data.pauseToggle && data.stepToggle) {
      generate(); 
      data.stepToggle = !data.stepToggle;
    } else {
      // nothing happens, no iteration
    }
  }


  void randomizeGrid() {
    if (data.randomToggle) {
      regenerateRandomCellsInGrid();
      data.randomToggle = !data.randomToggle;
    }
  }






  void displaySelectingBox() {

    if (keyPressed == true && data.pauseToggle) {
      if (key == 'z' || key == 'Z') {

        int xCellHover = int(map(mouseX, 0, width, 0, (width)/data.cellWidth));
        xCellHover = constrain(xCellHover, 0, (width)/data.cellWidth - data.selectedSquareWidthByCells);         

        int yCellHover = int(map(mouseY, 0, (height), 0, (height)/data.cellWidth));
        yCellHover = constrain(yCellHover, 0, (height)/data.cellWidth - data.selectedSquareWidthByCells);  

        stroke(200, 0, 150);
        noFill();
        rect(xCellHover*data.cellWidth, yCellHover*data.cellWidth, data.selectedSquareWidthByCells*data.cellWidth-1, data.selectedSquareWidthByCells*data.cellWidth-1);
      }
    }
  }



  void captureSelectedSquare() {  

    int xCellHover = int(map(mouseX, 0, width, 0, (width)/data.cellWidth));
    xCellHover = constrain(xCellHover, 0, (width)/data.cellWidth-data.selectedSquareWidthByCells);         

    int yCellHover = int(map(mouseY, 0, height, 0, (height)/data.cellWidth));
    yCellHover = constrain(yCellHover, 0, (height)/data.cellWidth-data.selectedSquareWidthByCells);  



    if (data.selectToggle) {  
      for (int i = 0; i < data.selectedSquareWidthByCells; i++) {
        for (int j = 0; j < data.selectedSquareWidthByCells; j++) {
          data.selectedSquare[i][j] = new Cell(i*(width/data.selectedSquareWidthByCells), j*(width/data.selectedSquareWidthByCells), width/data.selectedSquareWidthByCells);
        }
      }

      data.xZoom = xCellHover;
      data.yZoom = yCellHover;

      for (int xCell=data.xZoom; xCell<data.xZoom+data.selectedSquareWidthByCells; xCell++) {
        for (int yCell=data.yZoom; yCell<data.yZoom+data.selectedSquareWidthByCells; yCell++) {

          data.selectedSquare[xCell-data.xZoom][yCell-data.yZoom].state = data.board[xCell][yCell].state;
          data.selectedSquare[xCell-data.xZoom][yCell-data.yZoom].previous = data.board[xCell][yCell].previous;
        }
      }
      data.selectToggle = !data.selectToggle;  // lock a piece of memory
    }
  }



  void displaySelectedSquare() {
    if (data.displaySelectedToggle) { 
      for ( int i = 0; i < data.selectedSquareWidthByCells; i++) {
        for ( int j = 0; j < data.selectedSquareWidthByCells; j++) {
          data.selectedSquare[i][j].display();
        }
      }
    }
  }


  void clickChangeLifeDeath() {
    if (data.pauseToggle) {
      int xCellHover = int(map(mouseX, 0, width, 0, data.selectedSquareWidthByCells));
      int yCellHover = int(map(mouseY, 0, height, 0, data.selectedSquareWidthByCells));

      if (data.selectedSquare[xCellHover][yCellHover].state == 0) {
        data.selectedSquare[xCellHover][yCellHover].state = 1;
       
      } else {
        data.selectedSquare[xCellHover][yCellHover].state = 0;
       
      }
      
      
    }
  }


  void saveLifeDeathChangesToBoard() {
     if (data.saveLifeDeathChangeToggle) {
       for (int i = data.xZoom; i < data.xZoom+data.selectedSquareWidthByCells; i++) {
          for (int j = data.yZoom; j < data.yZoom+data.selectedSquareWidthByCells; j++) {
            data.board[i][j].state = data.selectedSquare[i-data.xZoom][j-data.yZoom].state;
          }
       }
       
       data.saveLifeDeathChangeToggle = !data.saveLifeDeathChangeToggle;
     }
  }



  void saveLifeDeathChangesControl() {
     if (key == 's' || key == 'S') {
        data.saveLifeDeathChangeToggle = !data.saveLifeDeathChangeToggle; 
     }
  }


  void displaySelectedSquareControl() {
    if (key == 'e' || key == 'E') {
      data.displaySelectedToggle = !data.displaySelectedToggle;
    }
  }




  void captureSelectControl() {
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