
void insertSelectedSquareBackToCells() {


    if (referenceLocation) {



      // println("referenceLocation is true for updating cells grid");


      // once referenceLocation toggled true, insert selectedSquare back to cells' appropriate place
      for (int x=0; x<(width-1)/enlargeSize; x++) {
        for (int y=0; y<(height-1)/enlargeSize; y++) {
          cells[saveLocationX+x][saveLocationY+y] = selectedSquare[x][y];
        }
      }
      
      // **********Important ******** this code is key to make any press of 's' only has one-time effect
      referenceLocation = !referenceLocation;
      //println("now update cells grid");
    }
}