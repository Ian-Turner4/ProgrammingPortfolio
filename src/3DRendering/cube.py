import pygame
from pygame.locals import *
import math

class Cube:

    vertices = []
    edges = []

    def __init__(self, size, location, angle):
        self.size = size
        self.location = location
        self.angle = angle

    def posUpdate(self):
        self.vertices = [
            (self.location[0]+self.size, self.location[1]+self.size, self.location[2]+self.size),
            (self.location[0]+self.size, self.location[1]-self.size, self.location[2]+self.size),
            (self.location[0]-self.size, self.location[1]-self.size, self.location[2]+self.size),
            (self.location[0]-self.size, self.location[1]+self.size, self.location[2]+self.size),
            (self.location[0]+self.size, self.location[1]+self.size, self.location[2]-self.size),
            (self.location[0]+self.size, self.location[1]-self.size, self.location[2]-self.size),
            (self.location[0]-self.size, self.location[1]-self.size, self.location[2]-self.size),
            (self.location[0]-self.size, self.location[1]+self.size, self.location[2]-self.size)
        ]

        # Define connections between the vertices to form edges of the cube
        self.edges = [
            (0, 1),
            (1, 2),
            (2, 3),
            (3, 0),
            (4, 5),
            (5, 6),
            (6, 7),
            (7, 4),
            (0, 4),
            (1, 5),
            (2, 6),
            (3, 7)
        ]
        
        center = (0, 0, -(200+ (self.size)))
        self.vertices = [self.rotate_point(v, center, self.angle) for v in self.vertices]

    def project2D(self, width, height, screen, color):
        # Project 3D points to 2D screen space
        projected_points = []
        for vertex in self.vertices:
            x, y, z = vertex
            # Perspective projection
            f = 550  # focal length
            projected_x = x*self.size
            projected_y = y*self.size
            if (z+f) > 0:
                projected_x = x * f / (z + f) + width / 2
                projected_y = y * f / (z + f) + height / 2
            projected_points.append((projected_x, projected_y))

        # Draw edges between the projected points
        for edge in self.edges:
            start, end = edge
            pygame.draw.line(screen, color, projected_points[start], projected_points[end], 1)

    def rotate_point(self, point, center, angle):
        x, y, z = point
        cx, cy, cz = center

        # Translate the point to the origin
        x -= cx
        y -= cy
        z -= cz

        # Perform a 2D rotation around the origin (x and z axes in this case)
        new_x = x * math.cos(angle) - z * math.sin(angle)
        new_z = x * math.sin(angle) + z * math.cos(angle)

        # Translate the point back to its original position
        new_x += cx
        new_z += cz

        return new_x, y, new_z