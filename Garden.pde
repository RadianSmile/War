static class Garden {

  static final int colNum = 8 ;
  static final int rowNum = 4 ;
  static final int left = 95 , right = 625 , top = 90 , bottom = 470 ;  
  static final int w = right - left ;
  static final int h = bottom - top ;
  static final float wSpacing = w / colNum ;
  static final float hSpacing = h / rowNum ;  
  
  static boolean isMouseInGarden (int mouseX , int mouseY){
    return  (mouseX > left && mouseX < right && mouseY > top && mouseY < bottom ) ;  
  }
  static int mouseXtoColumnIndex (int mouseX){
    return floor((mouseX -left )  / wSpacing ); 
  }
  static int getGardenXByColIndex (int colIndex){
    return int(left + colIndex * wSpacing);
  }
  static int mouseYtoRowIndex (int mouseY){
    return  floor((mouseY - top) / hSpacing ); 
  }
  static int getGardenYbyRowIndex (int rowIndex){
    return int(top + rowIndex * hSpacing) ;
  }
}