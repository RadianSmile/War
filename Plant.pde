class Plant {
  
  float x ;
  float y ;
  float w ;
  float h ;
  PImage normalImage ; 
  PImage shootImage ;
  int cost ; 
  float cycle ; 
  
  PImage bulletImage ; 
  float bulletSpeed ;
  final int maxBulletNum  = 10; 
  Bullet[] bullets = new Bullet[maxBulletNum]; 
  
  
  int frame ;
  PImage currentImage ; 
  
  Plant (int type , float x , float y){
    
    switch (type){
      case Banana: 
        init(
          x , y , 50 ,
          loadImage("img/banana_smile.png"), 
          loadImage("img/banana_angry.png"), 60 ,
          loadImage("img/banana_bullet.png"),3
        );
        break ;
        
      case Melon : 
       init(
          x , y , 100 ,
          loadImage("img/hami_smile.png"), 
          loadImage("img/hami_angry.png"), 60 / 3  ,
          loadImage("img/hami_bullet.png"),3
        );
        break ;
    }
  }
  
  
  void init (
    float x , float y , int cost , 
    PImage normalImage ,
    PImage shootImage, float cycle,
    PImage bulletImage, float bulletSpeed
  ){
    this.x = x + 5 ; 
    this.y = y + 15 ; 
    this.w = normalImage.width;   
    this.h = normalImage.height; 
    this.normalImage = normalImage ; 
    this.shootImage = shootImage ;  
    this.cycle = cycle ; 
    this.bulletImage = bulletImage ; 
    this.bulletSpeed = bulletSpeed ;
    this.cost = cost ; 
    frame = 0 ; 
    currentImage = normalImage ; 
  }

  void display (){
    image(currentImage,x,y);

  }
  void displayBullet (){
    for (int i = 0 ; i < maxBulletNum ; i++){
      if (bullets[i] != null && !bullets[i].broken){
        bullets[i].display();
      }
    }  
  }
  
  void update (){
    frame += 1 ;
    frame %= cycle ; 
    
    if (frame == 0 ){
      currentImage = normalImage ; 
    }else if (frame == cycle - 10){
      currentImage = shootImage ;
    }
  
    for (int i = 0 ; i < maxBulletNum ; i++){
      if (bullets[i] != null && !bullets[i].broken){
        bullets[i].fly ();
      }
    }
  }
  
  boolean isTimeForShoot (){
    return frame == cycle - 10 ; 
  }
  
  Bullet generateBullet (){
    float bulletX = x + normalImage.width/2 - bulletImage.width/2 ;
    float bulletY = y + normalImage.height/2 - bulletImage.height/2 ;
    Bullet bullet = new Bullet (bulletX,bulletY,bulletSpeed,bulletImage) ;
    return bullet ; 
  }
  //void shoot (){
  //  for (int i = 0 ; i < maxBulletNum ; i++){
  //    if (bullets[i] == null || bullets[i].broken){
  //      float bulletX = x + normalImage.width/2 ;
  //      float bulletY = y + normalImage.height/2 ;
  //      bullets[i] = new Bullet (bulletX,bulletY,bulletSpeed,bulletImage) ;
  //      break ;
  //    } 
  //  }
  //}
}