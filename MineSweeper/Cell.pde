class Cell {
  float x;
  float y;
  float w;
  int val;

  boolean revealed = false;
  boolean mine = false;
  boolean flagged = false;
  color fillColor = 200;
  color flaggedCell = 250;

  Cell (float x, float y, float w) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.val = 0;
    if (random(1) < 0.12) {
      mine = true;
      val = 99;
    }
  }

  void flag() {
    flaggedCell = color(255, 50, 50);
    flagged = !flagged;
  }

  void reveal() {
    this.revealed = true;
  }

  void markOver() {
    this.fillColor = color(255, 150, 150);
  }

  boolean contains(float x, float y) {
    return (
      x > this.x       &&
      x < this.x + w   &&
      y > this.y       &&
      y < this.y + w
      );
  }
  
  void show() {
    float r = w/2;
    if (flagged) {
      fill(flaggedCell);
    } else {
      fill(240);
    }
    if (flagMode || gameOver) {
      stroke(255, 0, 0, 100);
    } else {
      stroke(127);
    }
    strokeWeight(2);
    rect(x, y, w, w);
    if (revealed) {
      //this cell is revealed
      fill(fillColor);
      rect(x, y, w, w);
      if (val > 0 && val < 10) {
        //this is a cell with a number
        fill(0);
        textSize(w*0.7);
        text(val, x+10, y+30);
      }
      if (mine) {
        //there is a bomb under this cell
        fill(51);
        stroke(0);
        ellipseMode(3);
        ellipse(x+r, y+r, r, r);
      }
    }
  }
}
