---
published: false
title: Python Deep Learning Frameworks (2) - Installation
categories: [Deep Learning, Nervana Neon, Python, PyTorch, TensorFlow]
---
![](/assets/images/include.jpeg?raw=true)

## Introduction


## Objective
The objective of this post is document the installation process for PyTorch, TensorFlow, and Theano. Installation notes and tips to make the installation smooth are included. Lastly, an assessment of the relative difficulty of installing each deep learning framework is contained within for comparison purposes. 

## Requirements
I'm going to make some key assumptions to keep this post as brief as possible. In particular, I'm assuming you:

1. Are using a Mac
2. Have [Anaconda](https://www.continuum.io/downloads) with Python 3.5+ installed
3. Have updated conda with `conda update conda`
4. Updated all libraries with `conda update --all`
5. Have Pip installed
6. Have [Homebrew](https://brew.sh/) installed
7. Have administrator privileges

Linux users will have to make a few adjustments; see the docs. Windows users, I'm sorry but you're on your own. 

## Installation 

### PyTorch (version 0.1.12)
Source installation instructions can be found [here](http://pytorch.org/) but here are the steps you need to know to get up and running:
1. Create PyTorch conda environment: `conda create --name pytorch numpy`
2. Activate PyTorch conda env: `source activate pytorch`
3. Install PyTorch: `conda install pytorch torchvision -c soumith`

Notes: Dead simple. Recommended install is Anaconda. Couldn't be easier!

### TensorFlow (version 1.2)
Source installation instructions can be found [here](https://www.tensorflow.org/install/install_mac). Tensorflow provides multiple options for installation: virtualenv (recommended), pip, Docker, and from source. The recommended approach is virtualenv but this caused errors on my machine. So as not to break any other open source software configurations on my machine, I'm going to use Anaconda to install. This is important to note because installing this way comes with degraded performance. It doesn't leverage hardware acceleration that gives better CPU performance. Something to keep in mind when comparing performance between the three frameworks in a future post. 

Here are the steps you need to know to get up and running:
1. Create TensorFlow conda environment: `conda create -n tensorflow`
2. Activate TensorFlow conda environment: `source activate tensorflow`
3. Install TensorFlow: `pip install --ignore-installed --upgrade https://storage.googleapis.com/tensorflow/mac/cpu/tensorflow-1.2.1-py3-none-any.whl`

Notes: Dead simple w/Anaconda. Recommended install is virtualenv. Supports pip to install as well, so there are options which is nice. Using pip will come with degraded performance, though, because doesn't leverage hardware acceleration that gives better CPU performance. 

### Theano (version 0.9)
Source installation instructions can be found [here](http://deeplearning.net/software/theano/install_macos.html). Theano and its dependencies, one of which (pygpu) requires Python 2.7, can easily be installed with Anaconda like so:
1. Create Theano conda environment: `conda create --name theano python=2.7`
2. Activate Theano conda environment: `source activate theano`
3. Install Theano dependencies: `conda install numpy scipy mkl nose sphinx pydot-ng`
3. Install Theano: `conda install theano pygpu`

### An Aside
If you're not sure which libraries are installed, do the following:
- Check your conda libraries `conda list`  
- Check your pip libraries `pip freeze` 

## Results
All three were easy to install and configure with conda. Didn't run into any major issues. The only minor issues was the error I got with virtualenv with regards to TensorFlow, but using conda made the installation easy. Again, I focused on the CPU setup, forgoing the GPU side of things. 
