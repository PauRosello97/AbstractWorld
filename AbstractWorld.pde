import java.util.*;

World world;
Time time;
PGraphics g;
PShader shader;
int N_AGENTS = 20;

void setup(){
  size(900, 900, P2D);
  //colorMode(HSB, 360, 100, 100, 100);
  world = new World();
  
  shader = loadShader("shader.glsl");
  
  shader.set("resolution", float(width), float(height));
  g = createGraphics(N_AGENTS, 2);
 
}

void draw(){
  //world.draw();
  world.update();
  
  g.beginDraw();
  //g.background(255);
  world.draw(g);
  //g.set(0, 1, color(10, 50 ,0 ,0));
  g.set(0, 2, color(127, 127 ,0 ,0));
  //g.set(1, 0, color(20, 20 ,0 ,0));
  g.endDraw();
  
  shader.set("agentList", g);
  
  shader(shader);
  noStroke();
  rect(0, 0, width, height);  
 
  world.draw();
}

boolean randomBool(){
  return random(1) < 0.5;
}
