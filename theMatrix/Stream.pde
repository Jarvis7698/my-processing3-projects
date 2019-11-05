class Stream {
  float x;
  float y;
  float speed;
  int total_symbols;
  Symbol symbols[];

  Stream (float X, float Y, float Speed) {
    x = X;
    y = Y;
    speed = Speed;
    total_symbols = round(random(5, maxStreamLength));
    symbols = new Symbol[total_symbols];
  }

  void getRandomStream () {
    for (int i = 0; i < total_symbols; i++) {
      symbols[i] = new Symbol(x, y, speed);
      y -= symbolSize;
      float alp = map(i, 0, total_symbols, 255, 0);
      symbols[i].setFillColor(color(0,255,0,alp));
    }
    symbols[0].thisIsFirst();
  }

  void show() {
    for (int i = 0; i < total_symbols; i++) {
      symbols[i].getRandomSymbol();
      symbols[i].rain();
      symbols[i].show();
    }
  }
}
