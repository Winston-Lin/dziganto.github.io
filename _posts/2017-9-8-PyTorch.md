---
published: false
title: An Introduction to PyTorch
categories: [Deep Learning, Python, PyTorch]
---
![image](/assets/images/name.jpeg?raw=true)

## Introduction

## Preliminaries
This tutorial assumes that you: 
1. Use a Mac
2. Have administrator privileges
3. Installed [Anaconda](https://www.continuum.io/downloads) with Python 3.5+
4. Updated conda with: `conda update conda`
5. Have a basic understanding of Convolutional Neural Networks ([watch this video](https://www.youtube.com/watch?v=FmpDIaiMIeA)) 

## PyTorch Setup
1. Create conda environment: `conda create --name pytorch numpy`
2. Activate conda environment: `source activate pytorch`
3. Install PyTorch: `conda install pytorch torchvision -c soumith`
4. Install Jupyter notebook kernel and matplotlib: `conda install nb_conda matplotlib`

## Download Data
1. Go [here](https://github.com/zalandoresearch/fashion-mnist) and find the section entitled **Get the Data** located towards the middle. 
2. Download the training and test set images and labels. 
