class Star {
  int x, y, diam, speed;
  PImage star;

  Star() {
    x = int(random(width));
    y = int(random(height));
    diam = int(random(20, 40));
    speed = int(random(2, 10));
    star = loadImage("monkey.png");
  }

  void display() {
    noTint();
    star.resize(diam, diam);
    imageMode(CENTER);
    image(star, x, y);
  }

  void move() {
    if (y > height + 50) {
      y = -5;
    } else {
      y += speed;
    }
  }

  boolean reachedBottom() {
    return true;
  }
}
