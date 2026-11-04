import numpy as np
from PIL import Image
import matplotlib.pyplot as plt

def histeq(image_array, number_bins=256):
    # Calculating the histogram and its cumulative distribution function (CDF)
    image_histogram, bins = np.histogram(image_array.flatten(), number_bins, density=True)
    cdf = image_histogram.cumsum()  # Accumulating the histogram values
    cdf_normalized = (255 * cdf / cdf[-1]).astype(np.uint8)  # Normalizing the CDF
    
    # Mapping original grayscale values to equalized values
    image_equalized = np.interp(image_array.flatten(), bins[:-1], cdf_normalized)
    return image_equalized.reshape(image_array.shape), cdf_normalized

image_path = 'input.tif'
original_image = Image.open(image_path).convert('L')  
original_array = np.array(original_image)
# Applying histogram equalization
equalized_image, transformation = histeq(original_array)

# Displaying the original and equalized images and their histograms
plt.figure(figsize=(12, 6))

# Displaying the original image
plt.subplot(2, 2, 1)
plt.imshow(original_array, cmap='gray')
plt.title('Original Image')

# Histogram of the original image
plt.subplot(2, 2, 2)
plt.hist(original_array.flatten(), bins=256)
plt.title('Original Histogram')

# Displaying the equalized image
plt.subplot(2, 2, 3)
plt.imshow(equalized_image, cmap='gray')
plt.title('Equalized Image')

# Histogram of the equalized image
plt.subplot(2, 2, 4)
plt.hist(equalized_image.flatten(), bins=256)
plt.title('Equalized Histogram')

plt.tight_layout()
plt.show()

# Plotting the transformation function used for equalization
plt.figure()
plt.plot(transformation)
plt.title('Transformation Function')
plt.xlabel('Input Intensity')
plt.ylabel('Output Intensity')
plt.show()
