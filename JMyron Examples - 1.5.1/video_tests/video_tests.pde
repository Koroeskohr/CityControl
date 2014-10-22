import processing.video.*;

Movie mov;



void setup(){
  size(640,480, P2D);
  background(0);
  mov = new Movie(this, "../../../video/video_1_1.mp4");
  mov.play();
  
  
}

void draw() {
  image(mov, 0, 0);
}

void movieEvent(Movie m) {
  m.read();
}

void mousePressed(){
  mov.jump(mov.time() +10);
}
