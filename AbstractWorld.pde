import java.util.*;

World world;
Time time;

void setup(){
  size(900, 900, P2D);
  colorMode(HSB, 360, 100, 100);
  world = new World();
}

void draw(){
  background(125);
  world.update();
  world.draw();
}

boolean randomBool(){
  return random(1) < 0.5;
}
