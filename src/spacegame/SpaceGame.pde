// Ian Turner | 28 Nov 2022 | SpaceGame
import processing.sound.*;
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

void setup() {
  size(800, 800);
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

void draw() {
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

void infoPanel() {
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

void startScreen() {
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

void gameOver() {
  for (int i = 0; i < lasers.size(); i+= 0.5) {
    Laser l = lasers.get(i);
    lasers.remove(l);
  }
  for (int i = 0; i < rocks.size(); i+= 0.5) {
    Rock r = rocks.get(i);
    rocks.remove(r);
  }
  for (int i = 0; i < spitters.size(); i+= 0.5) {
    Spitter s = spitters.get(i);
    spitters.remove(s);
  }
  for (int i = 0; i < fireballs.size(); i+= 0.5) {
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

void keyPressed() {
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


void keyReleased() {
  s1.setMove(keyCode, false);
}
