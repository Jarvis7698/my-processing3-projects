import processing.sound.*;

Puck puck;
Paddle left;
Paddle right;

SoundFile ding;
SoundFile hits;

int lscore = 0;
int rscore = 0;

boolean right_played = false;

float midc;
float a,b,c,d,e,f;

void setup() {
  size(1200, 500);
  textSize(32);
  
  ding = new SoundFile(this, "ohno.mp3");  //ohno, ding, oof, p**
  hits = new SoundFile(this, "hits.mp3");  //hits, switch

  left = new Paddle(true);
  right = new Paddle(false);
  puck = new Puck();
  
  //line coords
  midc = 4*height/10;
  a = width/2;
  b = height/10;
  c = height-height/10;
  d = height/2;
}

void mousePressed() {
  puck.reset();
}

void keyReleased() {
  left.move(0);
  right.move(0);
}

void keyPressed() {
  //if (key == 'w') {
  //  left.move(-10);
  //} else if (key == 's') {
  //  left.move(10);
  //}
  //if (key == 'o') {
  //  right.move(-10);
  //} else if (key == 'l') {
  //  right.move(10);
  //}
}

void draw() {
  background(51);
 
  strokeWeight(3.0);
  stroke(127);
  noFill();
  line(a, b, a, c);
  line(0,b,width, b);
  line(0,c,width, c);
  //ellipse(0,d,2*midc,2*midc);
  //ellipse(width,d,2*midc,2*midc);
  ellipse(a,d,midc,midc);
  
  fill(255);
  text(lscore, 32, 40);
  text(rscore, width-64, 40);
  
  if(lscore == 11 || rscore == 11) {
    noLoop();
  }

  puck.checkLeft(left);
  puck.checkRight(right);
  
  left.show();
  right.show();
  left.update();
  right.update();

  puck.update();
  puck.edges();
  puck.show();
}
