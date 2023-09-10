//Name; Tarik Hasan Kurnaz
//ID; 300486204
//username; kurnaztari

float gravity = 9.8;
float x, y, vy; //reset these
float radius = 20; 
boolean movingY = true;
boolean regularGravity = true;
long frameNumber =0; //reset
float frameRate=60;
ArrayList<obstacle> obstacles = new ArrayList<obstacle>();
ArrayList<obstacle> currentObs = new ArrayList<obstacle>();
ArrayList<BG> backgroundList = new ArrayList<BG>();
int currentBGIndex = 0;
int currentType = 0;
player ball = null;
boolean mainMenu = true;
boolean endless = false;
boolean touchingGround = false;
final int waitCounter=1000;
int levelEndX=0;
boolean lost = false;
int losingCounter = 0;
boolean wonLevel = false;
int endlessCounter = 0;
boolean drawArrow = false;
int arrowCounter = 0;

void setup() {
  size(500, 500);
  frameRate(frameRate);
  x=70;
  y = 450;
  ball = new player(radius*2, radius*2);
}    

void addObstaclesLevel() {
  //some notes; 150 is the minimum distance needed for height of 300
  obstacles.add(new obstacle(2500, 200, 50, 300)); //1
  obstacles.add(new obstacle(2750, 000, 50, 300));
  obstacles.add(new obstacle(3100, 000, 70, 150));
  obstacles.add(new obstacle(3100, 350, 70, 150));  
  obstacles.add(new obstacle(3600, 000, 50, 400));
  obstacles.add(new obstacle(3750, 100, 50, 400));
  obstacles.add(new obstacle(3900, 000, 50, 400));
  obstacles.add(new obstacle(4300, 200, 50, 300));
  obstacles.add(new obstacle(4500, 000, 50, 300));
}

void addBackgroundLevel() {
  int xBG=0;
  backgroundList.add( new BG(xBG, 0, 700, height, 2));
  xBG+=700;
  backgroundList.add( new BG(xBG, 0, 700, height, 3));
  xBG+=700;
  backgroundList.add( new BG(xBG, 0, 600, height, 1));
  xBG+=600;
  backgroundList.add( new BG(xBG, 0, 1500, height, 2));
  xBG+=1500;
  backgroundList.add(new BG(xBG, 0, 600, height, 1));
  xBG+=600;
  backgroundList.add(new BG(xBG, 0, 500, height, 3));
  levelEndX=xBG+500;
}


void addObstaclesEndless(float xBG, float xBGEnd, int type, int lastPosition) {
  if (xBG<xBGEnd) {
    if (type==1) {
      int startX = (int)xBG + 100 + (int)random(50);
      int widthO = (int)random(40)+30;
      int heightO = (int)random(300)+100;
      int position = (int)random(3);
      while (position==lastPosition) {
        position = (int)random(3);
      }
      int startY = 0;
      if (position==1) {
        heightO=(int)random(200)+200;
        startY = height-heightO;
      } else if (position==2) {
        startY = (int)random(height-heightO);
      } else {
        heightO=(int)random(200)+200;
      }

      if (startX+widthO<xBGEnd) {
        obstacles.add(new obstacle(startX, startY, widthO, heightO));
        addObstaclesEndless(startX+widthO, xBGEnd, type, position);
      }
    } else if (type==2) {
      int startX = (int)xBG + 150 + (int)random(150);
      int widthO = (int)random(40)+30;
      int heightO = (int)random(300)+100;
      int position = (int)random(3);
      while (position==lastPosition) {
        position = (int)random(3);
      }
      int startY = 0;
      if (position==1) {
        if (lastPosition==2) {
          heightO=(int)random(100)+150;
          startY = height-heightO;
        } else {
          heightO=(int)random(200)+200;
          startY = height-heightO;
        }
      } else if (position==2) {
        startY = (int)random(height-heightO);
      } else {
        if (lastPosition==2) {
          heightO=(int)random(100)+150;
        } else {
          heightO=(int)random(200)+200;
        }
      }

      if (startX+widthO<xBGEnd) {
        obstacles.add(new obstacle(startX, startY, widthO, heightO));
        addObstaclesEndless(startX+widthO, xBGEnd, type, position);
      }
    } else if (type==3) {
      int startX = (int)xBG + 200 + (int)random(150);
      int widthO = (int)random(40)+30;
      int heightO = (int)random(200)+150;
      int position = (int)random(2);
      while (position==lastPosition) {
        position = (int)random(2);
      }
      int startY = 0;
      if (position==1) {
        heightO=(int)random(200)+200;
        startY = height-heightO;
      } else {
        heightO=(int)random(200)+200;
      }

      if (startX+widthO<xBGEnd) {
        obstacles.add(new obstacle(startX, startY, widthO, heightO));
        addObstaclesEndless(startX+widthO, xBGEnd, type, position);
      }
    }
  }
}

void addBackgroundEndless(float xBG, int lastType) {
  int type = 0;
  for (int i =0; i<5; i++) {
    int randomWidth =(int)(width+random(2)*width);
    while (lastType==type || type==0) {
      type = (int)(random(3)+1);
    }
    backgroundList.add( new BG(xBG, 0, randomWidth, height, type));
    addObstaclesEndless(xBG, xBG + randomWidth, type, 1);
    xBG= xBG + randomWidth;
    lastType = type;
  }
}
void drawMenu() {
  resetLevel();
  mainMenu=true;
  endless=false;
  textAlign(CENTER);
  background(255);
  fill(0, 100, 255);
  textSize(75);
  text("Gravity Ball", width/2, 100);
  noFill();
  rect(width/10-25, height/2-50, 200, 100); //Level
  rect(width/2+width/10-25, height/2-50, 200, 100);  //endless
  fill(0);
  textSize(50);
  text("Tutorial", width/10+75, height/2+20);
  text("Endless", width/2+width/10+75, height/2+20);
  textSize(13);
  fill(255, 0, 0);
  text("Red means the player can teleport between the roof and the ground", width/2, 350);
  fill(0, 255, 0);
  text("Green means the player can change gravity whenever", width/2, 400);
  fill(0, 0, 255);
  text("Blue means the player can change gravity only while touching a surface", width/2, 450);
}

void resetLevel() {
  obstacles = new ArrayList<obstacle>();
  currentObs = new ArrayList<obstacle>();
  backgroundList = new ArrayList<BG>();
  currentBGIndex = 0;
  currentType = 0;
  ball = null;
  mainMenu = true;
  endless = false;
  frameNumber=0;
  movingY = true;
  regularGravity = true;
  vy=0;
  endlessCounter=0;
  setup();
}

void playLevel() {
  clear(); //clear the screen
  background(255);

  frameNumber=frameNumber+1;
  for (long i=0; i<frameNumber; i++) {
    moveEverything();
  }
  for (int i=0; i<backgroundList.size(); i++) {
    BG b = backgroundList.get(i);
    //b.translate(3);
    if (x-100>b.getEnd()) {
      backgroundList.remove(i);
      i--;
      if (backgroundList.size()>0) {
        currentBGIndex--;
      }
    } else if (x+width+100>b.getX()) {
      b.draw();
    }
  }
  for (int i=0; i<obstacles.size(); i++) {
    obstacle o = obstacles.get(i);
    //o.translate(3);
    if (x-100>o.getXEnd()) {
      obstacles.remove(i);
      i--;
    } else if (x+width>o.getX()) {
      o.draw();
      currentObs.add(o);
    }
  }
  x=x+3;
  ball.draw(x, y, levelEndX);

  if (ball.isHit(currentObs)) {
    lost=true;
  }
  currentObs.clear();
  if (currentBGIndex<backgroundList.size()) {
    if (x>backgroundList.get(currentBGIndex).getEnd()) {
      currentBGIndex++;
    }
  }
  if (currentBGIndex>=backgroundList.size()) {
    currentType=0;
    if (obstacles.size()==0) {
      fill(0);
      textSize(75);
      textAlign(CENTER);
      text("YOU WIN", x+180, height/2);
      wonLevel=true;
    }
  } else {
    currentType=backgroundList.get(currentBGIndex).getType();
  }
  if (movingY) {
    if (regularGravity) {
      vy = vy+ gravity/100;
    } else vy = vy -gravity/60;
    y = y + vy;
  }
  if (y+radius>=height-2 ) {
    vy = 0;
    //movingY = false;
    float overflowX = y+radius-height+2;
    y=y-overflowX;
    //regularGravity = true;
    touchingGround=true;
  } else if (y<=radius) {
    vy = 0;
    //movingY = false;
    float overflowX = y-radius;
    y=y-overflowX;
    //regularGravity = false;
    touchingGround=true;
  } else {
    movingY = true;
    touchingGround=false;
  }
}


void playEndless() {
  clear(); //clear the screen
  background(255);

  frameNumber=frameNumber+1;
  for (long i=0; i<frameNumber; i++) {
    moveEverything();
  }
  if (backgroundList.size()==1) {
    addBackgroundEndless(backgroundList.get(0).getEnd(), backgroundList.get(0).getType());
  }
  for (int i=0; i<backgroundList.size(); i++) {
    BG b = backgroundList.get(i);
    if (x-100>b.getEnd()) {
      backgroundList.remove(i);
      i--;
      if (backgroundList.size()>0) {
        currentBGIndex--;
      }
    } else if (x+width+100>b.getX()) {
      b.draw();
    }
  }
  for (int i=0; i<obstacles.size(); i++) {
    obstacle o = obstacles.get(i);
    if (x-100>o.getXEnd()) {
      obstacles.remove(i);
      i--;
      endlessCounter++;
    } else if (x+width>o.getX()) {
      o.draw();
      currentObs.add(o);
    }
  }
  x=x+3;
  ball.draw(x, y, true, (int)(frameNumber-(int)(frameNumber/60)));
  //could write the current score which is number of obstacles deleted
  textAlign(RIGHT);
  fill(255);
  textSize(25);
  text(endlessCounter, x+width-80, 25);
  //int frameSpeed = 60+10*(int)(x/2500);
  //if (frameSpeed>120) {
  //  frameSpeed=120;
  //}
  //frameRate(frameSpeed);
  if (ball.isHit(currentObs)) {
    lost=true;
  }
  currentObs.clear();
  if (currentBGIndex<backgroundList.size()) {
    if (x>backgroundList.get(currentBGIndex).getEnd()) {
      currentBGIndex++;
    }
  }
  if (currentBGIndex>=backgroundList.size()) {
    currentType=0;
  } else {
    currentType=backgroundList.get(currentBGIndex).getType();
  }
  if (movingY) {
    if (regularGravity) {
      vy = vy+ gravity/100;
    } else vy = vy -gravity/60;
    y = y + vy;
  }
  if (y+radius>=height-2 ) {
    vy = 0;
    //movingY = false;
    float overflowX = y+radius-height+2;
    y=y-overflowX;
    //regularGravity = true;
    touchingGround=true;
  } else if (y<=radius) {
    vy = 0;
    //movingY = false;
    float overflowX = y-radius;
    y=y-overflowX;
    //regularGravity = false;
    touchingGround=true;
  } else {
    movingY = true;
    touchingGround=false;
  }
}
void drawArrowShape(boolean up) {
  fill(255);
  beginShape();
  if (!up) {
    vertex(x-radius/2, y-radius*4/3);
    vertex(x+radius/2, y-radius*4/3);
    vertex(x+radius/2, y-radius*6/3);
    vertex(x+radius*4/3, y-radius*6/3);
    vertex(x, y-radius*3);
    vertex(x-radius*4/3, y-radius*6/3);
    vertex(x-radius/2, y-radius*6/3);
    vertex(x-radius/2, y-radius*4/3);
  } else {
    vertex(x-radius/2, y+radius*4/3);
    vertex(x+radius/2, y+radius*4/3);
    vertex(x+radius/2, y+radius*6/3);
    vertex(x+radius*4/3, y+radius*6/3);
    vertex(x, y+radius*3);
    vertex(x-radius*4/3, y+radius*6/3);
    vertex(x-radius/2, y+radius*6/3);
    vertex(x-radius/2, y+radius*4/3);
  }
  endShape();
}
void draw() {

  if (mainMenu) {
    drawMenu();
  } else if (endless) {
    if (lost) {
      for (long i=0; i<frameNumber; i++) {
        moveEverything();
      }
      textSize(75);
      fill(255);
      textAlign(CENTER);
      text("YOU LOSE", x+180, height/2);
      textSize(30);
      text("Your score was: "+endlessCounter, x+180, height/2+50);
      ball.loseAnimation(losingCounter);
      losingCounter+=10;
      if (losingCounter>width*2) {
        lost= false;
      }
      //delay(waitCounter);
      if (!lost) {
        resetLevel();
        mainMenu =true;
        losingCounter=0;
      }
    } else {
      playEndless();
    }
  } else if (!endless) {
    if (lost) {
      for (long i=0; i<frameNumber; i++) {
        moveEverything();
      }
      textSize(75);
      fill(255);
      textAlign(CENTER);
      text("YOU LOSE", x+180, height/2);
      ball.loseAnimation(losingCounter);
      losingCounter+=10;
      if (losingCounter>width*2) {
        lost= false;
      }
      //delay(waitCounter);
      if (!lost) {
        resetLevel();
        mainMenu =true;
        losingCounter=0;
      }
    } else {
      playLevel();
    }
  }
  if (drawArrow) {
    drawArrowShape(regularGravity);
    arrowCounter++;
    if (arrowCounter>=10) {
      arrowCounter=0;
      drawArrow=false;
    }
  }
}

void moveEverything() {
  translate(-3, 0);
}


void mouseReleased() {
  if (mainMenu) {
    if (mouseX>width/10-25 && mouseX<width/10+175 && mouseY>height/2-50 && mouseY<height/2+50) {
      mainMenu=false;
      endless=false;
      addObstaclesLevel();
      addBackgroundLevel();
    } else if (mouseX>width/2+width/10-25 && mouseX<width/2+width/10+175 && mouseY>height/2-50 && mouseY<height/2+50) {
      mainMenu=false;
      endless=true;
      backgroundList.add( new BG(0, 0, 300, height, 2));
      addBackgroundEndless(300, 0);
    }
  } else {
    if (currentType==2) {
      //vy = 0;
      regularGravity ^= true; //flips the gravity boolean
      movingY= true;
      if (!lost) {
        drawArrow=true;
      }
    } else if (currentType==3) {
      if (touchingGround) {
        regularGravity ^= true; //flips the gravity boolean
        movingY= true;
        if (!lost) {
          drawArrow=true;
        }
      }
    } else if (currentType==1) {
      if (touchingGround) {
        regularGravity ^= true;
        if (y>height/2) {
          y=radius;
        } else {
          y=height-radius;
        }
      }
    } else if (currentType==0 && wonLevel) {
      mainMenu=true;
      endless=false;
      resetLevel();
    }
  }
}
