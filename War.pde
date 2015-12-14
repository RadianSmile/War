PImage startImg  ;
PImage endImg ;
PImage bgImg ;

final int START = 0 ,  PLAY = 1 , WIN = 2 , LOSE = 3 ;
final int Banana = 100 , Melon = 200 ;
final int BananaCost = 50  , MelonCost = 100 ;

int gameState ;

Garden garden ;
Plant[][] plants ;

ArrayList<Bullet> bullets ;
ArrayList<Milk> milks ;

Sun sun ;
Timer timer ;  
int sunGrade;
int fruitOption ;

Option BananaOption ; 
Option MelonOption ; 

void setup (){
  
  gameState = START ;
  
  BananaOption = new Option(Banana, BananaCost, loadImage("data/BananaOption.png") ) ;
  MelonOption =  new Option(Melon , MelonCost , loadImage("data/BananaOption.png") ) ;  
  resetGame();
  size(640,480);
  //frameRate (10) ;
}

void draw (){
  switch (gameState){
    case START:
      background (0);
      fill(225);text("ENTER",width/2,height/2);
      break ;
    case PLAY :
      
      background (100);
      

      // process plants and collision test with milk 
      for (int i = 0 ; i < Garden.colNum ; i++){
        for (int j = 0 ; j < Garden.rowNum ; j++){
          if (plants[i][j] != null ) {
            Plant p = plants[i][j];
            p.display();
            p.update();
            
            if (p.isTimeForShoot()){  
              bullets.add(p.generateBullet()) ; 
            }
            
            //  collision test with milk  
            for (int k = 0 ; k < milks.size(); k++){
              Milk m = milks.get(k) ;
              if(m.isLive() && isHit (m.x,m.y,m.w,m.h, p.x,p.y,p.w,p.h))
                plants[i][j] = null ; // means die  
            }
             
          }
        }
      }
      
      // process bullets and collision test with milk 
      for (int i = 0 ; i < bullets.size(); i++){
        Bullet b = bullets.get(i) ; 
        if (b.isBroken()){
          bullets.remove(i--) ; 
        }else{
          b.fly();
          b.display();
          
          for (int j = 0 ; j < milks.size(); j++){
            Milk m = milks.get(j) ;
            if( isHit (m.x,m.y,m.w,m.h, b.x,b.y,b.w,b.h) ){
              bullets.remove(i--) ; // mean broken 
              m.hurt();
              break ;
            }
          }
        }
      }
      
      // process Milk and check wether lose
      for (int i = 0 ; i < milks.size(); i++){
        Milk m = milks.get(i); 
        if (m.isTimeForRemove()){
          milks.remove(i--) ; 
        }else{
          m.update();
          m.display();  
          if (m.x < 0) gameState = LOSE ;
        }
      }
      
      //  add milk with probablity 0.7 / frameRate per frame
      if (isTrueWithFrequency(MilkSetting.ShowUpFrequency)){
        int randomRowIndex = floor(random (Garden.rowNum));
        int x = width ; 
        int y = Garden.getGardenYbyRowIndex(randomRowIndex) ; 
        Milk newMilk = new Milk (x, y) ; 
        milks.add (newMilk) ;
      }
      
      // Sun and its collision test
      sun.display () ;
      sun.update () ;
      if (isHit(sun.x , sun.y , sun.w , sun.h , mouseX , mouseY, 0, 0)){
        sun.getEaten();
        sunGrade += 50 ;
      }
      
      textSize (20);
      text("Sun : " + sunGrade , 10,20);
      text("Time : " + timer.duration() , 150,20);
      
      BananaOption.displayAt(0,50);
      MelonOption.displayAt(0,180);
      
      if ( timer.everyTwentySecond()){
        MilkSetting.LevelUp();
      }
      
      break ;
      
      // plant option
      

    case WIN :
      resetGame();
      background (0);
      fill(225);text("ENTER",width/2,height/2);
      break ;
    case LOSE :
      resetGame();
      background (0);
      fill(225);text("ENTER",width/2,height/2);
      
      break ;
  }
}
void resetGame (){
  fruitOption = Banana ;
  BananaOption.select () ;
  sunGrade = 0 ; 
  plants = new Plant[Garden.colNum][Garden.rowNum] ;
  sun = new Sun () ;
  bullets = new ArrayList() ; 
  milks = new ArrayList() ;
  timer = new Timer () ; 
}
void mouseReleased(){

  // add plant
  if (Garden.isMouseInGarden(mouseX,mouseY)){
    int colIndex = Garden.mouseXtoColumnIndex(mouseX) ;
    int rowIndex = Garden.mouseYtoRowIndex(mouseY) ;
    int plantX = Garden.getGardenXByColIndex(colIndex) ; 
    int plantY = Garden.getGardenYbyRowIndex(rowIndex) ;
    println (colIndex,rowIndex) ; 
    if (plants[colIndex][rowIndex] == null){
      Plant plant = new Plant(fruitOption,plantX,plantY);
      if (sunGrade >= plant.cost){
        plants[colIndex][rowIndex] = plant; 
        sunGrade -= plant.cost ;
      }
    }
  }
  
  if (isHit(BananaOption.x , BananaOption.y , BananaOption.w , BananaOption.h , mouseX , mouseY, 0, 0)){
    BananaOption.select () ; 
    MelonOption.unSelect() ; 
    fruitOption = BananaOption.type ; 
  }else if (isHit(MelonOption.x , MelonOption.y , MelonOption.w , MelonOption.h , mouseX , mouseY, 0, 0)){
    BananaOption.unSelect () ; 
    MelonOption.select() ; 
    fruitOption = MelonOption.type ; 
  }
  
}

void keyReleased (){
  if (keyCode == ENTER && (gameState == START || gameState == LOSE ||gameState == WIN)){
    gameState = PLAY ;
  }
}

boolean isTrueWithFrequency (float frequency){
  return random(1) <= frequency / frameRate; 
}

boolean isHit(float ax, float ay, float aw, float ah, float bx, float by, float bw, float bh) {
  return (
    ax+aw > bx       &&
    ax    < bx + bw  &&
    ay+ah > by       &&
    ay    < by + bh  );
}