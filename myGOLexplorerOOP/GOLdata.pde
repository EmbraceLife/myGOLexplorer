class GOLdata {


  Cell[][] board;
  int cellWidth;
  int boardColumns, boardRows;
  
  
  Cell[][] selectedSquare;
  int selectedSquareWidthByCells;
  int xZoom, yZoom;
  
  int generationDuration; // used by two methods
  int lastRecordedTime;
  
  boolean stepToggle;
  boolean pauseToggle;
  boolean randomToggle;
  boolean selectToggle;
  boolean markingSelectingBoxToggle;
  boolean displaySelectedToggle;
  boolean saveLifeDeathChangeToggle;
  
  GOLdata() {

   cellWidth = 5;
   boardColumns = width/cellWidth;
   boardRows = height/cellWidth;
   board = new Cell[boardColumns][boardRows];
   
   selectedSquareWidthByCells = 40;
   selectedSquare = new Cell[selectedSquareWidthByCells][selectedSquareWidthByCells];
  
   
   generationDuration = 100;
   
   
   stepToggle = false;
   pauseToggle = true;
   randomToggle = false;
   selectToggle = false;
   markingSelectingBoxToggle = false;
   displaySelectedToggle = false;
   saveLifeDeathChangeToggle = false;
  }
}