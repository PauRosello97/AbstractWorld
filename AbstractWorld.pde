import java.util.*;

PGraphics gra;
PShader shader;
int N_AGENTS = 20;

void setup(){
  size(900, 900, P3D);
  
  ((PGraphicsOpenGL)g).textureSampling(2);
  
  shader = loadShader("shader.glsl");
  shader.set("resolution", float(width), float(height));
  gra = createGraphics(4, 1);
 
}

void draw(){
  
  gra.beginDraw();
  /* THIS VERSION HAS THE SAME RESULT
  g.loadPixels();
  g.pixels[0] = color(0., 0.);
  g.pixels[1] = color(20., 0.);
  g.pixels[2] = color(0., 20.);
  g.pixels[3] = color(20., 20.);  
  g.updatePixels();
  */
  float t = millis() * 0.001;
  gra.set(0, 0, color(100, 100., 255, 0));
  gra.set(1, 0, color(120., 100., 255, 255));
  gra.set(2, 0, color(100., 120., 0, 170));
  gra.set(3, 0, color(120., 120., 0., 255));
  gra.endDraw();
  
  shader.set("agentList", gra);
  
  shader(shader);
  noStroke();
  rect(0, 0, width, height);  
}
