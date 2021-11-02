class World{
  
  ArrayList<Human> humans;
  ArrayList<Food> foods; 
  final int INITIAL_HUMANS = 4;
  
  World(){
    foods = new ArrayList<Food>();
    
    humans = new ArrayList<Human>();
    for(int i=0; i<4; i++) foods.add(new Food());
    humans.add(new Human(0));
    humans.add(new Human(0));
    humans.add(new Human(180));
    humans.add(new Human(180));
    time = new Time();
  }
  
  void draw(){
    for(Food food : foods) food.draw();
  
    for (Human human : humans) {
      human.separate(humans);
      human.update(foods);
      human.borders();
      human.display();
    }
  }
  
  void update(){
    
  }
}
