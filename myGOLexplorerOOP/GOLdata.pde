class GOLdata {


  int selectedWidth;
  //int selectedHeight;
  int w;
  int columns, rows;
  int generationDuration; // used by two methods
  int lastRecordedTime;
  int xZoom, yZoom;
  Cell[][] selectedSquare;
  Cell[][] board; 
  boolean stepToggle;
  boolean pauseToggle;
  boolean randomToggle;
  boolean selectToggle;
  
  GOLdata() {
    
   selectedWidth = 60;
   //selectedHeight = 60;
   w = 5;
   columns = width/w;
   rows = height/w;
   board = new Cell[columns][rows];
   selectedSquare = new Cell[selectedWidth][selectedWidth];
   generationDuration = 100;
   stepToggle = false;
   pauseToggle = true;
   randomToggle = false;
   //lastRecordedTime;
  }
}