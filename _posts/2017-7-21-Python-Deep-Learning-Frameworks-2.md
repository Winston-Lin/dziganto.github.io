---
published: false
title: Python Deep Learning Frameworks (2) - Installation
categories: [Deep Learning, Nervana Neon, Python, PyTorch, TensorFlow]
---
![](/assets/images/include.jpeg?raw=true)

## Introduction
I'm using python 3.5 with Anaconda installed on a Mac. Make sure you **conda update --all** before doing anything else. 

Neon requires python version 2.7 or 3.4+. Again, I'm using 3.5. 

## Objective

## Requirements
1. Mac
2. Anaconda installed with Python 3.4+
3. Pip installed
4. Homebrew installed

## Installation 

### Neon (version 2.0.0)
*Note: All the steps included below come directly from Neon's website located [here](http://neon.nervanasys.com/docs/latest/installation.html).*

There are several dependencies that you need prior to installing Neon. Make sure you have the latest versions of:

1. pip
2. virtualenv
3. h5py
4. pyaml
5. pkg-config

If you're not sure which libraries are installed, do the following:  
- Check your conda libraries by typing **conda list**  
- Check pip by typing **pip freeze** 

You can install **pyaml** with pip. Check **virtualenv** by typing **python3 -m venv -h**. You should see a bunch of text that ends with 
>*Once an environment has been created, you may wish to activate it, e.g. by sourcing an activate script in its bin directory.* If that's the case, virtualenv is setup correctly.

It's worth installing OpenCV and FFmpeg while we're at it. You can install **opencv3** by typing **conda install opencv**. Install **ffmpeg** by typing **brew install ffmpeg**. Check FFmpeg to make sure all dependencies are installed by typing **brew info ffmpeg**. I had to brew install yasm, texi2html, and pkg-config.

This installation will focus specifically on CPU installation. Configuring GPU capabilities requires installation of CUDA SDK and drivers. I refer you to Neon's [docs](http://neon.nervanasys.com/docs/latest/installation.html) for additional details.
