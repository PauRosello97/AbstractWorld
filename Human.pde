class Human extends Mover{

  float hue;
  PVector target;
  int objective;
  int energy;
  boolean sex;
  int RADIUS_UNIT = 5;
  
  Human(float _hue, float _x, float _y, int e){
    super(_x, _y);
    target = new PVector(width/2, height/2);
    hue = _hue;
    sex = randomBool();
    energy = e;
  }
    
  void display() {
    fill(hue, 100, 100);
    noStroke();
    super.display();
  }
  
  void update(ArrayList<Food> foods, ArrayList<Human> humans, int season){
    r = energy*RADIUS_UNIT;
    setObjective();
    target = getTarget(foods, humans, season);
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
        if(this.dist(target)<r) reproduce(humans);
    }
  }
  
  PVector getTarget(ArrayList<Food> foods, ArrayList<Human> humans, int season){
    switch (objective){
      case FIND_FOOD:
        return findClosestFood(foods);
      case REPRODUCE:
        return findBestPartner(humans, season);
    }
    return null;
  }
  
  void eatTargetFood(ArrayList<Food> foods){
    foods.remove(target);
    energy++;
  }
  
  void reproduce(ArrayList<Human> humans){
    Human targetPartner = new Human(0, x, y, 0);
    for(Human human : humans) if(target == human) targetPartner = human;
    if(energy>5 && targetPartner.energy>5){
      energy -= 2;
      targetPartner.energy -= 2;
      
      float childHue;
      if(random(1)>0.98){
        // Mutation
        childHue = random(360);
      }else if(abs(hue-targetPartner.hue)==180){
        float extra = randomBool() ? 180 : 0;  
        childHue = (hue+targetPartner.hue)/2 + extra;
      }else{
        // TODO: Get hue from both sides of the wheel
        childHue = (hue+targetPartner.hue)/2;
      }
      humans.add(new Human(childHue, x, y, 2));
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
  
  PVector findBestPartner(ArrayList<Human> humans, int season){
    int bestScore = 0;
    Human targetPartner = null;
    for(Human human : humans){
      int score = 1;
      if(this != human){
        if(human.sex != sex){
          score += 1;
          if(human.hue == hue && season!=SPRING) score +=3;    
          score += human.energy;
        }
        
        if(score>bestScore){
          bestScore = score;
          targetPartner = human;
        }
      }
    }
    return bestScore > 0 ? targetPartner : null;
  }
  
  void newDay(){
    energy --;  
    age ++;
  }
  
  boolean isDead(){
    return energy<1;  
  }
  
}
