class Human extends Mover{

  float hue;
  PVector target;
  int objective;
  int energy = 5;
  
  Human(float _hue){
    super();
    target = new PVector(width/2, height/2);
    hue = _hue;
  }
    
  void display() {
    fill(hue, 100, 100);
    super.display();
  }
  
  void update(ArrayList<Food> foods, ArrayList<Human> humans){
    r = energy*5;
    setObjective();
    target = getTarget(foods, humans);
    if(target!=null) seek(target);
    super.updateMover();
    if(target!=null) checkObjective(foods, humans);
  }
  
  void setObjective(){
    if(energy>5) objective = REPRODUCE;
    else objective = FIND_FOOD;
  }
  
  void checkObjective(ArrayList<Food> foods, ArrayList<Human> humans){
    switch (objective){
      case FIND_FOOD:
        if(this.dist(target)<r/2) eatTargetFood(foods);
        break;
      case REPRODUCE:
        if(this.dist(target)<r/2) reproduce(humans);
    }
  }
  
  PVector getTarget(ArrayList<Food> foods, ArrayList<Human> humans){
    switch (objective){
      case FIND_FOOD:
        return findClosestFood(foods);
      case REPRODUCE:
        return findBestPartner(humans);
    }
    return null;
  }
  
  void eatTargetFood(ArrayList<Food> foods){
    foods.remove(target);
    energy++;
  }
  
  void reproduce(ArrayList<Human> humans){
    Human targetPartner = new Human(0);
    for(Human human : humans) if(target == human) targetPartner = human;
    if(energy>5 && targetPartner.energy>5){
      energy -= 3;
      targetPartner.energy -= 3;
      humans.add(new Human(hue));
    }
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
    return targetFood;
  }
  
  PVector findBestPartner(ArrayList<Human> humans){
    int bestScore = 0;
    Human targetPartner = null;
    for(Human human : humans){
      int score = 0;
      if(this != human){
        if(human.hue == hue) score +=3;    
        if(score>bestScore){
          bestScore = score;
          targetPartner = human;
        }
      }
    }
    return targetPartner;
  }
  
}
