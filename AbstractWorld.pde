import java.util.*;

PGraphics g;
PShader shader;
int N_AGENTS = 20;

void setup(){
  size(900, 900, P2D);
  
  shader = loadShader("shader.glsl");
  
  shader.set("resolution", float(width), float(height));
  g = createGraphics(1, 4);
 
}

void draw(){
  
  g.beginDraw();
  g.set(0, 0, color(0., 0., 0, 0));
  g.set(0, 1, color(30., 30., 0, 0));
  g.set(0, 2, color(0., 20., 0, 0));
  g.set(0, 3, color(20., 0., 0, 0));
  g.endDraw();
  
  shader.set("agentList", g);
  
  shader(shader);
  noStroke();
  rect(0, 0, width, height);  
}
