class Rock {
  int x, y, diam, speed;
  color c1 = color(random(255), random(255), random(255));
  PImage skull;

  Rock() {
    x = int(random(width));
    diam = int(random(50, 100));
    y = -diam/2;
    speed = int(random(2, 10));
    skull = loadImage("skull.png");
  }

  void display() {
    tint(c1);
    skull.resize(diam, diam);
    imageMode(CENTER);
    image(skull, x, y);
  }

  void move() {
    y += speed;
  }

  boolean reachedBottom() {
    if (y>height + 100) {
      return true;
    } else {
      return false;
    }
  }
}
