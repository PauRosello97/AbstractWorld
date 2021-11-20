class World{
  
  ArrayList<Human> humans;
  ArrayList<Food> foods; 
  final int INITIAL_HUMANS = 4;
  boolean SHADER_MODE = false;
  int STARTING_AGENTS = 10;
  int season = SUMMER;
  
  World(){
    time = new Time();
    foods = new ArrayList<Food>();    
    humans = new ArrayList<Human>();
    for(int i=0; i<STARTING_AGENTS; i++) foods.add(new Food(random(width), random(height)));
    for(int i=0; i<STARTING_AGENTS; i++) humans.add(new Human((180*i)%360, random(width), random(height),5));
  }
  
  void draw(PGraphics agents, PGraphics decimals){
    for (int i=0; i<humans.size(); i++){
      Human human = humans.get(i);
      float pX = map(human.x, 0, width, 0, 255);
      float pY = map(human.y, 0, height, 0, 255);
      
      float decX = pX-int(pX);
      float decY = pY-int(pY);
      decX = map(decX, 0, 1, 0, 255);
      decY = map(decY, 0, 1, 0, 255);
      
      float h = map(human.hue, 0, 360, 0, 255);
      agents.set(0, i, color(pX, pY, h, 0));
      decimals.set(0, i, color(decX, decY, 0, 0));
    }
  }
  
  void draw(){
    //for(Food food : foods) food.draw();
    for (Human human : humans) human.display();   
  }
  
  void update(){
    for (int i=0; i<humans.size(); i++) {
      Human human = humans.get(i);
      human.separate(humans);
      human.update(foods, humans, season);
      //human.borders();
    }
    switch (time.update()){
      case NEW_SEASON:
        season = (season+1)%4;
        println("NEW SEASON: " + season);
      case NEW_DAY:
        newDay();
        print(".");
        break;
    }
  }
  
  int getNAgents(){
    return humans.size();  
  }
  
  void newDay(){
    int MAX_NEW_FOOD = 15;
    int newFood = int(humans.size()*random(0.9,1.6));
    newFood = newFood > MAX_NEW_FOOD ? MAX_NEW_FOOD : newFood;
    for(int i=0; i<newFood; i++) foods.add(new Food(random(width), random(height)));  
    
    Iterator<Human> it = humans.iterator();
    while(it.hasNext()){
      Human human = it.next();
      human.newDay();
      if(human.isDead()){
        foods.add(new Food(human.x, human.y));
        it.remove();
      }
    }
  }
}
