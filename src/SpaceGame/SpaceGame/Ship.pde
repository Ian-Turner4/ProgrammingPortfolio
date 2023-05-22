 class Ship {
  int x, y, w, ammo, turretCount, speed, health, energy;
  PImage ship;
  boolean isRight, isLeft, isUp, isDown, energyDown;

  // Constructor
  Ship() {
    x = 400;
    y = 700;
    w = 90;
    ship = loadImage("star.png");
    ammo = 1000;
    turretCount = 1;
    speed = 5;
    health = 5;
    energy = 200;
  }

  void display() {
    noTint();
    ship.resize(90, 90);
    imageMode(CENTER);
    image(ship, x, y);
    noStroke();
  }

  boolean fire() {
    if (ammo>0) {
      //ammo --;
      return true;
    } else {
      return false;
    }
  }

  boolean intersect(Rock rock) {
    float d = dist(x, y, rock.x, rock.y);
    if (d < w/2 + rock.diam/2) {
      return(true);
    } else {
      return false;
    }
  }
  boolean roseIntersect(Powerup rose) {
    float d = dist(x, y, rose.x, rose.y);
    if (d < w/2 + rose.diam/2) {
      return(true);
    } else {
      return false;
    }
  }



  boolean setMove(int k1, boolean keyActive) {
    switch (k1) {
    case +'W':
    case UP:
      return isUp = keyActive;

    case +'S':
    case DOWN:
      return isDown = keyActive;

    case +'A':
    case LEFT:
      return isLeft = keyActive;

    case +'D':
    case RIGHT:
      return isRight = keyActive;

    default:
      return keyActive;
    }
  }

  void move() {
    if (energyDown) {
      energy --;
    }
    if (energy < 0) {
      health --;
      background(255, 0, 0);
      if (health <= 0) {
        gameOver();
      }
      energy = 200;
    }
    int r = 90 >> 1;
    x = constrain(x + speed*(int(isRight) - int(isLeft)), r, width  - r);
    y = constrain(y + speed*(int(isDown)  - int(isUp)), r, height - r);
  }
}
