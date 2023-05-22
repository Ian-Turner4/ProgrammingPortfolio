// Ian Turner | Nov 2022 | Calc Project
Button[] numButtons = new Button[10];
Button[] opButtons = new Button[12];
String dVal = "0.0";
boolean left = true;
float l, r, result;
char op = ' ';
color numColor = color(255, 0, 0);
color opC1 = color(0, 255, 0);
color opC2 = color(128, 0, 255);

void setup() {
  size(700, 600);
  opButtons[0] = new Button(500, 400, 200, 200, '=', opC2);
  opButtons[1] = new Button(400, 400, 100, 200, 'C', opC2);
  opButtons[2] = new Button(100, 0, 100, 100, '.', opC2);
  opButtons[3] = new Button(200, 0, 100, 100, '±', opC2);
  opButtons[4] = new Button(200, 100, 100, 100, '+', opC1);
  opButtons[5] = new Button(200, 200, 100, 100, '-', opC1);
  opButtons[6] = new Button(200, 300, 100, 100, '*', opC1);
  opButtons[7] = new Button(200, 400, 100, 100, '÷', opC1);
  opButtons[9] = new Button(200, 500, 100, 100, '√', opC2);
  opButtons[8] = new Button(0, 0, 100, 100, 'S', opC2);
  opButtons[10] = new Button(300, 500, 100, 100, 'π', opC2);
  opButtons[11] = new Button(300, 400, 100, 100, 'e', opC2);
  numButtons[0] = new Button(0, 500, 100, 100, '0', numColor);
  numButtons[1] = new Button(0, 400, 100, 100, '1', numColor);
  numButtons[2] = new Button(0, 300, 100, 100, '2', numColor);
  numButtons[3] = new Button(0, 200, 100, 100, '3', numColor);
  numButtons[4] = new Button(0, 100, 100, 100, '4', numColor);
  numButtons[5] = new Button(100, 500, 100, 100, '5', numColor);
  numButtons[6] = new Button(100, 400, 100, 100, '6', numColor);
  numButtons[7] = new Button(100, 300, 100, 100, '7', numColor);
  numButtons[8] = new Button(100, 200, 100, 100, '8', numColor);
  numButtons[9] = new Button(100, 100, 100, 100, '9', numColor);
}

void draw() {
  background(0);
  for (int i = 0; i < numButtons.length; i++) {
    numButtons[i].display();
    numButtons[i].hover(mouseX, mouseY);
    numButtons[i].c2 += 0.1;
  }
  for (int i = 0; i < opButtons.length; i++) {
    opButtons[i].display();
    opButtons[i].hover(mouseX, mouseY);
    opButtons[i].c2 -= 1;
  }
  updateDisplay();
  fill(0);
  stroke(opButtons[10].c2);
  rect(300, 0, 400, 100);
  fill(255);
  textAlign(CENTER);
  textSize(50);
  text("Calculator", 500, 50);
  textSize(25);
  text("Ian Turner", 500, 85);
}

void keyPressed() {
  if (keyCode == 49 || keyCode == 97) {
    handleEvent("1", true);
  } else if (keyCode == 50 || keyCode == 98) {
    handleEvent("2", true);
  } else if (keyCode == 99 || keyCode == 51) {
    handleEvent("3", true);
  } else if (keyCode == 100 || keyCode == 52) {
    handleEvent("4", true);
  } else if (keyCode == 101 || keyCode == 53) {
    handleEvent("5", true);
  } else if (keyCode == 102 || keyCode == 54) {
    handleEvent("6", true);
  } else if (keyCode == 103 || keyCode == 55) {
    handleEvent("7", true);
  } else if (keyCode == 104 || keyCode == 56) {
    handleEvent("8", true);
  } else if (keyCode == 105 || keyCode == 57) {
    handleEvent("9", true);
  } else if (keyCode == 96 || keyCode == 48) {
    handleEvent("0", true);
  } else if (keyCode == 8 || keyCode == 12) {
    handleEvent("C", false);
  } else if (keyCode == 46 || keyCode == 110) {
    handleEvent(".", false);
  } else if (keyCode == 107 || keyCode == 61) {
    handleEvent("+", false);
  } else if (keyCode == 45 || keyCode == 109) {
    handleEvent("-", false);
  } else if (keyCode == 56 || keyCode == 106) {
    handleEvent("*", false);
  } else if (keyCode == 47 || keyCode == 111) {
    handleEvent("/", false);
  } else if (keyCode == 10) {
    handleEvent("=", false);
  }
}

void handleEvent(String val, boolean num) {
  if (num && dVal.length() < 20) {
    if (dVal.equals("0.0")) {
      dVal = val;
    } else {
      dVal += val;
    }
    if (left) {
      l = float(dVal);
    } else {
      r = float(dVal);
    }
  } else if (val.equals("C")) {
    dVal = "0.0";
    left = true;
    op = ' ';
    l = 0.0;
    r = 0.0;
    result = 0.0;
  } else if (val.equals(".")) {
    if (!dVal .contains(".")) {
      dVal += ".";
    }
  } else if (val.equals("+")) {
    op = '+';
    dVal = "0.0";
    left = false;
  } else if (val.equals("-")) {
    op = '-';
    dVal = "0.0";
    left = false;
  } else if (val.equals("*")) {
    op = '*';
    dVal = "0.0";
    left = false;
  } else if (val.equals("/")) {
    op = '÷';
    dVal = "0.0";
    left = false;
  } else if (val.equals("=")) {
    performCalculation();
  } else if (val.equals("π")) {
    performCalculation();
  }
}

void mouseReleased() {
  for (int i = 0; i < numButtons.length; i++) {
    if (numButtons[i].on) {
      handleEvent(str(numButtons[i].val), true);
    }
  }

  for (int i = 0; i < opButtons.length; i++) {
    if (opButtons[i].on && opButtons[i].val == 'C') {
      handleEvent(str(opButtons[i].val), false);
    } else if (opButtons[i].on && opButtons[i].val == '+') {
      handleEvent("+", false);
    } else if (opButtons[i].on && opButtons[i].val == '-') {
      handleEvent("-", false);
    } else if (opButtons[i].on && opButtons[i].val == '*') {
      handleEvent("*", false);
    } else if (opButtons[i].on && opButtons[i].val == '÷') {
      handleEvent("/", false);
    } else if (opButtons[i].on && opButtons[i].val == '.') {
      handleEvent(".", false);
    } else if (opButtons[i].on && opButtons[i].val == 'S') {
      if (left) {
        l = sq(l);
        dVal = str(l);
      } else {
        r = sq(r);
        dVal = str(r);
      }
    } else if (opButtons[i].on && opButtons[i].val == '±') {
      if (left) {
        l *= -1;
        dVal = str(l);
      } else {
        r *= -1;
        dVal = str(r);
      }
    } else if (opButtons[i].on && opButtons[i].val == '√') {
      if (left) {
        l = sqrt(l);
        dVal = str(l);
      } else {
        r = sqrt(r);
        dVal = str(r);
      }
    } else if (opButtons[i].on && opButtons[i].val == 'π') {
      if (left) {
        if (l == 0.0) {
          l = PI;
        } else {
          l *= PI;
        }
        dVal = str(l);
      } else {
        if (r == 0.0) {
          r = PI;
        } else {
          r *= PI;
        }
        dVal = str(r);
      }
    } else if (opButtons[i].on && opButtons[i].val == 'e') {
      if (left) {
        if (l == 0.0) {
          l = 2.7182818;
        } else {
          l *= 2.7182818;
        }
        dVal = str(l);
      } else {
        if (r == 0.0) {
          r = 2.7182818;
        } else {
          r *= 2.7182818;
        }
        dVal = str(r);
      }
    } else if (opButtons[i].on && opButtons[i].val == '=') {
      handleEvent("=", false);
    }
  }
}

void updateDisplay() {
  fill(0);
  stroke(opButtons[10].c2);
  rect(300, 100, 400, 300);
  fill(255);
  textAlign(RIGHT);
  if (dVal.length() < 14) {
    textSize(50);
  } else if (dVal.length() < 15) {
    textSize(48);
  } else if (dVal.length() < 16) {
    textSize(46);
  } else if (dVal.length() < 17) {
    textSize(44);
  } else if (dVal.length() < 18) {
    textSize(42);
  } else if (dVal.length() < 19) {
    textSize(40);
  } else if (dVal.length() < 20) {
    textSize(38);
  } else {
    textSize(36);
  }
  text(dVal, width-25, 375);
}

void performCalculation() {
  if (op == '+') {
    result = l + r;
  } else if (op == '-') {
    result = l - r;
  } else if (op == '*') {
    result = l * r;
  } else if (op == '÷') {
    result = l /(r);
  } else {
    result = l;
  }
  dVal = str(result);
  l = result;
  left = true;
}
