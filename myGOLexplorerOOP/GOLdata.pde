class GOLdata {


  Cell[][] board;
  int cellWidth;
  int boardColumns, boardRows;
  
  
  Cell[][] selectedSquare;
  int selectedSquareWidthByCells;
  int xZoom, yZoom;
  int xAnchorInSelectedSquare, yAnchorInSelectedSquare;
  int xEndPointInSelectedSquare, yEndPointInSelectedSquare;
  int zoomedCellWidth;
  int xCellHoverInSelectedSquare;
  int yCellHoverInSelectedSquare;
 
 
  Table creatureTable;
  Cell[][] creatureGrid;
   
  
  int generationDuration; // used by two methods
  int lastRecordedTime;
  
  boolean stepToggle;
  boolean pauseToggle;
  boolean randomToggle;
  boolean selectToggle;
  boolean markingSelectingBoxToggle;
  boolean displaySelectedToggle;
  boolean lockAnchorOfCapturingBoxToggle, lockEndPointOfCapturingBoxToggle;
  boolean saveLifeDeathChangeToggle;
  boolean cleanUpToggle;
  boolean captureCreatureToggle;
  boolean loadCreatureToggle;
  
  
  
  GOLdata() {

   cellWidth = 5;
   boardColumns = width/cellWidth;
   boardRows = height/cellWidth;
   board = new Cell[boardColumns][boardRows];
   
   selectedSquareWidthByCells = 40;
   zoomedCellWidth = width/selectedSquareWidthByCells;
   selectedSquare = new Cell[selectedSquareWidthByCells][selectedSquareWidthByCells];

   creatureTable = new Table();
        
   
   generationDuration = 100;
   
   cleanUpToggle = false;
   stepToggle = false;
   pauseToggle = true;
   randomToggle = false;
   selectToggle = false;
   markingSelectingBoxToggle = false;
   displaySelectedToggle = false;
   lockAnchorOfCapturingBoxToggle = false;
   lockEndPointOfCapturingBoxToggle = false;
   saveLifeDeathChangeToggle = false;
   captureCreatureToggle = false;
   loadCreatureToggle = false;
  }
}