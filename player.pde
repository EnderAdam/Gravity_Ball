public class player {
  float x, y, widthP, heightP;

  player(float widthNew, float heightNew) {
    widthP = widthNew;
    heightP = heightNew;
  }
  void draw(float xNew, float yNew, boolean isEndless, int drawCount) {
    if (isEndless) {
      x=xNew; 
      y=yNew;
      float angleCircle = drawCount*PI/60;
      //fill(0);
      //ellipse(x, y, widthP, heightP);
      fill(255, 0, 0); //red circle
      ellipse(x, y, widthP, heightP);
      fill(0, 255, 0); //green circle 
      ellipse(x+cos(angleCircle)*widthP/4, y+sin(angleCircle)*heightP/4, widthP/2, heightP/2);

      fill(0, 0, 255); //blue circle
      ellipse(x+cos(angleCircle)*widthP/20, y+sin(angleCircle)*heightP/20, widthP/10, heightP/10);
      fill(0, 0, 0); //black circle
      ellipse(x-cos(angleCircle)*widthP*7/100, y-sin(angleCircle)*heightP*7/100, widthP*7/50, heightP*7/50);
      fill(255, 255, 0); //yellow circle
      ellipse(x+cos(angleCircle)*widthP*3/100, y+sin(angleCircle)*heightP*3/100, widthP*3/50, heightP*3/50);
      fill(255, 0, 255); //magenta circle
      ellipse(x+cos(angleCircle)*widthP*47/100, y+sin(angleCircle)*heightP*3/100, widthP*3/50, heightP*3/50);
      fill(255, 255, 255); //white circle
      if (drawCount<30) { //for a half second, show the white circle inside the black one.
        ellipse(x-cos(angleCircle)*widthP*7/100, y-sin(angleCircle)*heightP*7/100, widthP*3/50, heightP*3/50);
      } //else, it doesnt show any white circle
      if (drawCount==60) { //when the count reaches 60, make it 0. (this happens every second)
        drawCount=0;
      }
      drawCount++; //updates the draw Count.
    }
  }
  void draw(float xNew, float yNew, int levelEnd) {
    x=xNew; 
    y=yNew;
    fill((float)xNew/levelEnd*255);
    ellipse(x, y, widthP, heightP);
  }
  boolean isHit(ArrayList<obstacle> obstacles) {
    for (obstacle o : obstacles) {
      boolean xColl = false; //x-collision
      boolean yColl = false;
      if (x+widthP/2>=o.getX() && x-widthP/2<=o.getXEnd()) {
        xColl=true;
      }
      if (y+heightP/2>=o.getY() && y-heightP/2<=o.getYEnd()) {
        yColl=true;
      }
      if (xColl && yColl) {
        return true;
      }
    }
    return false;
  }

  float getWidth() {
    return widthP;
  }

  //void loseAnimation(float state){
  //  if (state<width){
  //    fill(255);
  //    ellipse(x,y,state,state);
  //    loseAnimation(state+0.1);
  //    //delay(100)
  //  }
  //}
  void loseAnimation(float state) {
    fill(255);
    ellipse(x, y, state, state);
  }
}
