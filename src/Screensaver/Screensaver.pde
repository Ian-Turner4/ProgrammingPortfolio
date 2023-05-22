// Ian Turner | 10 Oct 2022 | Screensaver App
float xpos, ypos, strokeW, pointCount;
int i = 0;
int j = 0;

void setup() {
  size(displayWidth, displayHeight);
  xpos = 0;
  ypos = 0;
  background(255);
  frameRate(60);
}

void draw() {
  noCursor();
  xpos = i;
  ypos = j;
  if (i<width) {
    i++;
  } else {
    j += 20;
    i = 0;
  }
  if(j > height) {
    j = 0;
  }
  strokeW = random(1, 30);
  pointCount = random(1, 50);
  stroke(0, random(255), random(255));
  strokeWeight(strokeW);
  if (xpos > width || xpos < 0 || ypos > height || ypos < 0) {
    xpos = random(width);
    ypos = random(height);
  }
  int rand = int(random(8));
  if (rand == 0) {
    strokeWeight(strokeW);
    moveLeft(xpos, ypos, pointCount);
  } else if (rand == 1) {
    strokeWeight(strokeW);
    moveUp(xpos, ypos, pointCount);
  } else if (rand == 2) {
    strokeWeight(strokeW);
    moveDown(xpos, ypos, pointCount);
  } else if (rand == 3) {
    strokeWeight(strokeW);
    moveRight(xpos, ypos, pointCount);
  } else if (rand == 4) {
    strokeWeight(strokeW);
    moveUpRight(xpos, ypos, pointCount);
  } else if (rand == 5) {
    strokeWeight(strokeW);
    moveUpLeft(xpos, ypos, pointCount);
  } else if (rand == 6) {
    strokeWeight(strokeW);
    moveDownRight(xpos, ypos, pointCount);
  } else {
    strokeWeight(strokeW);
    moveDownLeft(xpos, ypos, pointCount);
  }
}

void moveRight(float startX, float startY, float moveCount) {
  for (float i=0; i<moveCount; i++) {
    point(startX+i, startY);
    xpos = startX+i;
    ypos=startY;
  }
}

void moveLeft(float startX, float startY, float moveCount) {
  for (float i=0; i<moveCount; i++) {
    point(startX-i, startY);
    xpos = startX-i;
    ypos=startY;
  }
}

void moveUp(float startX, float startY, float moveCount) {
  for (float i=0; i<moveCount; i++) {
    point(startX, startY-i);
    xpos = startX;
    ypos=startY-i;
  }
}

void moveDown(float startX, float startY, float moveCount) {
  for (float i=0; i<moveCount; i++) {
    point(startX, startY+i);
    xpos = startX;
    ypos=startY+i;
  }
}

void moveDownRight(float startX, float startY, float moveCount) {
  for (float i=0; i<moveCount; i++) {
    point(startX+i, startY+i);
    xpos = startX+i;
    ypos=startY+i;
  }
}

void moveDownLeft(float startX, float startY, float moveCount) {
  for (float i=0; i<moveCount; i++) {
    point(startX-i, startY+i);
    xpos = startX-i;
    ypos=startY+i;
  }
}

void moveUpRight(float startX, float startY, float moveCount) {
  for (float i=0; i<moveCount; i++) {
    point(startX+i, startY-i);
    xpos = startX+i;
    ypos=startY-i;
  }
}

void moveUpLeft(float startX, float startY, float moveCount) {
  for (float i=0; i<moveCount; i++) {
    point(startX-i, startY-i);
    xpos = startX-i;
    ypos=startY-i;
  }
}
