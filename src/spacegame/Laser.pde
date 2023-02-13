class Laser {
  int x, y, diam, speed;
  PImage laser;

  Laser(int x, int y) {
    this.x = x;
    this.y = y;
    diam = 50;
    speed = 10;
    laser = loadImage("ship.png");
  }

  void display() {
    noTint();
    laser.resize(diam, diam);
    imageMode(CENTER);
    image(laser, x, y);
  }

  void move() {
    y -= speed;
  }

  boolean reachedTop() {
    if (y < -50) {
      return true;
    } else {
      return false;
    }
  }

  boolean intersect(Rock rock) {
    float d = dist(x, y, rock.x, rock.y);
    if (d < diam/2 + rock.diam/2) {
      return(true);
    } else {
      return false;
    }
  }
  
  boolean sIntersect(Spitter spitter) {
    float d = dist(x, y, spitter.x, spitter.y);
    if (d < diam/2 + spitter.diam/2) {
      return(true);
    } else {
      return false;
    }
  }
}
