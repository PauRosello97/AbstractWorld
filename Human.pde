class Human extends PVector{
  float hue;
  final int HUMAN_SIZE = 20;
  int energy = 5;
  int objective = REPRODUCE;
  PVector velocity;
  PVector acceleration;
  boolean isAlive;
  Food targetFood;
  Human targetPartner;
  float maxSpeed = 2;
  float maxForce = 2;
  
  Human(float _hue){
    acceleration = new PVector(0,0);
    velocity = new PVector(0,0);
    x = random(width);
    y = random(height);
    hue = _hue;
  }
  
  void draw(){    
    noStroke();
    fill(hue, 100, 100);
    ellipse(x, y, HUMAN_SIZE, HUMAN_SIZE);
  }
  
  void update(){
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    separate(humans);
    this.add(velocity);
    acceleration.mult(0);
    
    //randomWalk();  
    switch(objective){
      case GET_FOOD:
        getFood();
        break;
      case REPRODUCE:
        reproduce();
        break;     
    }
  }
  
  /* FIND FOOD */ 
  
  void findFood(){
    float minDistance = width*2;
    targetFood = null;
    
    for(Food food : foods){
      float dist = this.dist(food);  
      if(dist<minDistance){
        minDistance = dist;
        targetFood = food;
      }
    }
    
    if(targetFood != null) {
      velocity = new PVector(targetFood.x-x, targetFood.y-y);
      velocity.normalize();
    }
  }
  
  /* FIND PARTNER */ 
  void findPartner(){
    float minDistance = width*2;
    targetPartner = null;
    
    for(Human human : humans){
      if(human!=this && human.hue == hue){
        float dist = this.dist(human);  
        if(dist<minDistance){
          minDistance = dist;
          targetPartner = human;
        }
      }
    }
    
    if(targetPartner != null) {
      velocity = new PVector(targetPartner.x-x, targetPartner.y-y);
      velocity.normalize();
    }
  }
  
  /* GET FOOD */
  
  void getFood(){
    findFood();
    if(targetFood!=null){
      if(this.dist(targetFood)<HUMAN_SIZE/2){
        foods.remove(targetFood);  
        energy++;
        setObjective();
        targetFood = null;
        println("Energy: " + energy);
      }
    }
  }
  
  void reproduce(){
    findPartner();
    if(targetPartner!=null){
      if(this.dist(targetPartner)<HUMAN_SIZE/2){
        if(this.energy>=5 && targetPartner.energy>=5){
          humans.add(new Human((targetPartner.hue+hue)/2));
          energy-=3;
          targetPartner.energy-=3;
          setObjective();
          targetPartner = null;
          println("Reproduced: " + energy);
        }
      }
    }
  }  
    
  void applyForce(PVector force){
    acceleration.add(force);  
  }
  
  /* SEPARATE */
  // From The Nature of Code by Daniel Shiffman
  void separate (ArrayList<Human> humans) {
    float desiredseparation = HUMAN_SIZE*2;
    PVector sum = new PVector();
    int count = 0;
    for (Human other : humans) {
      float d = PVector.dist(this, other);
      if ((d > 0) && (d < desiredseparation)) {
        PVector diff = PVector.sub(this, other);
        diff.normalize();
        diff.div(d);
        sum.add(diff);
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      sum.normalize();
      sum.mult(maxSpeed);
      PVector steer = PVector.sub(sum, velocity);
      //steer.limit(maxForce);
      applyForce(steer);
    }
  }
  
  void setObjective(){
    objective = REPRODUCE;
    //if(energy<5) objective = GET_FOOD;  
    //else objective = REPRODUCE;
  }
  
  void newDay(){
    energy--;
    isAlive = energy>0;
    setObjective();
  }
  
  boolean isDead(){
    return !isAlive;
  }
}
