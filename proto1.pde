import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle;
Movie myMovie;

Capture video;
OpenCV opencv;

int xLastFrame = 0;
int delta;
int firstFrame = 1;
int jump = 0;

void setup() {
  size(640, 480);
  myMovie = new Movie(this, "video2.mp4");
  myMovie.loop();
  video = new Capture(this, 640, 480);
  opencv = new OpenCV(this, 640, 480);
  opencv.loadCascade("fist.xml");
  //opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  video.start();
}

void draw() {
  opencv.loadImage(video);
  image(myMovie, 0, 0);
  
  float newPos = getPosition();
  if(firstFrame == 1) 
    myMovie.jump(40);
  else if (newPos != -1.1 && jump == 0)
    myMovie.jump(newPos);


  Rectangle[] faces = opencv.detect();
  noFill();
  stroke(255,0,0);
  for (int i = 0; i < faces.length; i++) {
    if(firstFrame == 1) 
      firstFrame = 0;
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    delta = faces[i].x - xLastFrame;
    if (delta != 0) 
      println(delta);
    xLastFrame = faces[i].x;
  }
  
  nextJump();
}

void captureEvent(Capture c) {
  c.read();
}

void movieEvent(Movie m) {
  if (m.available()) {
    m.read();
  }

}

float getPosition() {
  int movTime = (int)myMovie.time();
  if ((delta > 15 || delta < -15) && delta > -120 && delta < 120 )
    return movTime-delta/8;
  else 
    return -1.1;
}

void nextJump(){
  ++jump;
  if (jump == 2)
    jump = 0;
}

