---
published: false
title: Python Deep Learning Frameworks (2) - Installation
categories: [Deep Learning, Nervana Neon, Python, PyTorch, TensorFlow]
---
![](/assets/images/include.jpeg?raw=true)

## Introduction


## Objective
The objective of this post is document the installation process for Neon, PyTorch, and TensorFlow. Installation notes and tips to make the installation smooth are included. Lastly, an assessment of the relative difficulty of installing each deep learning framework is contained within for comparison purposes. 

## Requirements
I'm going to make some key assumptions to keep this post as brief as possible. In particular, I'm assuming you:

1. Are using a Mac
2. Have [Anaconda](https://www.continuum.io/downloads) installed 
3. Have updated conda with `conda update conda`
4. Updated all libraries with `conda update --all`
5. Have Pip installed
6. Have [Homebrew](https://brew.sh/) installed

Linux users will have to make a few adjustments; see the docs. Windows users, I'm sorry but you're on your own. 

## Installation 

### Neon (version 2.0.0)
Source installation instructions can be found [here](http://neon.nervanasys.com/docs/latest/installation.html) but here are the steps you need to know:
1. Install the [Math Kernel Library](https://software.intel.com/en-us/mkl). 
2. Set Intel libraries as default: `conda config --add channels intel`
3. Create Intel conda environment: `conda create -n intel intelpython3_full python=3`
4. Activate Intel conda env: `source activate intel`
5. Install conda dependencies: `conda install h5py pkg-config`
6. Install special dependency for audio/videos: `conda install -c menpo ffmpeg`
7. Install special dependency for images: `conda install -c menpo opencv3` - THIS DOESN'T WORK, NEED TO FIX
7. Install pip dependencies: `pip install pyaml`
8. Install Neon: `git clone https://github.com/NervanaSystems/neon.git`
9. Configure Neon: `cd neon && make sysinstall`
10. Test installation: `python examples/mnist_mlp.py -b mkl` or `neon examples/mnist_mlp.yaml`

As an aside, if you're not sure which libraries are installed, do the following:
- Check your conda libraries `conda list`  
- Check your pip libraries `pip freeze` 

