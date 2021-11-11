import java.util.*;

World world;
Time time;
PGraphics gra;
PShader shader;
int N_AGENTS = 20;

void setup(){
  size(900, 900, P3D);
  
  ((PGraphicsOpenGL)g).textureSampling(2);
  world = new World();
  
  shader = loadShader("shader.glsl");
  shader.set("resolution", float(width), float(height));
  gra = createGraphics(1, N_AGENTS);
 
}

void draw(){
  world.update();
  gra.beginDraw();
  world.draw(gra);
  gra.endDraw();
  
  shader.set("agentList", gra);
  
  shader(shader);
  noStroke();
  rect(0, 0, width, height);  
 
  world.draw();
}

boolean randomBool(){
  return random(1) < 0.5;
}
