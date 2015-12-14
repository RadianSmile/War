class Bullet {
  PImage image ; 
  float speed ; 
  float x ; 
  float y ; 
  float w ; 
  float h ;
  boolean broken ; 
  
  
  Bullet (float x ,float y,float speed,PImage image  ){
    this.x = x ; 
    this.y = y ; 
    this.speed = speed ; 
    this.image = image ;
    this.w = image.width ;
    this.h = image.height ;
  }
  
  void display (){
    image (image,x,y) ; 
  }
  
  void fly (){
    x += speed ; 
  }
  boolean isBroken (){
    return  (x > 2 * width ); 
  }
}