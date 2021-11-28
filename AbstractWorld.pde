import java.util.*;

World world;
Time time;
PGraphics gra, decimals;
PShader shader;

void setup(){
  size(900, 900, P2D);
  ((PGraphicsOpenGL)g).textureSampling(2);
  
  world = new World();
  
  shader = loadShader("shader.glsl");
}

void draw(){
  // Update
  world.update();
  
  // Draw
  if(DEBUGGING || mousePressed){
    resetShader();
    colorMode(HSB, 360, 100, 100);
    background(0, 0, 100);
    world.draw();
  }else{
    colorMode(RGB, 255, 255, 255);
    gra = createGraphics(1, WORLD_RES);
    decimals = createGraphics(1, WORLD_RES);
    gra.beginDraw();
    decimals.beginDraw();
    world.draw(gra, decimals);
    decimals.endDraw();
    gra.endDraw();
    
    shader.set("agentList", gra);
    shader.set("decimals", decimals);
    shader.set("maxAgents", DISPLAYING_AGENTS);
    shader.set("nAgents", world.getNAgents());
    shader.set("center", world.getCenter());
    
    shader(shader);
    noStroke();
    rect(0, 0, width, height);  
  }
}

boolean randomBool(){
  return random(1) < 0.5;
}
