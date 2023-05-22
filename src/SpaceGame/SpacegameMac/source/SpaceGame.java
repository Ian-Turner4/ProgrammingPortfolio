/* autogenerated by Processing revision 1286 on 2023-05-22 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import processing.sound.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class SpaceGame extends PApplet {

// Ian Turner | 28 Nov 2022 | SpaceGame

SoundFile blaster;
SoundFile explosion;
SoundFile heal;
SoundFile fireball;
Ship s1;
Timer rockTimer;
Timer laserTimer;
Timer roseTimer;
Timer energyTimer;
Timer spitterTimer;
Timer fireballTimer;
ArrayList<Rock> rocks = new ArrayList<Rock>();
ArrayList<Laser> lasers = new ArrayList<Laser>();
ArrayList<Powerup> roses = new ArrayList<Powerup>();
ArrayList<Spitter> spitters = new ArrayList<Spitter>();
ArrayList<Fireball> fireballs = new ArrayList<Fireball>();
boolean play, isShooting;

Star[] stars = new Star[10];
int score, level, rockCount, health, laserCount;

 public void setup() {
  /* size commented out by preprocessor */;
  blaster = new SoundFile(this, "blaster.wav");
  explosion = new SoundFile(this, "explode.wav");
  heal = new SoundFile(this, "heal.wav");
  fireball = new SoundFile(this, "fireball.wav");
  s1 = new Ship();
  rockTimer = new Timer(1000);
  rockTimer.start();
  roseTimer = new Timer(15000);
  roseTimer.start();
  energyTimer = new Timer(5000);
  laserTimer = new Timer(10);
  spitterTimer = new Timer(5000);
  spitterTimer.start();
  fireballTimer = new Timer(500);
  fireballTimer.start();
  for (int i = 0; i < stars.length; i ++) {
    stars[i] = new Star();
  }
  score = 0;
  level = 1;
  health = 3;
  rockCount = 0;
  play = false;
}

 public void draw() {
  if (!play) {
    startScreen();
  } else {
    background(0, 127, 0);
    noCursor();
    // Rendering Stars
    for (int i = 0; i < stars.length; i ++) {
      stars[i].display();
      stars[i].move();
    }
    infoPanel();
    // Distributing Rocks
    if (rockTimer.isFinished()) {
      rocks.add(new Rock());
      rockCount += 1;
      rockTimer.start();
    }

    //Distributing Spitters
    if (spitterTimer.isFinished()) {
      spitters.add(new Spitter());
      spitterTimer.start();
    }

    // Distributing roses
    if (roseTimer.isFinished()) {
      roses.add(new Powerup());
      roseTimer.start();
    }

    // Rendering Roses
    for (int i = 0; i < roses.size(); i++) {
      Powerup r = roses.get(i);
      if (s1.roseIntersect(r)) {
        if (r.val == 'h') {
          s1.health += 1;
        } else {
          s1.energyDown = false;
          energyTimer.start();
        }
        heal.play();
        roses.remove(i);
      }
      if (r.reachedBottom()) {
        roses.remove(r);
      } else {
        r.display();
        r.move();
      }
    }

    // Rendering Rocks
    for (int i = 0; i < rocks.size(); i++) {
      Rock r = rocks.get(i);
      if (s1.intersect(r)) {
        s1.health -= 1;
        background(255, 0, 0);
        explosion.stop();
        explosion.play();
        if (s1.health <= 0) {
          gameOver();
        } else {
          rocks.remove(i);
        }
      }
      if (r.reachedBottom()) {
        rocks.remove(r);
      } else {
        r.display();
        r.move();
      }
    }

    // Rendering Spitters
    for (int i = 0; i < spitters.size(); i++) {
      Spitter s = spitters.get(i);
      if (s.reachedSide()) {
        spitters.remove(s);
      } else {
        s.display();
        s.move();
        if (fireballTimer.isFinished()) {
          fireballs.add(new Fireball(s.x, s.y));
          fireball.play();
          fireballTimer.start();
        }
      }
    }

    //Laser render
    for (int i = 0; i < lasers.size(); i++) {
      Laser l = lasers.get(i);
      for (int j = 0; j < rocks.size(); j++) {
        Rock r = rocks.get(j);
        if (l.intersect(r)) {
          score += 1;
          explosion.stop();
          explosion.play();
          s1.energy = 200;
          rocks.remove(r);
          lasers.remove(l);
        }
      }
      for (int k = 0; k < spitters.size(); k++) {
        Spitter s = spitters.get(k);
        if (l.sIntersect(s)) {
          score += 5;
          explosion.stop();
          explosion.play();
          s1.energy = 200;
          spitters.remove(k);
          lasers.remove(l);
        }
      }
      if (l.reachedTop()) {
        s1.health --;
        explosion.play();
        background(255, 0, 0);
        if (s1.health <= 0) {
          gameOver();
        }
        lasers.remove(l);
      } else {
        l.display();
        l.move();
      }
    }
    //Render spaceship
    s1.display();
    s1.move();

    if (energyTimer.isFinished()) {
      s1.energyDown = true;
    }

    //Render fireballs
    for (int i = 0; i < fireballs.size(); i++) {
      Fireball f = fireballs.get(i);
      if (f.sIntersect(s1)) {
        score += 1;
        explosion.stop();
        explosion.play();
        s1.energy = 200;
        s1.health --;
        if (s1.health <= 0) {
          gameOver();
        } else {
          fireballs.remove(f);
        }
      }
      if (f.reachedBottom()) {
        fireballs.remove(f);
      } else {
        f.display();
        f.move();
      }
    }
  }
}

 public void infoPanel() {
  fill(255, 0, 0, 127);
  rectMode(CENTER);
  rect(width/2, 25, width, 50);
  fill(255);
  textSize(30);
  text("Score: " + score, 100, 40);
  text("Health: " + s1.health, 300, 40);
  text("Energy: ", 500, 40);
  rect(650, 30, s1.energy/2, 20);
}

 public void startScreen() {
  background(0);
  fill(255);
  textAlign(CENTER);
  textSize(50);
  text("GREGORIAN DEFENSE", width/2, 200);
  textSize(20);
  text("Press W to Start", width/2, height/2);
  if (keyPressed && (key == 'w' || key == 'W')) {
    play = true;
  }
}

 public void gameOver() {
  for (int i = 0; i < lasers.size(); i+= 0.5f) {
    Laser l = lasers.get(i);
    lasers.remove(l);
  }
  for (int i = 0; i < rocks.size(); i+= 0.5f) {
    Rock r = rocks.get(i);
    rocks.remove(r);
  }
  for (int i = 0; i < spitters.size(); i+= 0.5f) {
    Spitter s = spitters.get(i);
    spitters.remove(s);
  }
  for (int i = 0; i < fireballs.size(); i+= 0.5f) {
    Fireball f = fireballs.get(i);
    fireballs.remove(f);
  }
  background(0);
  infoPanel();
  fill(255);
  textAlign(CENTER);
  textSize(50);
  text("Gregoria has fallen.", width/2, height/2);
  textSize(20);
  text("Press W to Restart", width/2, 600);
  play = false;
  noLoop();
}

 public void keyPressed() {
  if ((key == 'w' || key == 'W') && play == false) {
    play = true;
    loop();
    s1.health = 5;
    rockTimer.start();
    roseTimer.start();
    spitterTimer.start();
    fireballTimer.start();
    laserTimer = new Timer(100);
    energyTimer.start();
    s1.energy = 200;
    score = 0;
    s1.x = 400;
    s1.y = 700;
  }
  s1.setMove(keyCode, true);
  if (key == ' ') {
    if (laserTimer.isFinished()) {
      blaster.stop();
      blaster.play();
      if (s1.fire() && s1.turretCount == 1) {
        lasers.add(new Laser(s1.x, s1.y));
        laserCount += 1;
        laserTimer.start();
      } else if (s1.fire() && s1.turretCount == 2) {
        lasers.add(new Laser(s1.x-20, s1.y));
        lasers.add(new Laser(s1.x+20, s1.y));
        laserCount += 2;
        laserTimer.start();
      }
    }
  }
}


 public void keyReleased() {
  s1.setMove(keyCode, false);
}
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

   public void display() {
    noTint();
    fireball.resize(diam, diam);
    imageMode(CENTER);
    image(fireball, x, y);
  }

   public void move() {
    y += speed;
  }

   public boolean reachedBottom() {
    if (y > height + 50) {
      return true;
    } else {
      return false;
    }
  }
  
   public boolean sIntersect(Ship ship) {
    float d = dist(x, y, ship.x, ship.y);
    if (d < diam/2 + ship.w/2) {
      return(true);
    } else {
      return false;
    }
  }
}
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

   public void display() {
    noTint();
    laser.resize(diam, diam);
    imageMode(CENTER);
    image(laser, x, y);
  }

   public void move() {
    y -= speed;
  }

   public boolean reachedTop() {
    if (y < -50) {
      return true;
    } else {
      return false;
    }
  }

   public boolean intersect(Rock rock) {
    float d = dist(x, y, rock.x, rock.y);
    if (d < diam/2 + rock.diam/2) {
      return(true);
    } else {
      return false;
    }
  }
  
   public boolean sIntersect(Spitter spitter) {
    float d = dist(x, y, spitter.x, spitter.y);
    if (d < diam/2 + spitter.diam/2) {
      return(true);
    } else {
      return false;
    }
  }
}
class Powerup {
  int x, y, diam, speed;
  char val;
  PImage rose;

  Powerup() {
    x = PApplet.parseInt(random(width));
    diam = 75;
    y = -diam/2;
    speed = PApplet.parseInt(random(2, 10));
    if(PApplet.parseInt(random(2))==0) {
      val = 'h';
      rose = loadImage("rose.png");
    } else {
      val = 'a';
      rose = loadImage("yellowrose.png");
    }
  }

   public void display() {
    rose.resize(diam, diam);
    imageMode(CENTER);
    image(rose, x, y);
  }

   public void move() {
    y += speed;
  }

   public boolean reachedBottom() {
    if (y>height + 100) {
      return true;
    } else {
      return false;
    }
  }
}
class Rock {
  int x, y, diam, speed;
  int c1 = color(random(255), random(255), random(255));
  PImage skull;

  Rock() {
    x = PApplet.parseInt(random(width));
    diam = PApplet.parseInt(random(50, 100));
    y = -diam/2;
    speed = PApplet.parseInt(random(2, 10));
    skull = loadImage("skull.png");
  }

   public void display() {
    tint(c1);
    skull.resize(diam, diam);
    imageMode(CENTER);
    image(skull, x, y);
  }

   public void move() {
    y += speed;
  }

   public boolean reachedBottom() {
    if (y>height + 100) {
      return true;
    } else {
      return false;
    }
  }
}
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

   public void display() {
    noTint();
    ship.resize(90, 90);
    imageMode(CENTER);
    image(ship, x, y);
    noStroke();
  }

   public boolean fire() {
    if (ammo>0) {
      //ammo --;
      return true;
    } else {
      return false;
    }
  }

   public boolean intersect(Rock rock) {
    float d = dist(x, y, rock.x, rock.y);
    if (d < w/2 + rock.diam/2) {
      return(true);
    } else {
      return false;
    }
  }
   public boolean roseIntersect(Powerup rose) {
    float d = dist(x, y, rose.x, rose.y);
    if (d < w/2 + rose.diam/2) {
      return(true);
    } else {
      return false;
    }
  }



   public boolean setMove(int k1, boolean keyActive) {
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

   public void move() {
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
    x = constrain(x + speed*(PApplet.parseInt(isRight) - PApplet.parseInt(isLeft)), r, width  - r);
    y = constrain(y + speed*(PApplet.parseInt(isDown)  - PApplet.parseInt(isUp)), r, height - r);
  }
}
class Spitter {
  int x, y, diam, speed;
  int c1 = color(random(255), random(255), random(255));
  PImage spitter;

  Spitter() {
    x = -50;
    diam = 100;
    y = 200;
    speed = 6;
    spitter = loadImage("spitter.png");
  }

   public void display() {
    tint(c1);
    spitter.resize(diam, diam);
    imageMode(CENTER);
    image(spitter, x, y);
  }

   public void move() {
    x += speed;
  }

   public boolean reachedSide() {
    if (x>width + 100) {
      return true;
    } else {
      return false;
    }
  }
}
class Star {
  int x, y, diam, speed;
  PImage star;

  Star() {
    x = PApplet.parseInt(random(width));
    y = PApplet.parseInt(random(height));
    diam = PApplet.parseInt(random(20, 40));
    speed = PApplet.parseInt(random(2, 10));
    star = loadImage("monkey.png");
  }

   public void display() {
    noTint();
    star.resize(diam, diam);
    imageMode(CENTER);
    image(star, x, y);
  }

   public void move() {
    if (y > height + 50) {
      y = -5;
    } else {
      y += speed;
    }
  }

   public boolean reachedBottom() {
    return true;
  }
}
// Daniel Shiffman | from Rain Catcher Example 10-5: Object-oriented timer

class Timer {

  int savedTime; // When Timer started
  int totalTime; // How long Timer should last

  Timer(int tempTotalTime) {
    totalTime = tempTotalTime;
  }

  // Starting the timer
   public void start() {
    // When the timer starts it stores the current time in milliseconds.
    savedTime = millis();
  }

  // The function isFinished() returns true if 5,000 ms have passed.
  // The work of the timer is farmed out to this method.
   public boolean isFinished() {
    // Check how much time has passed
    int passedTime = millis()- savedTime;
    if (passedTime > totalTime) {
      return true;
    } else {
      return false;
    }
  }
}


  public void settings() { size(800, 800); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "SpaceGame" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}