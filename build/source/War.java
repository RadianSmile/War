import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class War extends PApplet {

PImage startImg  ;
PImage endImg ;
PImage bgImg ;

final int START = 0 ,  PLAY = 1 , WIN = 2 , LOSE = 3 ;
final int Banana = 100 , Melon = 200 ;


final int BananCost = 50  , MelonCost = 100 ;

int gameState ;

// level 1
Sun sun ;
Garden garden ;
int sunGrade = 0 ;

Milk milk ;

int fruitOption = Banana ;


public void setup (){
  

  sun = new Sun () ;
  garden = new Garden () ;
  gameState = START ;
  milk = new Milk (width,height/2) ;
}

public void draw (){
  switch (gameState){
    case START:
      background (0);
      break ;
    case PLAY :

      background (100);
      sun.display () ;
      sun.update () ;

      garden.display() ;
      garden.update() ;

      milk.update();
      milk.display();

      textSize (20);
      text("Sun : " + sunGrade , 10,20);


      // Sun collision test
      if (isHit(sun.x , sun.y , sun.w , sun.h , mouseX , mouseY, 0, 0)){
        sun.getEaten();
        sunGrade += 50 ;
      }

      // Bullet collision test


      break ;
    case WIN :
      break ;
    case LOSE :
      break ;

  }



}

public void mouseReleased(){
  if (fruitOption == Banana && sunGrade >= BananCost){
    sunGrade -= BananCost ;
  } else if (fruitOption == Melon ){
    sunGrade -= BananCost ;
  } else return ;
  garden.addPlant(fruitOption,mouseX , mouseY) ;
}

public void keyReleased (){
  if (key == ENTER && gameState == START){
    gameState = PLAY ;
  }

}

public boolean isHit(float ax, float ay, float aw, float ah, float bx, float by, float bw, float bh) {
  return (
    ax+aw > bx       &&
    ax    < bx + bw  &&
    ay+ah > by       &&
    ay    < by + bh  );
}
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
  
  public void display (){
    image (image,x,y) ; 
  }
  
  public void fly (){
    x += speed ; 
    if (x > 2 * width ) broken = true ; 
    
  }
}
class Garden {

  final int colNum = 9 ;
  final int rowNum = 5 ;
  Plant[][] plants = new Plant[colNum][rowNum] ;
  
  final int left = 0 , right = 500 , top = 100 , bottom = 400 ;  
  final int w = right - left ;
  final int h = bottom - top ;
  final float wSpacing = w / colNum ;
  final float hSpacing = h / rowNum ;
  

  Garden (){
    plants [0][0] = new Plant (Banana,100,10) ;
  }

  public void addPlant (int type , int mouseX , int mouseY ){
    if (mouseX <= left || mouseX >= right || mouseY <= top || mouseY >= bottom ) return ;
    println (mouseX,mouseY);
    int colIndex = floor((mouseX -left )  / wSpacing ); 
    int rowIndex = floor((mouseY - top) / hSpacing );
    
    int x = PApplet.parseInt(left + colIndex * wSpacing) ; 
    int y = PApplet.parseInt(top + rowIndex * hSpacing) ; 
    if (plants[colIndex][rowIndex] == null ) plants[colIndex][rowIndex] = new Plant (type , x , y) ;
  }

  public void display (){
    for (int i = 0 ; i < colNum ; i++){
      for (int j = 0 ; j < rowNum ; j++){
        if (plants[i][j] != null ) plants[i][j].displayFlower() ; 
      }
    }
    for (int i = 0 ; i < colNum ; i++){
      for (int j = 0 ; j < rowNum ; j++){
        if (plants[i][j] != null ) plants[i][j].displayBullet() ; 
      }
    }
  }
   
  public void update (){
    for (int i = 0 ; i < colNum ; i++){
      for (int j = 0 ; j < rowNum ; j++){
        if (plants[i][j] != null ) plants[i][j].update();
      }
    }
  }
  
}
class Milk {
  float x ;
  float y ;
  float w ;
  float h ;
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
    speed = -.5f ;
    for (int i = 0 ; i < walkImage.length ; i++){
      walkImage[i] = loadImage("data/Milk"+i+".png") ;
    }
    dieImage = loadImage ("data/MilkDie.png") ; 
  }
 
  public void display (){
    image (currentImage , x , y ) ;  
  }
  
  public void update (){
    frame += 1 ; 
    frame %= cycle ;
    
    if (frame < .25f * cycle  )  currentImage = walkImage[0] ; 
    else if (frame < .5f  * cycle)   currentImage = walkImage[1] ; 
    else if (frame < .75f * cycle )  currentImage = walkImage[2] ; 
    else if (frame < cycle) currentImage = walkImage[3] ; 

    if (life <= 0) currentImage =  dieImage ;
    x += speed; 
  }
  
  public void hurt (){
    life -= 1 ;
  }
}
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
  
  
  public void init (
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

  public void displayFlower (){
    image(currentImage,x,y);

  }
  public void displayBullet (){
    for (int i = 0 ; i < maxBulletNum ; i++){
      if (bullets[i] != null && !bullets[i].broken){
        bullets[i].display();
      }
    }  
  }
  
  public void update (){
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

  public void shoot (){
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
    img = loadImage ("data/Sun.png");
    w = img.width;
    h = img.height ; 

    resetPosition () ; 
    cycle = 300 ; 
    frame = 0 ; 
    
    speed = 1 ;
    eaten = false ; 
  }
  
  public void display () {
    image (img ,x , y) ; 
  }
  
  public void update (){
    if (!eaten && y < height - 2*img.width ) y+= speed ;
    
    frame += 1 ; 
    frame %= cycle ;
    if (frame == 0 ) eaten = false ; 
    
  }
  
  public void getEaten (){
    
    eaten = true ;
    frame = 0 ;
    resetPosition () ; 
  }
  
  public void resetPosition () {
    x = random (100,width - img.width);
    y = -h ;
  }
}
  public void settings() {  size(640,480); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "War" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
