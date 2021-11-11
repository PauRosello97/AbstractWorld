import java.util.*;

World world;
Time time;
PGraphics gra;
PShader shader;
int N_AGENTS = 20;

void setup(){
  size(900, 900, P3D);
  
  ((PGraphicsOpenGL)g).textureSampling(2);
  //colorMode(HSB, 360, 100, 100, 100);
  world = new World();
  
  shader = loadShader("shader.glsl");
  shader.set("resolution", float(width), float(height));
  gra = createGraphics(1, N_AGENTS);
 
}

void draw(){
  //world.draw();
  world.update();
  
  gra.beginDraw();
  //g.background(255);
  world.draw(gra);
  gra.set(0, 4, color(0., 0., 0, 0));
  //gra.set(0, 1, color(30., 30., 0, 0));
  //gra.set(0, 2, color(10., 20., 0, 0));
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
