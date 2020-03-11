class Button {
  PVector pos;
  float w,h;
  String name;
  Button(int x,int y,int textSize,String name) {
    this.pos=new PVector(x,y);
    textSize(textSize);
    this.w=textWidth(name)+5;
    this.h=textSize*2;
    this.name=name;
  }
  void update() {
    if(mouseX>=pos.x-w/2 && mouseX<pos.x+w/2 && mouseY>=pos.y-h/2 && mouseY<pos.y+h/2) {
      fill(150,100,150);
        if(mousePressed && mouseButton==LEFT) {
          board = new Board(); 
           score=0; 
        }
    } else fill(255);
  }
  void show() {
    stroke(0);
    rect(pos.x-w/2,pos.y-h/2,w,h);
    textSize(this.h/2);
    fill(0);
    text(name,pos.x-w/2 +2,pos.y+5);
  }
  
}
