// update cellsBuffers with lastest cells grid
// update selectedSquareBuffers with lastest selectedSquare grid
void updateBuffersWithGrids() {


  for (int x=0; x<width/cellSize; x++) {
    for (int y=0; y<height/cellSize; y++) {
      cellsBuffer[x][y] = cells[x][y];      // copy cells exact to cellsBuffer
    }
  }

  for (int x=0; x<width/enlargeSize-1; x++) {
    for (int y=0; y<height/enlargeSize-1; y++) {
      selectedSquareBuffer[x][y] = selectedSquare[x][y];
    }
  }
}