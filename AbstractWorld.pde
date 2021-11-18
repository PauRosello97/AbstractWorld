import java.util.*;

World world;
Time time;
PGraphics gra;
PGraphics worldCanvas;
PShader shader;
final int MAX_AGENTS = 20;
final int WORLD_RES = 50;
boolean recording = false;
PImage cat;

void setup(){
  size(900, 900, P2D);
  ((PGraphicsOpenGL)g).textureSampling(2);
  
  world = new World();
  
  shader = loadShader("shader.glsl");
  gra = createGraphics(1, MAX_AGENTS);
}

void draw(){
  world.update();
  gra.beginDraw();
  world.draw(gra);
  gra.endDraw();
  
  shader.set("agentList", gra);
  shader.set("maxAgents", MAX_AGENTS);
  shader.set("nAgents", world.getNAgents());
  
  shader(shader);
  noStroke();
  rect(0, 0, width, height);  
 
  //world.draw();
}

boolean randomBool(){
  return random(1) < 0.5;
}
