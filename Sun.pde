class Sun {
  float x ; 
  float y ; 
  float w ; 
  float h ; 
  float speed ;
  PImage img ; 
  boolean eaten ;
  
  int frame ;
  int cycle ; 
  
  Sun (){
    img = loadImage ("img/money.png");
    w = img.width;
    h = img.height ; 

    resetPosition () ; 
    cycle = 200 ; 
    frame = 0 ; 
    
    speed = 1 ;
    eaten = false ; 
  }
  
  void display () {
    image (img ,x , y) ; 
  }
  
  void update (){
    if (!eaten && y < height - 2*img.width ) y+= speed ;
    
    frame += 1 ; 
    frame %= cycle ;
    if (frame == 0 ) eaten = false ; 
    
  }
  
  void getEaten (){
    
    eaten = true ;
    frame = 0 ;
    resetPosition () ; 
  }
  
  void resetPosition () {
    x = random (100,width - img.width);
    y = -h ;
  }
}