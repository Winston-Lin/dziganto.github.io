---
published: true
title: Python Deep Learning Frameworks (2) - Installation
categories: [Deep Learning, Python, PyTorch, TensorFlow, Theano]
---
![](/assets/images/installing.jpeg?raw=true){: .center-image }

## Introduction
This is the second post in a series looking at three leading deep learning frameworks in Python. As described in the last post [Python Deep Learning Frameworks (1) - Introduction](https://dziganto.github.io/deep%20learning/python/pytorch/tensorflow/theano/Python-Deep-Learning-Frameworks-1/), the overall goal is to assess each on a number of dimensions. In this post we will investigate the installation process.

## Objective
The objective of this post is to document the installation process for PyTorch, TensorFlow, and Theano. An assessment of the relative difficulty of installing each deep learning framework is included at the end for comparison purposes. 

## Requirements
I'm going to make some key assumptions to keep this post as brief as possible. In particular, I'm assuming you:

1. Are using a Mac
2. Have installed [Anaconda](https://www.continuum.io/downloads) with Python 3.5+
3. Have updated conda with: `conda update conda`
4. Updated all libraries with: `conda update --all`
5. Have installed Pip
6. Have installed [Homebrew](https://brew.sh/)
7. Have administrator privileges

## Installation 
On to the installation process. We'll begin with PyTorch, transition to TensorFlow, and conclude with Theano. 

### PyTorch (version 0.2.0)
Source installation instructions can be found [here](http://pytorch.org/) but here are the steps you need to know to get up and running:
1. Create PyTorch conda environment: `conda create --name pytorch python=3.5 numpy`
2. Activate PyTorch conda env: `source activate pytorch`
3. Install PyTorch: `conda install pytorch torchvision -c soumith`

**Notes:** Installation through conda is the recommended approach. For this reason, setup couldn't be easier. Installation was fast, smooth, and dead simple. Three steps and PyTorch was installed and configured. It really doesn't get any easier than this. 

### TensorFlow (version 1.2)
Source installation instructions can be found [here](https://www.tensorflow.org/install/install_mac). Tensorflow provides multiple options for installation: virtualenv, pip, Docker, and from source. The recommended approach is virtualenv but this caused errors on my machine. So as not to break any of my other open source software configurations, I used pip to install. 

To note is that I did not build this from source which would have leveraged hardware acceleration. Therefore, CPU performance will be degraded somewhat. It's not a big deal from an installation perspective but it will have implications in the future when comparing performance.  

Here are the steps you need to know to get up and running:
1. Create TensorFlow conda environment: `conda create -n tensorflow`
2. Activate TensorFlow conda environment: `source activate tensorflow`
3. Install TensorFlow: 
```
pip install --ignore-installed --upgrade https://storage.googleapis.com/tensorflow/mac/cpu/tensorflow-1.2.1-py3-none-any.whl
```

**Notes:** Having options with regards to installing TensorFlow is great because odds are you're comfortable with at least one approach. That said, I chose to leverage pip which made installation a breeze. In just three steps I was able to install and configure TensorFlow without issue. However, would I have preferred conda instead of pip? You bet. So for that reason I give PyTorch a very slight edge.  

### Theano (version 0.9)
Source installation instructions can be found [here](http://deeplearning.net/software/theano/install_macos.html). Theano and its dependencies, one of which (pygpu) requires Python 2.7, can easily be installed with conda like so:
1. Create Theano conda environment: `conda create --name theano python=2.7`
2. Activate Theano conda environment: `source activate theano`
3. Install Theano dependencies: `conda install numpy scipy mkl nose sphinx pydot-ng`
3. Install Theano: `conda install theano pygpu`

**Notes:** Like PyTorch, everything is installed through conda which makes installation dead simple. My only gripe is that one of Theano's dependencies requires Python 2.7. Definitely not a deal breaker but I prefer Python 3. For that reason, I give PyTorch and TensorFlow the edge.

## An Aside
If you're not sure which libraries you have installed, do the following:
- Check your conda libraries: `conda list`  
- Check your pip libraries: `pip freeze` 

## Summary
All three Python deep learning frameworks were incredibly easy to install and configure; I didn't run into a single major issue. I give a slight edge to PyTorch for leveraging conda and Python 3. TensorFlow, in my opinion, runs a very close second because it builds with Python 3 but relies on pip instead of conda. Theano captures the third spot. It leverages conda for the installation process but requires Python 2.7 due to one of its dependencies. 

All in all, the installation process was a breeze for all three frameworks. I say PyTorch > TensorFlow > Theano for the reasons mentioned above but keep in mind that the differences are minuscule. 
