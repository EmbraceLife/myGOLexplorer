// update cellsBuffers with lastest cells grid
// update selectedSquareBuffers with lastest selectedSquare grid
void updateBuffersWithGrids() {

  if (pause && !mousePressed) {
    for (int x=0; x<(width-1)/cellSize; x++) {
      for (int y=0; y<(height-1)/cellSize; y++) {
        cellsBuffer[x][y] = cells[x][y];      // copy cells exact to cellsBuffer
      }
    }
  
    for (int x=0; x<(width-1)/enlargeSize-1; x++) {
      for (int y=0; y<(height-1)/enlargeSize-1; y++) {
        selectedSquareBuffer[x][y] = selectedSquare[x][y];
      }
    }
  }
}