class Mover extends PVector {

  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    
  float maxspeed;    

  Mover(float _x, float _y) {
    x = _x;
    y= _y;
    r = 12;
    maxspeed = 3;
    maxforce = 0.2;
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void separate (ArrayList<Mover> movers) {
    float desiredseparation = r*2;
    PVector sum = new PVector();
    int count = 0;
    
    for (Mover other : movers) {
      float d = PVector.dist(this, other);
      
      if ((d > 0) && (d < desiredseparation)) {
        
        PVector diff = PVector.sub(this, other);
        diff.normalize();
        diff.div(d);        
        sum.add(diff);
        count++;            
      }
    }
    
    if (count > 0) {
      
      sum.setMag(maxspeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      applyForce(steer);
    }
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    this.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    fill(175);
    ellipse(x, y, r, r);
  }
  
  void seek(PVector target) {
    PVector desired = PVector.sub(target,this);
    desired.normalize();
    desired.mult(maxspeed/2);
    PVector steer = PVector.sub(desired,velocity);

    steer.limit(maxforce/2);
    applyForce(steer);
  }

  // Wraparound
  void borders() {
    if (x < -r) x = width+r;
    if (y < -r) y = height+r;
    if (x > width+r) x = -r;
    if (y > height+r) y = -r;
  }
}
