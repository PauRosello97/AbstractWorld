class Food extends PVector{
  
  Food(){
    x = random(width);
    y = random(height);
  }
  
  void draw(){
    fill(0, 0, 0);
    ellipse(x, y, 10, 10);
  }
}
