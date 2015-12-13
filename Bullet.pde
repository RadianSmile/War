class Bullet {
  PImage image ; 
  float speed ; 
  float x ; 
  float y ; 
  boolean broken ; 
  
  
  Bullet (float x ,float y,float speed,PImage image  ){
    this.x = x ; 
    this.y = y ; 
    this.speed = speed ; 
    this.image = image ; 
  }
  
  void display (){
    image (image,x,y) ; 
  }
  
  void fly (){
    x += speed ; 
    if (x > 2 * width ) broken = true ; 
    
  }
}