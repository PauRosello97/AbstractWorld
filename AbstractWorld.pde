import java.util.*;

World world;
Time time;
PGraphics gra, decimals;
PGraphics worldCanvas;
PShader shader;
final int MAX_AGENTS = 20;
final int WORLD_RES = 50;
PImage cat;

final boolean DEBUGGING = false;
final boolean LOGGING = true;;

void setup(){
  size(900, 900, P2D);
  ((PGraphicsOpenGL)g).textureSampling(2);
  
  world = new World();
  
  shader = loadShader("shader.glsl");
  gra = createGraphics(1, MAX_AGENTS);
  decimals = createGraphics(1, MAX_AGENTS);
}

void draw(){
  // Update
  world.update();
  
  // Draw
  if(DEBUGGING || keyPressed){
    colorMode(HSB, 360, 100, 100);
    background(0, 0, 100);
    world.draw();
  }else{
    gra.beginDraw();
    decimals.beginDraw();
    world.draw(gra, decimals);
    decimals.endDraw();
    gra.endDraw();
    
    shader.set("agentList", gra);
    shader.set("decimals", decimals);
    shader.set("maxAgents", MAX_AGENTS);
    shader.set("nAgents", world.getNAgents());
    
    shader(shader);
    noStroke();
    rect(0, 0, width, height);  
  }
}

boolean randomBool(){
  return random(1) < 0.5;
}
