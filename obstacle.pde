public class obstacle{
  float x, y, widthP, heightP;
  
  obstacle(float xNew,float yNew,float widthNew,float heightNew){
    x = xNew; y = yNew;
    widthP = widthNew;
    heightP = heightNew;
  }
  
  void draw(){
    fill(0);
    rect(x, y, widthP, heightP);
  }
  
  float getX(){
    return x;
  }
  float getXEnd(){
    return x+widthP; 
  }
  float getY(){
    return y;
  }
  float getYEnd(){
    return y+heightP;
  }
  void translate(float xChange){
    this.x = this.x-xChange;
  }
}
