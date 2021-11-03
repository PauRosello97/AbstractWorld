class World{
  
  ArrayList<Human> humans;
  ArrayList<Food> foods; 
  final int INITIAL_HUMANS = 4;
  
  World(){
    time = new Time();
    foods = new ArrayList<Food>();    
    humans = new ArrayList<Human>();
    for(int i=0; i<4; i++) foods.add(new Food());
    humans.add(new Human(0));
    humans.add(new Human(0));
    humans.add(new Human(180));
    humans.add(new Human(180));
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
    foods.add(new Food());  
    foods.add(new Food());  
    foods.add(new Food());  
    foods.add(new Food());  
  }
}
