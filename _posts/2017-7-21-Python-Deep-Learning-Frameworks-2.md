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
2. Have [Anaconda](https://www.continuum.io/downloads) with Python 3.5+ installed
3. Have updated conda with `conda update conda`
4. Updated all libraries with `conda update --all`
5. Have Pip installed
6. Have [Homebrew](https://brew.sh/) installed
7. Have administrator privileges

Linux users will have to make a few adjustments; see the docs. Windows users, I'm sorry but you're on your own. 

## Installation 

### Neon (version 2.0.0)
Source installation instructions can be found [here](http://neon.nervanasys.com/docs/latest/installation.html) but here are the steps you need to know to get up and running:
1. `conda create --name neon pip`
2. `source activate neon`
3. `git clone https://github.com/NervanaSystems/neon.git`
4. `cd neon && make sysinstall`

1. Install the [Math Kernel Library](https://software.intel.com/en-us/mkl). *Might not be required.*
2. Set Intel library versions as default: `conda config --add channels intel`
3. Create Intel conda environment: `conda create -n intel intelpython3_full python=3`
4. Activate Intel conda env: `source activate intel`
5. Install conda dependencies: `conda install h5py pkg-config`
6. Install special dependency for audio/videos: `conda install -c menpo ffmpeg`
7. Install special dependency for images: `conda install -c menpo opencv3` - THIS DOESN'T WORK, NEED TO FIX
8. Install pip dependencies: `pip install pyaml`
9. Install Neon: `git clone https://github.com/NervanaSystems/neon.git`
10. Configure Neon: `cd neon && make sysinstall`
11. Test installation: `python examples/mnist_mlp.py -b mkl` or `neon examples/mnist_mlp.yaml`

**Fix: MKL backend not working.**

As an aside, if you're not sure which libraries are installed, do the following:
- Check your conda libraries `conda list`  
- Check your pip libraries `pip freeze` 

Notes: MKL backend didn't work out of the box

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

## Results
In my opinion, PyTorch is optimal because it uses conda as the recommended install process. So incredibly easy!
