/*

This example shows a whole lot of different
tracking methods being rendered at one time.
Don't be surprised if this one runs really slowly.

 last tested to work in Processing 0090
 
 JTNIMOY
 
*/

import JMyron.*;

JMyron m;

int xLastFrame = 0;
int firstFrame = 1;

int wCam = 640;
int hCam = 480;
 
void setup(){
  int w = 640;
  int h = 480;
  
  
  
  size(w,h);
  m = new JMyron();
  m.start(wCam,hCam);
  m.findGlobs(1);
  println("Myron " + m.version());
  
}
  
void mousePressed(){
  m.settings();
}

void draw(){
  
  
  m.trackColor(255,255,255,255); //????
  m.sensitivity(100);

  m.update();
  int[] img = m.image();
  
  //first draw the camera view onto the screen
  loadPixels();
  
  /* Mirrorise la caméra mais les autres dessins ne sont pas affectés
  for(int i=1; i<width;i++){
    for(int j=1;j<height;j++){
      this.pixels[(m.width() - i - 1) + j * m.width()] = imgNormal[(i) + j * m.width()];
    }
  }*/
  

  for(int i=0;i<wCam*hCam;i++){
      pixels[i] = img[i];
  }
  
  
  updatePixels();
  
  
  /////// Ca sert à rien
  //draw an averaged color block where the mouse is.
  //noStroke();
  //int c = m.average(mouseX-20,mouseY-20,mouseX+20,mouseY+20);
  //fill(red(c),green(c),blue(c));
  //rect(mouseX-20,mouseY-20,40,40);

  noFill();
  int[][] a;

  //les rectangles jaunes, points qui nous intéresseront
  //draw center points of globs
  
  
  /*for(int i=0;i<a.length;i++){
    int[] p = a[i];
    rect(p[0]-2,p[1]-2,3,3);
  }*/
 
  //les rectangles rouges
  //draw bounding boxes of globs 
  a = m.globBoxes();
  stroke(255,0,0);
  int i = biggestRectangle(a);
  
  if (a.length > 0) {
    
    firstFrame = 0;
    
   // println(i + " C'est ca");
    
    //println(a[i][0] + " " + a[i][1] + " " +  a[i][2] + " " +  a[i][3]);
    rect(a[i][0], a[i][1], a[i][2], a[i][3]);
  }
  
  
  
  
  a = m.globCenters();
  stroke(255,255,0);
  
  if (a.length > 0) {
    //println(a[0]);
  

    
    int[] b = a[i];
    
    //println(i + " C'est ca");
    
//println(b[0]);
    //println(a[i][0] + " " + a[i][1] + " " +  a[i][2] + " " +  a[i][3]);
    rect(a[i][0], a[i][1], 3, 3);
    
    
    
    
    if (firstFrame == 0) {
      
      int delta = a[i][0] - xLastFrame;
     println(delta); 
      
    }
    
    xLastFrame = a[i][0];
  }
  
  
  /*for(int i=0;i<a.length;i++){
    int[] b = a[i];
    rect(b[0], b[1], b[2], b[3]);
  }*/
  
  
  //draw edge pixels of globs (this and the next chunks of code are chokers)
  /*int list[][][] = m.globPixels();
  stroke(110,110,110);
  
*/
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
