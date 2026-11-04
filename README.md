# Digital Image Processing in MATLAB

My exercises from the Fundamentals of Computer Vision course at the University of Kashan.
Sina Mozaffari Rad, student ID 40021160214.

During the course I worked through two textbooks chapter by chapter: I reproduced the worked examples and solved
the end-of-chapter exercises in MATLAB (and some in Python). Each script saves its result figures, so you can
see the output without running anything.

<p align="center"><img src="docs/showcase.png" width="100%" alt="Selected results"></p>

## Solomon & Breckon, *Fundamentals of Digital Image Processing* → [`fundamentals-solomon-breckon/`](fundamentals-solomon-breckon)

| Chapter | Topic | What I implemented |
|---------|-------|--------------------|
| [**3**](fundamentals-solomon-breckon/ch03) | Pixels and point operations | Image arithmetic (add, subtract, multiply, divide, absolute difference), inversion, log and exponential transforms, histograms, global and adaptive (CLAHE) equalisation, global vs adaptive thresholding. 8 exercises plus the examples. |
| [**4**](fundamentals-solomon-breckon/ch04) | Enhancement and spatial filtering | Salt-and-pepper and Gaussian noise; mean, median and conservative filters with a timing comparison; Gaussian smoothing; motion blur and border handling; Laplacian sharpening; Roberts and Sobel edges on each RGB channel. 11 exercises plus the examples. |
| [**5**](fundamentals-solomon-breckon/ch05) | Fourier transform | 2-D FFT, showing the spectrum, filtering in the frequency domain. |
| [**6**](fundamentals-solomon-breckon/ch06) | Image restoration | Modelling a PSF, inverse filtering, Wiener (`deconvwnr`), regularised (`deconvreg`) and Lucy–Richardson (`deconvlucy`) deconvolution. |
| [**7**](fundamentals-solomon-breckon/ch07) | Geometry | Procrustes shape alignment, image registration from control points (`cp2tform` / `imtransform`). |
| [**8**](fundamentals-solomon-breckon/ch08) | Morphology | Erosion and dilation with different and decomposed structuring elements, opening, closing, hole filling, connected-component labelling. 5 exercises plus the examples. |

## Gonzalez, Woods & Eddins, *Digital Image Processing Using MATLAB* (3rd ed.) → [`dip-using-matlab-gonzalez/`](dip-using-matlab-gonzalez)

| Chapter | What I did |
|---------|------------|
| [**3**: Intensity transformations and spatial filtering](dip-using-matlab-gonzalez/ch03) | All the chapter examples (`Chapter3.m`) and projects P3.1–P3.10, in MATLAB and Python: log, gamma, contrast-stretch and sigmoid transforms; global and local histogram equalisation; histogram specification; execution-time comparison; order-statistic and nonlinear filters (`ordfilt2`, `colfilt`, median); and an intensity transformation based on fuzzy rules (P3.10). |

I did not have the book's support package, so I solved the Gonzalez projects on a personal portrait photo
instead of the book images. All the scripts work with any input image. P3.8 needs two data files that only come
with the support package, so I could not solve it. More details are in the
[projects README](dip-using-matlab-gonzalez/ch03/projects/README.txt).

## Running

Each `.m` file runs on its own in MATLAB with the Image Processing Toolbox. Most scripts use the standard
toolbox images (`cameraman.tif`, `rice.png`, `coins.png`, `peppers.png`, …). The book-specific images are not
included here; you can download them from each book's website and put them next to the script. The Python
projects need `numpy`, `pillow` and `matplotlib`.

## Files

```
fundamentals-solomon-breckon/
  ch03 … ch08/
    examples/             Worked examples from the chapter
    exercises/            My solutions to the exercises
      outputs/            Result figures
dip-using-matlab-gonzalez/
  ch03/
    examples/             Chapter examples (+ notes on numeric outputs)
    projects/             Projects P3.1–P3.10 (MATLAB / Python)
      outputs/
docs/                     The figure at the top and the script that makes it
```
