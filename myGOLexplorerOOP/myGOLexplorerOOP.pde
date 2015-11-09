// myGOLexplorer build upon Daniel Shiffman's 
// 
// http://natureofcode.com

// A basic implementation of John Conway's Game of Life CA

// Each cell is now an object!

GOL gol;


void setup() {

  size(600, 600);
  gol = new GOL();
}

void draw() {
  background(255);

  //gol.generate();
  
  gol.generationAtFrequency();
  gol.generateByStep();
  gol.regenerateRandomCellsInGridPerform();
  gol.display();
  gol.displaySelectedArea();
  gol.captureSelectedSquare();
  gol.displaySelectedSquare();
}



void keyPressed() {

  gol.generationDurationControl();
  gol.stepControl();
  gol.pauseControl();  //<>//
  gol.randomControl();
  gol.selectControl();
  gol.displaySelectedSquareControl();
} //<>//