
class Puck {

  float x;
  float y;
  float r = 12;
  float xspeed;
  float yspeed;
  float speedfactor;
  float speed = 12;

  Puck() {
    reset();
  }

  void checkLeft(Paddle p) {
    if (y + r > p.y - p.h/2 && y - r < p.y + p.h/2 && x - r < p.x+p.w/2 ) {
      if (x > p.x) {
        //xspeed *= -1;
        float diff = y - (p.y - p.h/2);
        float speeddiff = abs(y - p.y);
        float rad = radians(45);
        float angle = map(diff, 0, p.h, -rad, rad);
        speedfactor = map(speeddiff, 0, p.h/2, 0, 4);
        //speedfactor = map(diff, 0, p.h, -5, 5);
        //speed = 10 + speedfactor;
        x = p.x + p.w/2 + r;
        //xspeed = speed * cos(angle);
        //yspeed = speed * sin(angle);
        xspeed = (speed+speedfactor) * cos(angle);
        yspeed = (speed+speedfactor) * sin(angle);
        hits.play();
      }
    }
  }

  void checkRight(Paddle p) {
    
    //Computer's move
    float d = y - p.y;
    while (true) {
      d = y - p.y;
      if (d > 0) {
        p.move(10);
        break;
      } else if (abs(d) <= p.h/2) {
        p.move(0);
        break;
      } else {
        p.move(-10);
        break;
      }
    }

    if (y + r > p.y - p.h/2 && y - r < p.y + p.h/2 && x + r > p.x - p.w/2) {
      if (x < p.x) {
        //xspeed *= -1;
        float diff = y - (p.y - p.h/2);
        float speeddiff = abs(y - p.y);
        float rad = radians(45);
        float angle = map(diff, 0, p.h, -rad, rad);
        speedfactor = map(speeddiff, 0, p.h/2, 0, 4);
        //xspeed = speed * -cos(angle);
        //yspeed = speed * sin(angle);
        xspeed = (speed+speedfactor) * -cos(angle);
        yspeed = (speed+speedfactor) * sin(angle);
        x = p.x - p.w/2 - r;
        hits.play();
      }
    }
  }

  void reset() {
    x = width/2;
    y = height/2;
    speed = 12;    
    float ang = random(-PI/4, PI/4);
    float side = parseInt(random(1, 10));
    xspeed = speed * cos(ang);
    yspeed = speed * sin(ang);
    if (side%2==0) {
      xspeed *= -1;
    }
  }

  void show() {
    ellipseMode(CENTER);
    fill(254, 166, 14);
    noStroke();
    ellipse(x, y, r*2, r*2);
  }

  void edges() {
    if ( y + r > height || y - r < 5) {
      yspeed *= -1;
      //xspeed *= 0.2;
    }
    if ( x - r > width) {
      ding.play();
      lscore++;
      reset();
    }
    if (x + r < 0) {
      ding.play();
      rscore++;
      reset();
    }
  }

  void update() {
    x += xspeed;
    y += yspeed;
  }
}
