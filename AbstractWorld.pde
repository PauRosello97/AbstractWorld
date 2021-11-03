import java.util.*;

World world;
Time time;
PGraphics myGraphics;

void setup(){
  size(900, 900, P2D);
  colorMode(HSB, 360, 100, 100, 100);
  world = new World();
  //blendMode(REPLACE);
  myGraphics = createGraphics(width, height);
  background(0);
}

void draw(){
  myGraphics.beginDraw();
  myGraphics.background(0, 10+10*sin(millis()/1000));
  world.draw();
  myGraphics.endDraw();
  image(myGraphics, 0, 0);
  //background(0, 0, 50, 80);
  world.update();
}

boolean randomBool(){
  return random(1) < 0.5;
}
