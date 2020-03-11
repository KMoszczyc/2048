
boolean shifted=false;
class Cell {
 int x,y,value;
 boolean dead,doubled;
   Cell(int x,int y,int value) {
    this.x=x;
    this.y=y;
    this.value=value;
    this.dead=true;
    this.doubled=false;
   }
  void show() {
    if(!dead) {
    if(value==2)
    fill(238, 228, 218);
    if(value==4)
     fill(237, 224, 200);
    if(value==8)
    fill(242, 177, 121);
    if(value==16)
    fill(245, 149, 99);
    if(value==32)
    fill(246, 124, 95);
    if(value==64)
    fill(246, 94, 59);
     if(value==128)
    fill(237, 207, 114);
    if(value==256)
    fill(237, 204, 97);
    if(value==512)
     fill(237, 201, 87);
    if(value==1024)
    fill(237, 195, 77);
    if(value==2048)
     fill(237, 190, 67);
    if(value==4096)
    fill(10);
    //fill(150,100,50);
    strokeWeight(16);
    stroke(187,173,160);
    rect(this.x*scale,this.y*scale,scale,scale);
    textSize(42);
    strokeWeight(1);
    if(value==2 || value==4) 
    fill(205, 193, 180);
    else fill(249, 246, 242);
    textFont(font);
    text(value,this.x*scale+scale/2-textWidth(str(value))/2,this.y*scale+scale/2+10);
    }
    else { 
     fill(205,193,180);
     stroke(187,173,160);
     strokeWeight(16);
     rect(this.x*scale,this.y*scale,scale,scale);
     fill(249, 246, 242);
     // text(value,this.x*scale+scale/2-textWidth(str(value))/2,this.y*scale+scale/2+10);
     strokeWeight(1);
    }
}
}
class Board {
 Cell cells[][]; 
 int score=0,lastScore=0,count=1,lastCount=1,countWrongMoves=0;
 float fitness=0;
 boolean dead=false;
  Board() {
    cells=new Cell[4][4];
    for(int i=0;i<cells.length;i++) {
        for(int j=0;j<cells[i].length;j++) {
          cells[i][j]=new Cell(i,j,0);
    }
    }
    addCell();
  }
 
  void update() {
   // if(count==16 && lastScore==score)dead=true;
    if(count==lastCount)countWrongMoves++;
    else countWrongMoves=0;
    if(score!=lastScore) countWrongMoves=0;
    
    if(countWrongMoves>50)dead=true;
    lastScore=score;
    lastCount=count;
  }
  void show() {
    stroke(0);
    for(int i=0;i<cells.length;i++) {
        for(int j=0;j<cells[i].length;j++) {
           cells[i][j].show();
        }
    }
    if(dead) {
       textSize(40);
       stroke(235,50,10);
       fill(235,50,10);
       //text("WASTED! result: "+score,100,height-100);
       }
  }
  void goLeft() {
    for(int j=0;j<cells.length;j++) {
       for(int i=0;i<cells[j].length;i++) {
         int index=i;
         //shifting to the left
           while(index>0 && cells[index][j].dead==false && cells[index-1][j].dead==true){
            cells[index-1][j].value=cells[index][j].value;
            cells[index][j].dead=true;
            cells[index][j].value=0;
            cells[index-1][j].dead=false;
            index--;
           }
           if(index!=i)shifted=true;
           
            if(cells[index][j].dead==false && index-1>=0 && cells[index-1][j].dead==false 
            && cells[index-1][j].doubled==false && cells[index][j].value==cells[index-1][j].value) {
             cells[index-1][j].value*=2;
              this.score+= cells[index-1][j].value;
              cells[index-1][j].doubled=true;
              cells[index][j].dead=true;
              cells[index][j].value=0;
              shifted=true;
            }
           }
       }
  }
   void goRight() {
     for(int j=0;j<cells.length;j++) {
       for(int i=cells[j].length-1;i>=0;i--) {
         int index=i+1;
         //shifting to the right
           while(cells[index-1][j].dead==false && index<cells[j].length && cells[index][j].dead==true){
            cells[index][j].value=cells[index-1][j].value;
            cells[index-1][j].dead=true;
            cells[index-1][j].value=0;
            cells[index][j].dead=false;
            index++;
           }
           index--;
        if(index!=i)shifted=true;
            if(cells[index][j].dead==false && index+1<cells[j].length && cells[index+1][j].dead==false 
            && cells[index+1][j].doubled==false && cells[index+1][j].value==cells[index][j].value) {
              cells[index+1][j].value*=2;
              this.score+= cells[index+1][j].value;
              cells[index+1][j].doubled=true;
              cells[index][j].dead=true;
              cells[index][j].value=0;
              shifted=true;
            }
           }
       }
   }
  void goUp() {
     for(int i=0;i<cells.length;i++) {
          for(int j=0;j<cells[i].length;j++) {
         int index=j;
         //shifting up
           while(index>0 && cells[i][index].dead==false && cells[i][index-1].dead==true){
             cells[i][index-1].value=cells[i][index].value;
            cells[i][index].dead=true;
            cells[i][index].value=0;
            cells[i][index-1].dead=false;
            index--;
           }
           if(index!=j)shifted=true;
           
            if(cells[i][index].dead==false && index-1>=0 && cells[i][index-1].dead==false 
            && cells[i][index-1].doubled==false && cells[i][index].value==cells[i][index-1].value) {
              cells[i][index-1].value*=2;
               this.score+= cells[i][index-1].value;
              cells[i][index-1].doubled=true;
              cells[i][index].dead=true;
              cells[i][index].value=0;
              shifted=true;
            }
           }
       }
  }
  void goDown() {
    for(int i=0;i<cells.length;i++) {
          for(int j=cells[i].length-1;j>=0;j--) {
         int index=j;
         //shifting up
           while(index<cells[i].length-1 && cells[i][index].dead==false && cells[i][index+1].dead==true){
             cells[i][index+1].value=cells[i][index].value;
            cells[i][index].dead=true;
            cells[i][index].value=0;
            cells[i][index+1].dead=false;
            index++;
           }
           if(index!=j)shifted=true;
           
            if(cells[i][index].dead==false && index<cells[i].length-1 && cells[i][index+1].dead==false 
            && cells[i][index+1].doubled==false && cells[i][index].value==cells[i][index+1].value) {
              cells[i][index+1].value*=2;
               this.score+= cells[i][index+1].value;
              cells[i][index+1].doubled=true;
              cells[i][index].dead=true;
              cells[i][index].value=0;
              shifted=true;
            }
           }
       }
  }
  void addCell() {
    int indX=(int)random(0,4);
    int indY=(int)random(0,4);
       while(cells[indX][indY].dead==false) {
           indX=(int)random(0,4);
           indY=(int)random(0,4);
       }
       cells[indX][indY].dead=false;
       cells[indX][indY].value=2;
       if(random(1)<0.1) 
       cells[indX][indY].value=4;
  }
  void undouble() {
    for(int i=0;i<cells.length;i++) {
        for(int j=0;j<cells[i].length;j++) {
          cells[i][j].doubled=false;
          if(!cells[i][j].dead)
          count++;
    }
    }
    
  }
  
}


void keyPressed() {
  shifted=false;
  Board b=board;
  b.count=0;
  if(keyCode==LEFT) {
      b.goLeft();
    }
   else if(keyCode==RIGHT) {
     b.goRight();
    }
   else if(keyCode==UP) {
       b.goUp();
    }
   else if(keyCode==DOWN) {
       b.goDown();
    }
    //undoubling
    b.undouble();
    
    //adding new cell if the board isnt full
      if(shifted) {
       b.addCell();
      }
       if(b.score>best)
       best = b.score;
    if(b.count==b.lastCount)b.countWrongMoves++;
    else b.countWrongMoves=0;
    if(b.score!=b.lastScore) b.countWrongMoves=0;
  }  
