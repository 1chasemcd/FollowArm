
Obstacle[] obs;
Snake snake;

void setup() {
  size(1280, 800);
  
  obs = new Obstacle[(int) random(3, 12)];
  for (int i = 0; i < obs.length; i++) {
    obs[i] = new Obstacle(random(50, 1150), random(50, 750), random(10, 90));
  }
  
  snake = new Snake(400, obs);
  
  strokeWeight(12);
}

void draw() {
  background(255);
  
  snake.update();
  
  for (Obstacle o : obs) {
    o.show();
  }
}
