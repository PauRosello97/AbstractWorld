class Human extends Mover{

  float hue;
  PVector target;
  int objective;
  
  Human(float _hue){
    super();
    target = new PVector(width/2, height/2);
    hue = _hue;
  }
    
  void display() {
    fill(hue, 100, 100);
    super.display();
  }
  
  void update(ArrayList<Food> foods){
    setObjective();
    target = getTarget(foods);
    if(target!=null) seek(target);
    super.updateMover();
    if(target!=null) checkObjective(foods);
  }
  
  void setObjective(){
    objective = FIND_FOOD;
  }
  
  void checkObjective(ArrayList<Food> foods){
    switch (objective){
      case FIND_FOOD:
        if(this.dist(target)<r/2) eatTargetFood(foods);
    }
  }
  
  PVector getTarget(ArrayList<Food> foods){
    switch (objective){
      case FIND_FOOD:
        return findClosestFood(foods);
    }
    return null;
  }
  
  void eatTargetFood(ArrayList<Food> foods){
    foods.remove(target);
  }
  
  PVector findClosestFood(ArrayList<Food> foods){
    float minDistance = width*2;
    Food targetFood = null;
    for(Food food : foods){
      float distance = this.dist(food);
      if(distance<minDistance){
        minDistance = distance;
        targetFood = food;
      }
    }
    println(targetFood);
    return targetFood;
  }
}
