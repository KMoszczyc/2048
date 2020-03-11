int scale=100;
int score=0;
int best=0;
int TOTAL = 200;
Button butt;
PFont font;
Board board;

void setup() {
 size(600,800); 
 board=new Board();

  scale=width/4;
  butt = new Button(width/2,height-50,12,"NEW GAME");
  font = createFont("Arial Bold",42);
}

void draw() {
  background(0);
  board.update();
  board.show();
  stroke(255);
  fill(255);
  textSize(24);
  text("SCORE: "+board.score,50,height-50); 
  text("BEST: "+best,width-200,height-50); 
  butt.update();
  butt.show();
  //println(boards.size());
   
}
