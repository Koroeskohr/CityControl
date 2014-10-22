import processing.video.*;
import JMyron.*;

Movie mov;

import JMyron.*;

JMyron m;

int xLastFrame = 0;
int firstFrame = 1;

int delta;

int wCam = 640;
int hCam = 480;

void setup(){
  size(640,480, P2D);
  background(0);
  mov = new Movie(this, "../../../video/video_1_1.mp4");
  mov.play();
  mov.jump(40);
  m = new JMyron();
  m.start(wCam,hCam);
  m.findGlobs(1);
  
}

void draw(){
  
  
  mov.jump(getPosition());
  
  println(getPosition());
  //mov.stop();
  image(mov, 0, 0);
  
  
  m.trackColor(73,142,230,255); //????
  m.sensitivity(100);

  m.update();

 

  noFill();
  int[][] a;


  //les rectangles rouges
  //draw bounding boxes of globs 
  a = m.globBoxes();
  stroke(255,0,0);
  int i = biggestRectangle(a);
  
  if (a.length > 0) {
    
    firstFrame = 0;
    
   // println(i + " C'est ca");
    
    //println(a[i][0] + " " + a[i][1] + " " +  a[i][2] + " " +  a[i][3]);
    //rect(a[i][0], a[i][1], a[i][2], a[i][3]);
  }
  if (a.length > 0) {
    //println(a[0]);  
    int[] b = a[i];
    
    //println(i + " C'est ca");
    
//println(b[0]);
    //println(a[i][0] + " " + a[i][1] + " " +  a[i][2] + " " +  a[i][3]);
    //rect(a[i][0], a[i][1], 3, 3);
    
    if (firstFrame == 0) {
 
     delta = a[i][0] - xLastFrame;
     println(delta);    
   
  }
    
    xLastFrame = a[i][0];
    
   //  a = m.globCenters();
  //stroke(255,255,0);
  }
  
  
  /*for(int i=0;i<a.length;i++){
    int[] b = a[i];
    rect(b[0], b[1], b[2], b[3]);
  }*/
  
}

public void stop(){
  m.stop();
  super.stop();
}

public int biggestRectangle(int[][] a) {
  int biggest = 0;
  
  int biggestAire = 0;
  
  for (int i = 0 ; i < a.length ; ++i) {
    if (a[i][2] * a[i][3] > biggestAire) {
      biggest = i;
    }
  }
  //println("Biggest : " + biggest);
  return biggest;
}

void movieEvent(Movie m) {
  
  if (m.available()) {
    m.read();
  }
  
}

void mousePressed(){
  mov.jump(mov.time() +10);
}

float getPosition() {
  int movTime = (int)mov.time();
  return movTime+delta/10;
}
