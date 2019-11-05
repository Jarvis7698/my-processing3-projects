/*
** By Kunal Acharya
 ** Makes Red/Green/Blue color invisible after a mouse click.
 ** Before you click, make sure the background is empty.
 */
import processing.video.*;

Capture video;
PImage back_img;
boolean invisible = false;
int cmp;
float thresh = 20;

void setup() {
  size(640, 480);
  video = new Capture(this, width, height);
  back_img = createImage(width, height, RGB);
  back_img.loadPixels();
  video.start();
  smooth();
}

void mousePressed() {
  invisible = false;
  cmp = video.pixels[mouseX + video.width * mouseY];
  invisible = true;
}

void keyPressed() {
  if (key == 'c') {
    for (int i=0; i<back_img.pixels.length; i++) {
      back_img.pixels[i] = video.pixels[i];
    }
    back_img.updatePixels();
  }
  if(key == 's') {
    int d = day();
    int s = second();
    int h = hour();
    int m = minute();
    save("invisible_"+str(d)+str(h)+str(m)+str(s)+".png");
  }
}

void draw() {
  if (video.available()) {
    video.read();
    for (int i=0; i<video.pixels.length; i++) {
      int pixel = video.pixels[i];
      int r = (pixel >> 16) & 0xff;
      int g = (pixel >> 8) & 0xff;
      int b = pixel & 0xff;
      
      int r1 = (cmp >> 16) & 0xff;
      int g1 = (cmp >> 8)  & 0xff;
      int b1 = cmp & 0xff;
      
      float d = dist(r,g,b,r1,g1,b1);
       
      if (d < thresh && invisible) {
        video.pixels[i] = back_img.pixels[i];
      }
      video.updatePixels();
    }
  }
  image(video, 0, 0);
  thresh = map(mouseX, 0, width, 0, 100);
}
