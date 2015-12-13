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
          loadImage("data/Banana.png"), 
          loadImage("data/BananaShoot.png"), 100 ,
          loadImage("data/BananaBullet.png"),3
        );
        break ;
        
      case Melon : 
       init(
          x , y , 100 ,
          loadImage("data/Banana.png"), 
          loadImage("data/BananaShoot.png"), 100 ,
          loadImage("data/BananaBullet.png"),3
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
    this.x = x ; 
    this.y = y ; 
    this.w = normalImage.width;   
    this.h = normalImage.height; 
    this.normalImage = normalImage ; 
    this.shootImage = shootImage ;  
    this.cycle = cycle ; 
    this.bulletImage = bulletImage ; 
    this.bulletSpeed = bulletSpeed ;
    
    frame = 0 ; 
    currentImage = normalImage ; 
  }

  void displayFlower (){
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
    }else if (frame == cycle - 30){
      currentImage = shootImage ;
      shoot();
    }
    
    for (int i = 0 ; i < maxBulletNum ; i++){
      if (bullets[i] != null && !bullets[i].broken){
        bullets[i].fly ();
      }
    }
  }

  void shoot (){
    for (int i = 0 ; i < maxBulletNum ; i++){
      if (bullets[i] == null || bullets[i].broken){
        float bulletX = x + normalImage.width/2 ;
        float bulletY = y + normalImage.height/2 ;
        bullets[i] = new Bullet (bulletX,bulletY,bulletSpeed,bulletImage) ;
        break ;
      } 
    }
  }
}