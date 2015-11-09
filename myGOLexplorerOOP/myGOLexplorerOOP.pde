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
  gol.cleanUpBoardGrid();
  gol.autoGenerateWithDiffSpeed();
  gol.generateByStep();
  gol.randomizeGrid();
  gol.display();
  gol.displaySelectingBox();
  gol.markingSelectingBox();
  gol.captureSelectedSquare();

  gol.saveLifeDeathChangesToBoard();
  gol.displaySelectedSquare();
  //println("anchor", data.xAnchorInSelectedSquare, ":", data.yAnchorInSelectedSquare);
  //println("hovering", data.xCellHoverInSelectedSquare, ":", data.yCellHoverInSelectedSquare);
  gol.lockAnchorOfCapturingBoxInSelectedSquare();
  gol.displayCapturingBox();

} //<>//



void keyPressed() {

  gol.generationSpeedControl();
  gol.cleanUpControl();
  gol.stepControl();
  gol.pauseControl(); 
  gol.randomControl();
  gol.markingSelectingBoxControl();
  gol.captureSelectControl();
  gol.displaySelectedSquareControl();
  gol.saveLifeDeathChangesControl();
  gol.lockAnchorOfCapturingBoxControl();
 
} 


void mouseClicked() {
  
  gol.clickChangeLifeDeath();
}