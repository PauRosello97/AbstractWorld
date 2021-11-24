class Food extends PVector{
  
  Food(float _x, float _y){
    x = _x;
    y = _y;
  }
  
  Food(){
    int margin = 50;
    x = random(margin, width-margin);
    y = random(margin, height-margin);
  }
  
  void draw(){
    fill(0, 0, 0);
    ellipse(x, y, 10, 10);
  }
}
