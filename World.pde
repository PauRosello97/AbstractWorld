class World{
  
  ArrayList<Human> humans;
  ArrayList<Food> foods; 
  final int INITIAL_HUMANS = 4;
  boolean SHADER_MODE = false;
  int STARTING_AGENTS = 10;
  int season = WINTER;
  
  World(){
    time = new Time();
    foods = new ArrayList<Food>();    
    humans = new ArrayList<Human>();
    for(int i=0; i<STARTING_AGENTS; i++) foods.add(new Food());
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
    for(Food food : foods) food.draw();
    for (Human human : humans) human.display();   
  }
  
  void update(){
    for (int i=0; i<humans.size(); i++) {
      Human human = humans.get(i);
      human.separate(humans);
      human.update(foods, humans, season);
    }
    switch (time.update()){
      case NEW_SEASON:
        season = (season+1)%4;
        newSeason();
      case NEW_DAY:
        newDay();
      case NEW_HOUR:
        newHour();
        
    }
  }
  
  int getNAgents(){
    return humans.size();  
  }
  
  void newHour(){
    int nFood = int(random(4));
    for(int i=0; i<nFood; i++) foods.add(new Food());  
  }
  
  void newDay(){    
    Iterator<Human> it = humans.iterator();
    
    log(NEW_DAY);
    int i = 0;
    while(it.hasNext()){
      i++;
      Human human = it.next();
      human.newDay();
      if(human.isDead()){
        foods.add(new Food(human.x, human.y));
        it.remove();
        log("RIP n" + i + " with color " + int(human.hue) + ". " + humans.size() + " humans alive.");
      }
    }
  }
  
  void newSeason(){
    String[] seasonNames = {"WINTER", "SPRING", "SUMMER", "FALL"};
    log("---------------------------------------");
    log("[[ " + seasonNames[season] + " ARRIVED ]]");
  }
}
