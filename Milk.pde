class Milk {
  float x ;
  float y ;
  float speed ;
  int life ;
  PImage[] walkImage = new PImage[4] ;
  int walkImageIndex ;
  float walkImageSwitchInterval ; 
  PImage dieImage ;
  
  
  int cycle ;
  
  PImage currentImage ; 
  int frame ; 
  
  
  Milk (float x , float y ){
    this.x = x ; 
    this.y = y ;
    life = 5 ; 
    cycle = 60 ;
    speed = -.5 ;
    for (int i = 0 ; i < walkImage.length ; i++){
      walkImage[i] = loadImage("data/Milk"+i+".png") ;
    }
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

    if (life <= 0) currentImage =  dieImage ;
    x += speed; 
  }
  
  void hurt (){
    life -= 1 ;
  }
}