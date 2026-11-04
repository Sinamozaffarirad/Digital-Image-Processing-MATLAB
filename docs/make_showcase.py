"""Build the README showcase figure from selected exercise outputs."""
from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.image import imread

ROOT = Path(__file__).resolve().parent.parent
F = ROOT / "fundamentals-solomon-breckon"
G = ROOT / "dip-using-matlab-gonzalez" / "ch03" / "projects" / "outputs"
PANELS = [
    (F / "ch03/exercises/outputs/3.5.4.jpg", "Ch 3 · Global vs adaptive thresholding"),
    (F / "ch04/exercises/outputs/4.9.jpg", "Ch 4 · Noise & spatial filtering"),
    (F / "ch04/exercises/outputs/4.10.1.jpg", "Ch 4 · Per-channel edge detection"),
    (F / "ch08/exercises/outputs/8.3.1.jpg", "Ch 8 · Morphological operations"),
    (G / "3_1.png", "Gonzalez Ch 3 · Intensity transformations"),
    (G / "3_2_1.png", "Gonzalez Ch 3 · Histogram processing"),
]

plt.rcParams.update({"figure.facecolor": "#0d1117", "savefig.facecolor": "#0d1117"})
fig, axes = plt.subplots(3, 2, figsize=(14, 13))
for ax, (path, title) in zip(axes.flat, PANELS):
    ax.imshow(imread(path), cmap="gray")
    ax.set_title(title, fontsize=13, color="#e6edf3", pad=8)
    ax.axis("off")
fig.tight_layout()
fig.savefig(ROOT / "docs" / "showcase.png", dpi=100)
