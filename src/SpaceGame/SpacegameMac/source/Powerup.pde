class Powerup {
  int x, y, diam, speed;
  char val;
  PImage rose;

  Powerup() {
    x = int(random(width));
    diam = 75;
    y = -diam/2;
    speed = int(random(2, 10));
    if(int(random(2))==0) {
      val = 'h';
      rose = loadImage("rose.png");
    } else {
      val = 'a';
      rose = loadImage("yellowrose.png");
    }
  }

  void display() {
    rose.resize(diam, diam);
    imageMode(CENTER);
    image(rose, x, y);
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
