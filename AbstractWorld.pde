import java.util.*;

World world;
Time time;

void setup(){
  size(900, 900);
  colorMode(HSB, 360, 100, 100);
  world = new World();
}

void draw(){
  background(125);
  world.update();
  world.draw();
}
