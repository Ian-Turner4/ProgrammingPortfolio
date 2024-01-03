import pygame
from pygame.locals import *
import math
from cube import Cube
from shape import Shape

c = Cube(100, [0, 0, 0], 0)
player = Shape(50, [0, 200, 0], 0)
worldAngle = 0
worldPos = 0
worldAngleRad = 0
speed = 5
turnSpeed = 0.03

# Define some colors
BLACK = (0, 0, 0)
WHITE = (255, 255, 255)
RED = (255, 0, 0)

# Initialize Pygame
pygame.init()

# Set up the display
width, height = 800, 800
screen = pygame.display.set_mode((width, height))
pygame.display.set_caption("3D Game")

clock = pygame.time.Clock()

# Main game loop
running = True
while running:
    for event in pygame.event.get():
        if event.type == QUIT:
            running = False
    
    worldAngleRad = math.radians(worldAngle)

    moveVectorY = speed*(math.sin(worldAngleRad))
    moveVectorX = speed*(math.cos(worldAngleRad))

    pressed = pygame.key.get_pressed()
    if (pressed[K_d]) :
      c.location[2] += moveVectorY
      c.location[0] -= moveVectorX
    if (pressed[K_a]) :
      c.location[2] -= moveVectorY
      c.location[0] += moveVectorX
    if (pressed[K_w]) :
      c.location[0] -= moveVectorY
      c.location[2] -= moveVectorX
    if (pressed[K_s]) :
      c.location[0] += moveVectorY
      c.location[2] += moveVectorX
    if (pressed[K_LEFT]) :
      worldAngle -= math.degrees(turnSpeed)
    if (pressed[K_RIGHT]) :
      worldAngle += math.degrees(turnSpeed)
    
    if(worldAngle > 360):
       worldAngle = 0
    elif(worldAngle < 0):
       worldAngle = 360

    c.angle = math.radians(worldAngle)

    # Clear the screen
    screen.fill(BLACK)
    c.posUpdate()
    c.project2D(width, height, screen, RED)
    player.posUpdate()
    player.project2D(width, height, screen, WHITE)
    # Update the display
    pygame.display.flip()
    clock.tick(60)

# Quit Pygame
pygame.quit()