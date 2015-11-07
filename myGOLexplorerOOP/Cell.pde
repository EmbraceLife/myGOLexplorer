// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Cell {

  float x, y;
  float w;

  int state;
  int previous;

  Cell(float x_, float y_, float w_) {
    x = x_;
    y = y_;
    w = w_;

    if (random(100) < 15) {
      state = 1;
    } else {
      state = 0;
    }
    //state = int(random(2));
    previous = state;
  }

  void savePrevious() {
    previous = state;
  }

  // s as user input
  void newState(int s) {
    state = s;
  }


/**
* order of conditions
*/
  void display() {
    if (previous == 0 && state == 1) fill(#E20CF2);
    else if (previous == 1 && state == 0) fill(#807F83);
    else if (state == 1) fill(255,0,0);
    else fill(0); 
    stroke(0);
    rect(x, y, w, w);
  }
}