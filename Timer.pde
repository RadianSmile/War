class Timer {
  int startFrame ; 
  
  Timer (){
    start();
  }
  
  void start (){
    startFrame = frameCount ; 
  }
  
  int duration (){
    return floor((frameCount - startFrame) /  int(frameRate)) ; 
  }
  boolean everyTwentySecond (){
    return ((frameCount - startFrame ) % ( int(frameRate) * 20 ) == 0 )   ;
    
  }
}