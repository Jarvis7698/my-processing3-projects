
import processing.sound.*;

Stream stream;
ArrayList<Stream> streams;
float symbolSize = 20;
float maxSpeed = 12;
float maxStreamLength = 40;
PFont font;
//SoundFile sound;

void setup() {
  size(1280, 720);
  //sound = new SoundFile(this, "matrixRain2.mp3");
  font = createFont("Microsoft YaHei", symbolSize);
  textFont(font);
  streams = new ArrayList<Stream>();
  for (int i = 0; i < width; i+=symbolSize) {
    stream = new Stream(i, random(-1000, 0), round(random(3, maxSpeed)));
    stream.getRandomStream();
    streams.add(stream);
  }
  //sound.loop();
}

void mousePressed() {
  saveFrame("matrix-####.jpg");
}

void draw() {
  background(0);
  for (Stream stream : streams) {
    stream.show();
  }
}
