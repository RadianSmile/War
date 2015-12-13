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


void setup (){
  size(640,480);

  sun = new Sun () ;
  garden = new Garden () ;
  gameState = START ;
  milk = new Milk (width,height/2) ;
}




void draw (){
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

void mouseReleased(){
  if (fruitOption == Banana && sunGrade >= BananCost){
    sunGrade -= BananCost ;
  } else if (fruitOption == Melon ){
    sunGrade -= BananCost ;
  } else return ;
  garden.addPlant(fruitOption,mouseX , mouseY) ;
}

void keyReleased (){
  if (key == ENTER && gameState == START){
    gameState = PLAY ;
  }

}

boolean isHit(float ax, float ay, float aw, float ah, float bx, float by, float bw, float bh) {
  return (
    ax+aw > bx       &&
    ax    < bx + bw  &&
    ay+ah > by       &&
    ay    < by + bh  );
}