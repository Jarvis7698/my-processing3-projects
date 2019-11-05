class Symbol {
  float x;
  float y;
  char symbol;
  float speed;
  boolean first = false;
  color fillThis;

  Symbol (float X, float Y, float Speed) {
    x = X;
    y = Y;
    speed = Speed;
  }

  void getRandomSymbol() {
    int switchInterval = round(random(2, 20));
    if (frameCount % switchInterval == 0) {
      symbol = (char)(round(random(12446, 12582)));
    }
  }
  
  void setFillColor(color thisColor) {
    fillThis = thisColor;
  }

  void thisIsFirst() {
    first = round(random(1,3)) == 1;
  }

  void rain() {
    if (y >= height) {
      y = 0;
    } else {
      y += speed;
    }
  }

  void show() {
    if (first) {
      fill(180, 255, 180);
    } else {
      fill(fillThis);
    }
    text(symbol, x, y);
  }
}
