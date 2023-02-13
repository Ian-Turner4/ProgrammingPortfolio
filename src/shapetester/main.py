# Ian Turner | Feb 3 2023 | Shape Maker

from Box import Box
from Sphere import Sphere
from Pyramid import Pyramid

play = True

b1 = Box()
s1 = Sphere()
p1 = Pyramid()

while play:
  b1.l = float(input('enter value for box length: '))
  print(b1.l)
  b1.w = float(input('enter value for box width: '))
  print(b1.w)
  b1.h = float(input('enter value for box height: '))
  print(b1.h)
  print('Box volume: ', b1.calcVol())
  print('Box surface area: ', b1.calcSA())
  
  s1.r = float(input('enter value for sphere radius: '))
  print(s1.r)
  print('Sphere volume: ', s1.calcVol())
  print('Sphere surface area: ', s1.calcSA())
  
  p1.l = float(input('enter value for pyramid length: '))
  print(p1.l)
  p1.w = float(input('enter value for pyramid width: '))
  print(p1.w)
  p1.h = float(input('enter value for pyramid height: '))
  print(p1.h)
  print('Pyramid volume: ', p1.calcVol())
  print('Pyramid surface area: ', p1.calcSA())
  if input('Play again? y/n: ') == 'n':
    print("Thanks for playing.")
    play = False
  else:
    print("I'll take that as a yes. Playing again.")