class Obstacle {
  PVector pos;
  float radius;
  Obstacle(float x, float y, float radius) {
    this.pos = new PVector(x, y);
    this.radius = radius;
  }
  
  void show() {
    noStroke();
    fill(255, 0, 0);
    ellipse(pos.x, pos.y, radius*2, radius*2);
  }
}
