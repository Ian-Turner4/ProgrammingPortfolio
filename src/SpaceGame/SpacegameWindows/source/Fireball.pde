class Fireball {
  int x, y, diam, speed;
  PImage fireball;

  Fireball(int x, int y) {
    this.x = x;
    this.y = y;
    diam = 50;
    speed = 10;
    fireball = loadImage("fireball.png");
  }

  void display() {
    noTint();
    fireball.resize(diam, diam);
    imageMode(CENTER);
    image(fireball, x, y);
  }

  void move() {
    y += speed;
  }

  boolean reachedBottom() {
    if (y > height + 50) {
      return true;
    } else {
      return false;
    }
  }
  
  boolean sIntersect(Ship ship) {
    float d = dist(x, y, ship.x, ship.y);
    if (d < diam/2 + ship.w/2) {
      return(true);
    } else {
      return false;
    }
  }
}
