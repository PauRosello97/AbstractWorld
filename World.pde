class World{
  
  ArrayList<Human> humans;
  ArrayList<Food> foods; 
  final int INITIAL_HUMANS = 4;
  
  World(){
    time = new Time();
    foods = new ArrayList<Food>();    
    humans = new ArrayList<Human>();
    for(int i=0; i<4; i++) foods.add(new Food(random(width), random(height)));
    humans.add(new Human(0, random(width), random(height),5));
    humans.add(new Human(0, random(width), random(height),5));
    humans.add(new Human(180, random(width), random(height),5));
    humans.add(new Human(180, random(width), random(height),5));
  }
  
  void update(){
    for (int i=0; i<humans.size(); i++) {
      Human human = humans.get(i);
      human.separate(humans);
      human.update(foods, humans);
      human.borders();
    }
    switch (time.update()){
      case NEW_DAY:
        newDay();
        break;
    }
  }
  
  void draw(){
    for(Food food : foods) food.draw();
    for (Human human : humans) human.display();    
  }
  
  void newDay(){
    int newFood = humans.size()*int(random(0.5,1.5));
    for(int i=0; i<6; i++) foods.add(new Food(random(width), random(height)));  
    
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
