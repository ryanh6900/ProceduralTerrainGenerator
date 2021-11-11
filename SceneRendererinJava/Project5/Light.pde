class Light{
  color rgb;
  PVector pos;
  
  Light(color aColor, PVector position){
    pos=position;
    rgb = aColor;
  }
  
  void setLight(){
    pointLight(red(rgb), green(rgb), blue(rgb),pos.x,pos.y,pos.z);
  }
}
