static class MilkSetting {
  static float Speed = -.3 ;
  static float ShowUpFrequency = .5 ;
  static void LevelUp (){
  
    Speed -= .1 ; 
    ShowUpFrequency += .2 ; 
  }
  
  static void ResetLevel (){
    float Speed = -.3 ;
    float ShowUpFrequency = .5 ;
  }
  
} 
class Milk {
  float x ;
  float y ;
  float w ;
  float h ;
  //float speed = -.3 ;
  //float showupProbability = .01 ; 
  int life ;
  PImage[] walkImage = new PImage[4] ;
  int walkImageIndex ;
  float walkImageSwitchInterval ; 
  PImage dieImage ;
  
  
  int cycle ;
  
  PImage currentImage ; 
  int frame ;
  int dieFrame ; 
  
  
  Milk (float x , float y ){
    this.x = x ; 
    this.y = y ; 
    life = 4 ; 
    cycle = 60 ;
    //speed = -.3 ;
    for (int i = 0 ; i < walkImage.length ; i++){
      walkImage[i] = loadImage("img/milk_0"+(i+1)+".png") ;
    }
    this.w = walkImage[0].width ;
    this.h = walkImage[0].height ;
    dieImage = loadImage ("img/milk_05.png") ; 
  }
 
  void display (){
    image (currentImage , x , y ) ;  
  }
  
  void update (){
    frame += 1 ; 
    frame %= cycle ;
    
    if (frame < .25 * cycle  )  currentImage = walkImage[0] ; 
    else if (frame < .5  * cycle)   currentImage = walkImage[1] ; 
    else if (frame < .75 * cycle )  currentImage = walkImage[2] ; 
    else if (frame < cycle) currentImage = walkImage[3] ; 

    if (life <= 0) {
      currentImage =  dieImage ;
      dieFrame++ ; 
    }
    if (isLive())
      x += MilkSetting.Speed; 
  }
  
  void hurt (){
    life -= 1 ;
  }
  boolean isLive (){
    return life > 0 ;
  }
  boolean isTimeForRemove (){
    return life <= 0 && dieFrame >= cycle / 2 ; 
  }
}