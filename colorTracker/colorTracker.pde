
import processing.video.*;

Capture video;
color target;

void mirror() {
  //Mirror the video on X-axis;
  video.loadPixels();
  for (int x = 0; x < video.width/2; x++) {
    for (int y = 0; y < video.height; y++) {
      int revloc = (video.width - x - 1) + y * video.width;
      int loc = x + y * video.width;
      int temp = video.pixels[loc];
      video.pixels[loc] = video.pixels[revloc];
      video.pixels[revloc] = temp;
    }
  }
}

void mousePressed() {
  //click on a color to choose a target;
  target = video.pixels[mouseX + mouseY * video.width];
}

void setup() {
  size(640, 480);
  video = new Capture(this, width, height);
  video.start();
  target = color(255, 0, 0);
}

void draw() {
  if (video.available()) {
    video.read();
    mirror();
    image(video, 0, 0);

    float avgX = 0;
    float avgY = 0;
    float num = 0;
    
    //select a threshold value;
    float threshold = 20;
    
    //extract RGB information of the target pixel for comparison;
    float rt = red(target);
    float gt = green(target);
    float bt = blue(target);

    for (int x = 0; x < video.width; x++) {
      for (int y = 0; y < video.height; y++) {
        int loc = x + y * video.width;
        color pixel = video.pixels[loc];
        
        //extract RGB information of current pixel;
        float rp = red(pixel);
        float gp = green(pixel);
        float bp = blue(pixel);
        
        //check how close the current is with respect to the target;
        float d = dist(rt, gt, bt, rp, gp, bp);

        if (d < threshold) {
          //if pixel is promising, select that area too;
          avgX += x;
          avgY += y;
          num += 1;
        }
      }
    }
    if (num > 0) {
      //calculate the average position of the centroid pixel;
      avgX /= num;
      avgY /= num;
      
      fill(target);
      stroke(0);
      strokeWeight(4.0);
      
      //mark the centroid of the selected pixels;
      ellipse(avgX, avgY, 40, 40);
    }
  }
}
