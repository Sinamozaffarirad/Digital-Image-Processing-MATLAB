import numpy as np
from PIL import Image, ImageOps
import matplotlib.pyplot as plt

# Adjusting array values to fit within the [0, 1] interval
def normalize(array):
    return (array - np.min(array)) / (np.max(array) - np.min(array))

# Enhancing the image using logarithmic scaling
def log_transform(image_array):
    epsilon = 1e-10  # Tiny value to avoid division by zero
    c = 255 / (np.log(1 + np.max(image_array) + epsilon))
    log_image = c * np.log(1 + image_array + epsilon)
    return np.array(log_image, dtype=np.uint8)

# Modifying the image using gamma correction
def gamma_transform(image_array, gamma):
    gamma_corrected = np.array(255 * (image_array / 255) ** gamma, dtype='uint8')
    return gamma_corrected

# Altering the image intensities by stretching them
def stretch_transform(image_array):
    # Scaling pixel intensities between 0 and 1
    normalized_image_array = normalize(image_array)
    # Extending the intensity range
    stretched_image = np.array(255 * normalized_image_array, dtype=np.uint8)
    return stretched_image

# Enhancing contrast using a sigmoid function
def sigmoid_contrast(image_array, alpha=10, beta=0.5):
    # Increasing contrast through sigmoid function application
    normalized_image = normalize(image_array)
    sigmoid_array = 1 / (1 + np.exp(alpha * (beta - normalized_image)))
    return np.array(255 * sigmoid_array, dtype=np.uint8)

# Loading the image
image_path = 'input.tif'
original_image = Image.open(image_path).convert('L')
original_array = np.array(original_image)
# Applying various transformations
log_image = log_transform(original_array)
# Setting the gamma value
gamma_image = gamma_transform(original_array, 0.4)  
stretch_image = stretch_transform(original_array)
sigmoid_image = sigmoid_contrast(original_array)

# Visualizing the transformations
fig, axs = plt.subplots(1, 5, figsize=(20, 5))

axs[0].imshow(original_array, cmap='gray')
axs[0].set_title('Original Image')
axs[0].axis('off')

axs[1].imshow(log_image, cmap='gray')
axs[1].set_title('Log Transformation')
axs[1].axis('off')

axs[2].imshow(gamma_image, cmap='gray')
axs[2].set_title('Gamma Transformation')
axs[2].axis('off')

axs[3].imshow(stretch_image, cmap='gray')
axs[3].set_title('Stretch Transformation')
axs[3].axis('off')

axs[4].imshow(sigmoid_image, cmap='gray')
axs[4].set_title('Sigmoid Contrast Enhancement')
axs[4].axis('off')

plt.tight_layout()
plt.show()
