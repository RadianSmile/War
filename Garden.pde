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

  void addPlant (int type , int mouseX , int mouseY ){
    if (mouseX <= left || mouseX >= right || mouseY <= top || mouseY >= bottom ) return ;
    println (mouseX,mouseY);
    int colIndex = floor((mouseX -left )  / wSpacing ); 
    int rowIndex = floor((mouseY - top) / hSpacing );
    
    int x = int(left + colIndex * wSpacing) ; 
    int y = int(top + rowIndex * hSpacing) ; 
    if (plants[colIndex][rowIndex] == null ) plants[colIndex][rowIndex] = new Plant (type , x , y) ;
  }

  void display (){
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
  
  void update (){
    for (int i = 0 ; i < colNum ; i++){
      for (int j = 0 ; j < rowNum ; j++){
        if (plants[i][j] != null ) plants[i][j].update();
      }
    }
  }
  
  
}