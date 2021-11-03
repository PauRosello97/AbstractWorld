class World{
  
  ArrayList<Human> humans;
  ArrayList<Food> foods; 
  final int INITIAL_HUMANS = 4;
  PShader shader;
  boolean SHADER_MODE = false;
  int STARTING_AGENTS = 10;
  int season = SUMMER;
  //int blendMode = SUBTRACT;
  
  World(){
    shader = loadShader("shader.glsl");
    shader.set("resolution", float(width), float(height));
    time = new Time();
    foods = new ArrayList<Food>();    
    humans = new ArrayList<Human>();
    for(int i=0; i<STARTING_AGENTS; i++) foods.add(new Food(random(width), random(height)));
    for(int i=0; i<STARTING_AGENTS; i++) humans.add(new Human((180*i)%360, random(width), random(height),5));
    //blendMode(SUBTRACT);
  }
  
  void draw(){
    if(SHADER_MODE){
      /*
      PVector[] points = [];
      shader.set("points", points);
      shader(shader);
      rect(0,0,width,height);
      */
    }else{
      //for(Food food : foods) food.draw();
      for (Human human : humans) human.display();   
    }
  }
  
  void update(){
    for (int i=0; i<humans.size(); i++) {
      Human human = humans.get(i);
      human.separate(humans);
      human.update(foods, humans, season);
      human.borders();
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
  
  void newDay(){
    int MAX_NEW_FOOD = 15;
    int newFood = int(humans.size()*random(0.9,1.6));
    newFood = newFood > MAX_NEW_FOOD ? MAX_NEW_FOOD : newFood;
    for(int i=0; i<newFood; i++) foods.add(new Food(random(width), random(height)));  
    
    //blendMode = blendMode == SUBTRACT ? ADD : SUBTRACT;
    //blendMode(blendMode);
    
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
