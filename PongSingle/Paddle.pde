class Paddle {

  float x;
  float y = height/2;
  float w = 20;
  float h = 100;
  float ychange = 0;
  color bat;

  Paddle(boolean left) {
    if (left) {
      bat = color(234, 50, 1);
      x = w;
    } else {
      bat = color(3, 197, 58);
      x = width - w;
    }
  }

  void update() {
    y += ychange;
    y = constrain(y, h/2, height-h/2);
  }

  void move(float steps) {
    ychange = steps;
  }

  void show() {
    fill(bat);
    noStroke();
    rectMode(CENTER);
    rect(x, y, w, h);
  }
}
