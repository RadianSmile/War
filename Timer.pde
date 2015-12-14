class Timer {
  int startFrame ; 
  
  Timer (){
    start();
  }
  
  void start (){
    startFrame = frameCount ; 
  }
  
  int duration (){
    return floor((frameCount - startFrame) /  frameRate) ; 
  }
  boolean everyTwentySecond (){
    return ((frameCount - startFrame ) % ( int(frameRate) * 20 ) == 0 )   ;
    
  }
}