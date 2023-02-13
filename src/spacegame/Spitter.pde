class Spitter {
  int x, y, diam, speed;
  color c1 = color(random(255), random(255), random(255));
  PImage spitter;

  Spitter() {
    x = -50;
    diam = 100;
    y = 200;
    speed = 6;
    spitter = loadImage("spitter.png");
  }

  void display() {
    tint(c1);
    spitter.resize(diam, diam);
    imageMode(CENTER);
    image(spitter, x, y);
  }

  void move() {
    x += speed;
  }

  boolean reachedSide() {
    if (x>width + 100) {
      return true;
    } else {
      return false;
    }
  }
}
