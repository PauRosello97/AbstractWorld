import java.util.*;

World world;
Time time;
PGraphics agentsList, decimals;
PShader shader;

void setup(){
  size(900, 900, P2D);
  
  // Change interpolation mode to "Nearest node"
  ((PGraphicsOpenGL)g).textureSampling(2);
  
  world = new World();
  shader = loadShader("shader.glsl");
}

void draw(){
  // Update
  world.update();
  
  // Draw
  if(DEBUGGING || mousePressed){
    // If debugging, reset some parameters
    resetShader();
    colorMode(HSB, 360, 100, 100);
    background(0, 0, 100);
    // and draw the world.
    world.draw();
  }else{
    colorMode(RGB, 255, 255, 255);
    
    agentsList = createGraphics(1, WORLD_RES);
    decimals = createGraphics(1, WORLD_RES);
    
    // Draw the graphics
    agentsList.beginDraw();
    decimals.beginDraw();
    world.draw(agentsList, decimals);
    decimals.endDraw();
    agentsList.endDraw();
    
    // Set the uniforms
    shader.set("agentList", agentsList);
    shader.set("decimals", decimals);
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
