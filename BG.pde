public class BG{
   float x, y, widthP, heightP;
   int type; // =1 for red, =2 green, =3 for blue
  
  BG(float xNew,float yNew,float widthNew,float heightNew, int typeNew){
    x = xNew; y = yNew;
    widthP = widthNew;
    heightP = heightNew;
    type = typeNew;
  }
  
  void draw(){
    if (type==1){
      fill(255,150,150);
    } else if (type==2){
      fill(150,255,150);
    } else if (type ==3){
      fill(150, 150, 255);
    } else {
      return;
    }
    rect(x, y, widthP, heightP);
  }
  int getType(){
   return type; 
  }
  float getX(){
    return x;
  }
  float getEnd(){
    return x+widthP;
  }
  
  void translate(float xChange){
    this.x = this.x-xChange;
  }
}
