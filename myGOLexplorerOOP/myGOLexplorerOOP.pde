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
  gol.randomizeGrid();
  gol.display();
  gol.displaySelectingBox();
  gol.markingSelectingBox();
  gol.captureSelectedSquare();
  
  gol.saveLifeDeathChangesToBoard();
  gol.displaySelectedSquare();
  
}



void keyPressed() { //<>//

  gol.generationDurationControl();
  gol.stepControl();
  gol.pauseControl(); 
  gol.randomControl();
  gol.markingSelectingBoxControl();
  gol.captureSelectControl();
  gol.displaySelectedSquareControl();
  gol.saveLifeDeathChangesControl();
} 


void mouseClicked() {
  
  gol.clickChangeLifeDeath();
}