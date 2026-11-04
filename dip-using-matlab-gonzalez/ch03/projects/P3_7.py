import numpy as np
import matplotlib.pyplot as plt

def generate_zone_plate(K, delta, size=2001):
    # Creating a grid of x and y values
    x = np.linspace(-K, K, size)
    y = np.linspace(-K, K, size)
    X, Y = np.meshgrid(x, y)
    # Calculating the squared distance from the center (r^2)
    R_squared = X**2 + Y**2
    # Generating the zone plate pattern
    g = 0.5 * (1 + np.cos(2 * np.pi * delta**2 * R_squared)) 
    # Applying a circular mask
    radius = K
    circular_mask = R_squared <= radius**2
    g = g * circular_mask + (1 - circular_mask) * 0  # Outside the circle is black
    return g

# Parameters for the zone plate:
K = 8.2  # Determines the range of the x and y coordinates and the radius of the circular mask
delta = 0.398  # Determines the frequency of the fringes
# Generating the zone plate
zone_plate = generate_zone_plate(K, delta)

# Displaying the zone plate
plt.figure(figsize=(6, 6))
plt.imshow(zone_plate, cmap='gray')
plt.axis('off')
plt.show()
