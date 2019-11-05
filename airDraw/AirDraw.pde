
import processing.video.*;

Capture video;
color target;
boolean notclicked = true;
float prevx, prevy;
int sketchNum = 1;

float T = 25;

void setup() {
  background(0);
  size(640, 480);
  video = new Capture(this, width, height);
  video.start();
  target = color(255, 0, 0);
}

void mousePressed() {
  if (notclicked) {
    int loc = mouseX + mouseY * video.width;
    prevx = width-mouseX;
    prevy = mouseY;
    target = video.pixels[loc];
    notclicked = false;
  }
  background(0);
}

void keyPressed() {
  if (key == 's') {
    int s = second();
    int m = minute();
    int h = hour();
    int d = day();
    String time = str(d)+str(h)+str(m)+str(s);
    save("airDraw_sketch_"+time+".png");
  }
}

void draw() {
  if (video.available()) {
    video.read();
    video.loadPixels();
    if (notclicked) {
      for (int x = 0; x < video.width/2; x++) {
        for (int y = 0; y < video.height; y++) {
          int rev_loc = (video.width - x -1) + y * video.width;
          int loc = x + y * video.width;
          int temp = video.pixels[loc];
          video.pixels[loc] = video.pixels[rev_loc];
          video.pixels[rev_loc] = temp;
        }
      }
      //video.updatePixels();
      image(video, 0, 0);
    } else {
      float avgX = 0;
      float avgY = 0;
      int n = 0;

      //T = map(mouseX, 0, width, 0, 100);
      //println(T);

      for (int x = 0; x < video.width; x++) {
        for (int y = 0; y < video.height; y++) {

          int loc = x + y * video.width;
          color pixel = video.pixels[loc];

          float targetR = red(target);
          float targetG = green(target);
          float targetB = blue(target);

          float pixelR = red(pixel);
          float pixelG = green(pixel);
          float pixelB = blue(pixel);

          float d = dist(pixelR, pixelG, pixelB, targetR, targetG, targetB);

          if (d < T) {
            //stroke(255);
            //strokeWeight(1);
            //point(x,y);
            avgX += x;
            avgY += y;
            n+=1;
          }
        }
      }
      if (n > 1) {
        avgX /= n;
        avgY /= n;
        strokeWeight(10.0);
        stroke(target);
        line(video.width-prevx, prevy, video.width-avgX, avgY);
        prevx = avgX;
        prevy = avgY;
        //fill(target);
        //ellipse(video.width-avgX, avgY, 8, 8);
      }
    }
  }
}
