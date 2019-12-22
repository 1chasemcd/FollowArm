
class Snake {
  
  Point[] points;
  Obstacle[] obs;
  
  Snake(int segs, Obstacle[] obs) {
    points = new Point[segs];
    
    for(int i = 0; i < points.length; i++) {
      points[i] = new Point(i, -10, color(0, 200, i * 255 / points.length));
    }
    
    this.obs = obs;
  }
  
  void update() {
    boolean in = false;
    for (Obstacle o : obs) {
      if (o.pos.dist(new PVector(mouseX, mouseY)) < o.radius) {
        in = true;
        PVector temp0 = new PVector(o.pos.x, o.pos.y);
        PVector temp1 = new PVector(mouseX, mouseY);
        points[0].pos.set(PVector.lerp(temp0, temp1, o.radius / temp0.dist(temp1)));
      }
    }
    
    if (!in) {
      points[0].pos.set(mouseX, mouseY);
    }
  
    for (int i = 1; i < points.length; i++) {
      points[i].update(points[i - 1], obs);
    }
  }
}
