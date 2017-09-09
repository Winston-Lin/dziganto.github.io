---
published: true
title: Image Processing for Deep Learning
categories: [Deep Learning, Image Processing, Python]
---
![image](/assets/images/image_processing.jpg?raw=true){: .center-image }

**Audience:** anyone that uses python and/or deep learning.

**Notebook:** a concrete example can be found in [this](https://github.com/dziganto/dziganto.github.io/blob/master/_notebooks/Image_Processing_for_Deep_Nets.ipynb) Jupyter notebook.

Many deep learning frameworks come pre-packaged with image transformers that do things like flip, crop, and rotate images. However, they may not include preprocessing tools that can significantly decrease computation time. Even if they do, its worth knowing at a basic level how they work. Thus, I created this short tutorial that I hope you find useful. 

Specifically, I'll show you how to: 
1. Convert an RGB image to Grayscale.
2. Downsample the image.
3. Standardize your image data.

To set the stage, let's say we're using a Convolutional Neural Network to classify images. We'll feed this ConvNet RGB images, which are 3D tensors. In other words, we have 3 two-by-two matrices that comprise each image.

To kickoff this example, let's tackle a single RGB image called *img*. We'll assume it has been loaded and *NumPy* has been imported.

## Convert RGB to Grayscale
Converting a three-channel RGB image to a 1-channel grayscale image is often not only sufficient for classification tasks but also less computationally expensive. The good news is that we need do nothing more than apply a simple dot product to get the desired result. 

Note that there are several ways to convert from RGB to grayscale. For the purposes of this tutorial, however, I decided to leverage Matlab's formula.

A simple one-liner is all we need:  
`grayscale = np.dot(img[...,:3], [0.2989, 0.5870, 0.1140])`

## Downsample an Image
Clearly, the size of an image strongly correlates with processing time. What if there were a way to maintain the key structure found in an image but also decrease computation time? There is! It's called downsampling (aka max pooling).

It, too, is a simple one-liner. Note that I'm using the skimage.measure library here:  
`downsample = skimage.measure.block_reduce(grayscale, (2,2), np.max)`

## Standardize Data
Lastly, in deep learning we leverage some form of Stochastic Gradient Descent. This means we want our data standardized (mean 0, std 1). While there are typically functions contained in a deep learning framework that do this for us, here's a simple implementation worth understanding:  
`standardize = (downsample - downsample.mean()) / np.sqrt(downsample.var() + 1e-5)`

You may be wondering why there's an extra term in the denominator. The *1e-5* is included for numerical stability. Consider what happens if data.var() equals 0. This extra term prevents an error from being thrown so we don't have division by zero. 

## Summary
This brief tutorial showed three image processing techniques, often used together, that can dramatically speed up your Deep Nets. While many frameworks include functions that handle one or more of these techniques, it's always good to know what's going on under the hood. Furthermore, understanding the nuts and bolts of these techniques allows you to code your own implementation should a deep learning framework lack a particular function. 

Anyway, I hope you found this tutorial helpful.  
