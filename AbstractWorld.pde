import java.util.*;
import oscP5.*;
import netP5.*;

World world;
Time time;
PGraphics agentsList, decimals;
PShader shader;
OscP5 oscP5;
NetAddress remoteLocation;

void setup(){
  size(900, 900, P2D);
  ((PGraphicsOpenGL)g).textureSampling(2);
  
  oscP5 = new OscP5(this, 9999);
  remoteLocation = new NetAddress("127.0.0.1", 9999);
  
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
    agentsList = createGraphics(1, WORLD_RES);
    decimals = createGraphics(1, WORLD_RES);
    agentsList.beginDraw();
    decimals.beginDraw();
    world.draw(agentsList, decimals);
    decimals.endDraw();
    agentsList.endDraw();
    
    shader.set("agentList", agentsList);
    shader.set("decimals", decimals);
    shader.set("maxAgents", world.getNAgents());
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
