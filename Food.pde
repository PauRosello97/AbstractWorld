class Food extends PVector{
  
  Food(float _x, float _y){
    x = _x;
    y = _y;
  }
  
  void draw(){
    fill(0, 0, 0);
    ellipse(x, y, 10, 10);
  }
}
