
import processing.sound.*;

int rows;
int cols;
float w = 40;

Cell[][] cells;
boolean gameOver = false;
boolean flagMode = false;

void init() {
  //Initialize grid.
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      cells[i][j] = new Cell(i*w, j*w, w);
    }
  }

  //Set Neighbours
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      for (int x = -1; x < 2; x++) {
        for (int y = -1; y < 2; y++) {
          if (i+y >= 0 && i+y < cols && j+x >= 0 && j+x < rows) {
            if (cells[i+y][j+x].mine) {
              cells[i][j].val += 1;
            }//endif
          }//endif
        }//endfory
      }//endforx
    }//endforj
  }//endfori
}

void drawGrid() {
  //Draw grid
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      cells[i][j].show();
    }
  }
}

void chain(int i, int j) {
  if (cells[i][j].val == 0 && !cells[i][j].revealed) {
    cells[i][j].reveal();
    for (int x = -1; x < 2; x++) {
      for (int y = -1; y < 2; y++) {
        if (i+y >= 0 && i+y < cols && j+x >= 0 && j+x < rows) {
          chain(i+y, j+x);
          cells[i+y][j+x].reveal();
        }//endif
      }//endfory
    }//endforx
  }
}

void hideMines() { 
  //hide the mines!
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      if (cells[i][j].mine) {
        //boom.play();
        cells[i][j].revealed = false;
      }
    }
  }
}

void showMines() {
  //SoundFile boom = new SoundFile(this, "bomber.mp3"); 
  //reveal the mines and stop the game!
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      if (cells[i][j].mine) {
        //boom.play();
        cells[i][j].reveal();
      }
    }
  }
}

void checkVictory() {
  boolean win = true;
  //check if all the mines have been located and marked.
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      if (cells[i][j].mine && !cells[i][j].flagged) {
        win = false;
      }
    }
  }
  if(win) {
    fill(50,50,250,120);
    strokeWeight(3.0);
    stroke(0);
    rect(-10, height/2 - 20, width+10, 50);
    textSize(20);
    fill(0);
    text("CIA wants to know your location!", width/2 - 180, height/2+10);
    gameOver = true;
  }
}

void mousePressed() {
  if (gameOver) {
    gameOver = false;
    init();
  } else {
    //Check which cell was clicked.
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        if (cells[i][j].contains(mouseX, mouseY) && !gameOver) {
          if (flagMode) {
            //flag mode will be toggled on pressing spacebar
            cells[i][j].flag();
          } else if (cells[i][j].val == 0) {
            //check all neighbouring empty cells and reveal;
            chain(i, j);
          } else if (cells[i][j].mine) {
            //check if landed on a mine, gameover buddy!
            gameOver = true;
            cells[i][j].markOver();
            showMines();
          } else {
            //if nothing special happens, just reveal the cell;
            cells[i][j].reveal();
          }
        }
      }
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    //toggle flagging mode.
    flagMode = !flagMode;
  }
  if (key == 'h') {
    //give hints. show mines.
    showMines();
  }
}

void keyReleased() {
  //stop giving hints.
  if (key == 'h') {
    hideMines();
  }
}

void setup() {
  size(801, 801);
  rows = floor(height/w);
  cols = floor(width/w);
  cells = new Cell[rows][cols];
  init();
}

void draw() {
  background(51);
  drawGrid();
  checkVictory();
}
