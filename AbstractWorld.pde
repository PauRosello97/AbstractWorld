import java.util.*;

Time time;
ArrayList<Mover> humans;
ArrayList<Food> foods; 
int nHumans = 4;

void setup(){
  size(900, 900);
  colorMode(HSB, 360, 100, 100);
  //humans = new ArrayList<Human>();
  foods = new ArrayList<Food>();
  //humans.add(new Human(0));
  //humans.add(new Human(0));
  //humans.add(new Human(180));
  //humans.add(new Human(180));
  for(int i=0; i<4; i++) foods.add(new Food());
  humans = new ArrayList<Mover>();
  for (int i = 0; i < 100; i++) {
    humans.add(new Human(random(width),random(height)));
  }
  time = new Time();
}

void draw(){
  background(125);
  update();
 
  //for(Human human : humans)human.draw();
  for(Food food : foods) food.draw();
  
  for (Mover human : humans) {
    human.seek(new PVector(mouseX, mouseY));
    human.separate(humans);
    human.update();
    human.borders();
    human.display();
  }
}

void update(){
  /*
  for(int i=0; i<humans.size(); i++){
    humans.get(i).separate(humans);
    humans.get(i).update();
  }
  int event = time.update();
  switch(event){
    case NEW_DAY:
      newDay();
  }
  */
}



void newDay(){
  /*
  Iterator<Human> iter = humans.iterator();
            
  while(iter.hasNext()){
    Human human = iter.next();
    human.newDay();
    if(human.isDead()){
      println("DEAD");
      iter.remove();
    }
  }
  
  for(int i=0; i<5; i++) foods.add(new Food()); 
  */
}
