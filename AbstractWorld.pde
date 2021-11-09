import java.util.*;

PGraphics g;
PShader shader;
int N_AGENTS = 20;

void setup(){
  size(900, 900, P2D);
  
  shader = loadShader("shader.glsl");
  
  shader.set("resolution", float(width), float(height));
  g = createGraphics(4, 1);
 
}

void draw(){
  
  g.beginDraw();
  /* THIS VERSION HAS THE SAME RESULT
  g.loadPixels();
  g.pixels[0] = color(0., 0.);
  g.pixels[1] = color(20., 0.);
  g.pixels[2] = color(0., 20.);
  g.pixels[3] = color(20., 20.);  
  g.updatePixels();
  */
  float t = millis() * 0.001;
  g.set(0, 0, color(100+50*sin(t), 100., 0, 0));
  g.set(1, 0, color(120., 100., 0, 0));
  g.set(2, 0, color(100., 120., 0, 0));
  g.set(3, 0, color(120., 120., 0, 0));
  g.endDraw();
  
  shader.set("agentList", g);
  
  shader(shader);
  noStroke();
  rect(0, 0, width, height);  
}
