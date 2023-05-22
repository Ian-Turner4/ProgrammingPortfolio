import math

class Pyramid:
  l = 0.0
  w = 0.0
  h = 0.0
  
  def __init__(self):
    self.l = 0.0
    self.w = 0.0
    self.h = 0.0

  def calcVol(self):
    vol = (self.l*self.w*self.h)/3
    return vol

  def calcSA(self):
    sa = self.l*self.w+self.l*math.sqrt(math.pow((self.w/2), 2)+math.pow(self.h, 2))+self.w*math.sqrt(math.pow((self.l/2), 2)+math.pow(self.h, 2))
    return sa
    