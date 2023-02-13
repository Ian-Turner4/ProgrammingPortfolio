class Box:
  l = 0.0
  w = 0.0
  h = 0.0
  
  def __init__(self):
    self.l = 0.0
    self.w = 0.0
    self.h = 0.0

  def calcVol(self):
    vol = self.l*self.w*self.h
    return vol

  def calcSA(self):
    sa = 2*(self.w*self.l+self.h*self.l+self.h*self.w)
    return sa