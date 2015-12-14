class Option {
  PImage image ; 
  int cost ; 
  int type ; 
  int alpha ;
  float x ;
  float y ; 
  int w ; 
  int h ; 
  

  Option (int type , int cost , PImage img ){
    this.image = img ; 
    this.cost = cost ;
    this.type = type ;
    this.w = img.width ;
    this.h = img.height ;
    alpha = 255 ; 
  } 
  
  void displayAt (float x , float y){
    this.x = x ; 
    this.y = y ;
    tint (255 , alpha) ; 
    image (image, x, y);
    tint (255,255);
    textSize(20); 
    fill (0);
    
    text(cost, x + image.width/2 , y + image.height/2) ;
    
  }
  void select (){
    alpha =155 ; 
  }
  void unSelect(){
    alpha =255 ; 
  }
  int getCost (){
    return cost ;
  }
  int getType (){
    return type ; 
  }
}