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
2. Are using Python 3.5
3. Have [Anaconda](https://www.continuum.io/downloads) installed 
4. Updated all libraries with `conda update --all`
5. Have Pip installed
6. Have [Homebrew](https://brew.sh/) installed

Linux users will have to make a few adjustments; see the docs. Windows users, I'm sorry but you're on your own. 

## Installation 

### Neon (version 2.0.0)
*Note: Most of the steps included below come directly from Neon's website located [here](http://neon.nervanasys.com/docs/latest/installation.html).*

The first thing you'll want to do is make sure Neon's dependecies are installed. Here's a checklist for you to follow:

|Library|Installed?|Where to find|
|---|---|--|
|h5py| |conda|
|pip| |--|
|pkg-config| |brew|
|pyaml| |pip| 
|virtualenv| | |python 3|

If you're not sure which libraries are installed, do the following:  
- Check your conda libraries `conda list`  
- Check your pip libraries `pip freeze` 

Check **virtualenv** by typing `python3 -m venv -h`. You should see a bunch of text that ends with 
>*Once an environment has been created, you may wish to activate it, e.g. by sourcing an activate script in its bin directory.* If that's the case, virtualenv is setup correctly.

It's worth installing **OpenCV** and **FFmpeg** while we're at it. You can install **opencv3** with `conda install -c menpo opencv3`. Install **ffmpeg** by typing `brew install ffmpeg`. Check FFmpeg to make sure all dependencies are installed by typing `brew info ffmpeg`. I had to `brew install <insert>`: yasm, texi2html, and pkg-config.

***This installation will focus specifically on CPU installation. Configuring GPU capabilities requires installation of CUDA SDK and drivers. I refer you to Neon's [docs](http://neon.nervanasys.com/docs/latest/installation.html) for additional details.***

The next step is to install Neon with Anaconda. Follow this process:
1. Configure & activate a new conda environment 
```
conda create --name neon pip
source activate neon
```
2. Clone & run a system-wide install.
```
git clone https://github.com/NervanaSystems/neon.git
cd neon && make sysinstall
```
3. Deactivate the environment.
```
source deactivate
```
