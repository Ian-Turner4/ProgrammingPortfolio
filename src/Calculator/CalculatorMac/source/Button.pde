class Button {
  //Member Variables
  int x, y, w, h;
  char val;
  color c1, c2;
  boolean on;

  // Constructor
  Button(int x, int y, int w, int h, char val, color col) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c2 = col;
    this.val = val;
    c1 = color(0);
    on = false;
  }

  void display() {
    if (on) {
      fill(c2);
    } else {
      fill(c1);
    }
    stroke(c2);
    rect(x, y, w, h);
    fill(255);
    textAlign(CENTER);
    textSize(50);
    if (val == 'S') {
      text("x²", x + w/2, y + (h/2) + 16.6666666667);
    } else {
      text(val, x + w/2, y + (h/2) + 16.6666666667);
    }
  }

  void hover(int mx, int my) {
    on = (mx > x && mx < x+w && my > y && my < y+h);
  }
}
