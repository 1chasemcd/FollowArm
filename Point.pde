class Point {
  float radius = 8;
  PVector pos;
  color c;
  
  Point(float x, float y, color c) {
    pos = new PVector(x, y);
    this.c = c;
  }
  
  void update(Point prev, Obstacle[] obs) {
    boolean done = false;
    PVector tempPos = new PVector(pos.x, pos.y);
    tempPos.add((prev.pos.x - pos.x) * ((pos.dist(prev.pos) - radius) / (pos.dist(prev.pos))),
            (prev.pos.y - pos.y) * ((pos.dist(prev.pos) - radius) / (pos.dist(prev.pos))));
    
    for (Obstacle o : obs) {
      if (tempPos.dist(o.pos) < o.radius) {
        pos.set(avoidCollide(prev, o));
        this.show(prev);
        done = true;
      }
    }
    
    if (!done) {
      pos.set(tempPos);
      this.show(prev);
    }
  }

  void show(Point prev) {
    stroke(c);
    line(pos.x, pos.y, prev.pos.x, prev.pos.y);
  }
  
  // I have no clue how this works -- I tried to solve a two circle system of equations
  // myself, but it was way to difficult. Math here courtesy of ambrsoft.com
  PVector avoidCollide(Point p, Obstacle o) {
    // (x - a)^2 + (y - b)^2 = r0^2, (x - c)^2 + (y - d)^2 = r1^2
    float a = p.pos.x;
    float b = p.pos.y;
    float r0 = p.radius;
    
    float c = o.pos.x;
    float d = o.pos.y;
    float r1 = o.radius;
    
    // distance between two circles
    float D = sqrt((c - a) *(c - a) + (d - b) * (d - b));
    
    // Heron's formula
    float cd = (1.0/4.0) * sqrt((D + r0 + r1) * (D + r0 - r1) * (D - r0 + r1) * (-D + r0 + r1));
    
    PVector p0 = new PVector(0, 0);
    PVector p1 = new PVector(0, 0);
    PVector pf = new PVector(0, 0);
    
    p0.x = ((a + c) / 2) + (((c - a) * (r0 * r0 - r1 * r1)) / (2 * D * D)) + (2 * ((b - d) / (D * D)) * cd);
    p0.y = ((b + d) / 2) + (((d - b) * (r0 * r0 - r1 * r1)) / (2 * D * D)) - (2 * ((a - c) / (D * D)) * cd);
    p1.x = ((a + c) / 2) + (((c - a) * (r0 * r0 - r1 * r1)) / (2 * D * D)) - (2 * ((b - d) / (D * D)) * cd);
    p1.y = ((b + d) / 2) + (((d - b) * (r0 * r0 - r1 * r1)) / (2 * D * D)) + (2 * ((a - c) / (D * D)) * cd);
    
    if (pos.dist(p0) < pos.dist(p1)) {
      pf.set(p0);
    } else {
      pf.set(p1);
    }
    
    return pf;
  }
}
