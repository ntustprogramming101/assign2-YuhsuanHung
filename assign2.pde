PImage title,startHovered,startNormal;
PImage skyimg;
PImage soilimg;
PImage lifeimg1;
PImage lifeimg2;
PImage lifeimg3;
PImage gameover,restartHovered,restartNormal;
//groundhog
PImage groundhogIdle;
PImage groundhogDown,groundhogLeft,groundhogRight;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;
int gameState = GAME_START;

int groundhogX1,groundhogY1;//position
int speed=80/16;//15change to 16

boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;
boolean hogIdle=false;
//life
int life=2;
int score=1;

//soldier
PImage soldier;
int soldierX;
int soldierY;
//cabbage
PImage cabbage;
int cabbageX,cabbageY;


void setup() {
  size(640, 480, P2D);
  //start
  title=loadImage("img/title.jpg");
  startHovered=loadImage("img/startHovered.png");
  startNormal=loadImage("img/startNormal.png");
  //run
  skyimg=loadImage("img/bg.jpg");//skyImage
  soilimg=loadImage("img/soil.png");//soilImage
  lifeimg1=loadImage("img/life.png");//hear1
  lifeimg2=loadImage("img/life.png");//hear2
  lifeimg3=loadImage("img/life.png");//hear3
    //soldier
  soldier=loadImage("img/soldier.png");
  soldierX=-80;
  soldierY=80*floor(random(2,6));
    //groundhog
  groundhogIdle=loadImage("img/groundhogIdle.png");//groundhog
  groundhogRight=loadImage("img/groundhogRight.png");
  groundhogLeft=loadImage("img/groundhogLeft.png");
  groundhogDown=loadImage("img/groundhogDown.png");
  groundhogX1=320;
  groundhogY1=80;
  if(hogIdle){
    image(groundhogIdle,groundhogX1,groundhogY1);
  }
    //cabbage
  cabbage=loadImage("img/cabbage.png");
  cabbageX=80*floor(random(8));
  cabbageY=80*floor(random(2,6));
  //over
  gameover=loadImage("img/gameover.jpg");
  restartNormal=loadImage("img/restartNormal.png");
  restartHovered=loadImage("img/restartHovered.png");
}
  
void draw() {
  image(title,0,0);//bg
  switch(gameState){
    case GAME_START:
    if(mouseX>248&&mouseX<392&&mouseY>360&&mouseY<420){
      image(startHovered,248,360);
      if(mousePressed){
          gameState = GAME_RUN;
        }
  }else{
    image(startNormal,248,360);
  }
  break;
  
  case GAME_RUN:
  // picture
    //background
  image(skyimg,0,0);//skyImage
  image(soilimg,0,160);//soilImage
    //lawn
  fill(RGB);
  fill(124,204,25);//green
  noStroke();
  rect(0,145,640,15);//lawnSize
    //sun
  colorMode(RGB);
  fill(253,184,19);//orange
  stroke(255,255,0);//yellow
  strokeWeight(5);
  ellipse( 590, 50, 120, 120 );//ellipseSize

    //soldier
  image(soldier,soldierX,soldierY);//soldierPosition
  soldierX+=2;
  if(soldierX>=640){
    soldierX=-80;
  }//come back again
  
    //life
  if(life==0){
    gameState=GAME_OVER;
  }
  if(life==1){
    image(lifeimg1,10,10);//heart1
  }
  if(life==2){
    image(lifeimg1,10,10);//heart1
    image(lifeimg2,80,10);//heart2
  }
  if(life==3){
    image(lifeimg1,10,10);//heart1
    image(lifeimg2,80,10);//heart2
    image(lifeimg3,150,10);//heart3
  }
  
    //groundhog
    if(groundhogX1==320&&groundhogY1==80){
    image(groundhogIdle,groundhogX1,groundhogY1);
    }
    if(hogIdle){
    image(groundhogIdle,groundhogX1,groundhogY1);
    }
    if (downPressed) {
    hogIdle=false;
    image(groundhogDown,groundhogX1,groundhogY1);
    groundhogY1 += speed;
    leftPressed=false;
    rightPressed=false;
    if(groundhogY1>height-80)groundhogY1=height-80;
    if(groundhogY1%80==0){//160,240,320,400stop
      downPressed=false;
      hogIdle=true;
    }
  }
    if (leftPressed) {
    hogIdle=false;
    image(groundhogLeft,groundhogX1,groundhogY1);
    groundhogX1 -= speed;
    downPressed=false;
    rightPressed=false;
    if(groundhogX1<0)groundhogX1=0;
    if(groundhogX1%80==0){//160,240,320,400stop
      leftPressed=false;
      hogIdle=true;
     }
  }
    if (rightPressed) {
    hogIdle=false;
    image(groundhogRight,groundhogX1,groundhogY1);
    groundhogX1 += speed;
    downPressed=false;
    leftPressed=false;
    if(groundhogX1>width-80)groundhogX1=width-80;
    if(groundhogX1%80==0){//160,240,320,400stop
      rightPressed=false;
      hogIdle=true;
    }
  }
    //eat the cabbage
    if(groundhogX1<cabbageX+80&&groundhogX1+80>cabbageX
    &&groundhogY1<cabbageY+80&&groundhogY1+80>cabbageY){
    cabbageX=width+80;
    cabbageY=height+80;
    life+=score;
    }
    //touch the solier
    if(groundhogX1<soldierX+80&&groundhogX1+80>soldierX
    &&groundhogY1<soldierY+80&&groundhogY1+80>soldierY){
    downPressed=false;//new
    rightPressed=false;
    leftPressed=false;
    groundhogX1=320;
    groundhogY1=80;
    life-=score;
  }
    //cabbage
    image(cabbage,cabbageX,cabbageY);
    break;
 
 case GAME_OVER:
   image(gameover,0,0);
   if(mouseX>248&&mouseX<392&&mouseY>360&&mouseY<420){
      image(restartHovered,248,360);
   if(mousePressed){
      gameState = GAME_RUN;
      life=2;

      //soldier
      soldier=loadImage("img/soldier.png");
      soldierX=-80;
      soldierY=80*floor(random(2,6));
      //cabbage
      cabbage=loadImage("img/cabbage.png");
      cabbageX=80*floor(random(8));
      cabbageY=80*floor(random(2,6));
    }
  }else{
    image(restartNormal,248,360);
  }
 break;
  }
 }

void keyPressed() {
if (key == CODED) { 
switch (keyCode) {
case DOWN:
downPressed = true;
if (rightPressed) {
downPressed=false;
}
if (leftPressed) {
downPressed=false;
}
break;
case LEFT:
leftPressed = true;
if (rightPressed) {
leftPressed=false;
}
if (downPressed) {
leftPressed=false;
}
break;
case RIGHT:
rightPressed = true;
if (leftPressed) {
rightPressed=false;
}
if (downPressed) {
rightPressed=false;
}
break;
    }
  }
}
