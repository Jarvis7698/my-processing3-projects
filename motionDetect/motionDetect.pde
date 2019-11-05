
import processing.video.*;

Capture video;
PImage prev;
float threshold = 50;
float avgx, avgy, cnt;

float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  return (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) + (z2-z1)*(z2-z1);
}

void setup() {
  size(640, 360);
  prev = createImage(width, height, RGB);
  video = new Capture(this, width, height);
  video.start();
}

void draw() {

  if (video.available()) {
    prev.copy(video, 0, 0, video.width, video.height, 0, 0, prev.width, prev.height);
    prev.updatePixels();
    video.read();

    video.loadPixels();
    prev.loadPixels();
    image(video, 0, 0);

    avgx = 0;
    avgy = 0;
    cnt = 0;

    loadPixels();
    for (int i = 0; i<video.width; i++) {
      for (int j = 0; j<video.height; j++) {

        int loc = i + j * video.width;

        int currentColor = color(video.pixels[loc]);

        float r1 = red(currentColor);
        float g1 = green(currentColor);
        float b1 = blue(currentColor);

        int prevColor = color(prev.pixels[loc]);

        float r2 = red(prevColor);
        float g2 = green(prevColor);
        float b2 = blue(prevColor);

        float d = distSq(r1, g1, b1, r2, g2, b2);

        if (d > threshold*threshold) {
          //pixels[loc] = color(0);
          avgx += i;
          avgy += j;
          cnt ++;
        } else {
          //pixels[loc] = color(255,0,0);
        }
      }
    }
    updatePixels();
    if (cnt > 100) {
      avgx /= cnt;
      avgy /= cnt;
      noFill();
      stroke(0, 255, 0);
      strokeWeight(3.0);
      rectMode(CENTER);
      rect(avgx, avgy, 50, 50);
    }
    //image(video, 0, 0);
  }
}
