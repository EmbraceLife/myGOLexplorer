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
  gol.randomizeGridPerform();
  gol.display();
  gol.displaySelectedArea(20,20);
}



void keyPressed() {

  gol.generationDurationControl();
  gol.stepControl();
  gol.pauseControl(); 
  gol.randomControl();
} //<>//