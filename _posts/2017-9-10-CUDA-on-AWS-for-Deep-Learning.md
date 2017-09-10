---
published: false
title: Configuring CUDA on AWS for Deep Learning with GPUs
categories: [AWS, CUDA, Deep Learning, GPU, Python, PyTorch]
---
![image](/assets/images/nvidia_gpu.jpg?raw=true){: .center-image }

**Objective:** a no frills tutorial showing you how to setup CUDA on AWS for Deep Learning using GPUs.

**Audience:** those comfortable at the command line and familiar with AWS. 

**Note:** you'll have to request access to GPUs on AWS prior to completing this tutorial. 

## Instance Setup
1. On AWS, select **Ubuntu Server 14.04 LTS (HVM), SSD Volume Type - ami-43391926** as your Amazon Machine Image (AMI)
2. Choose **p2.xlarge** as your instance type. 
3. Configure storage, tags, and security group however you like. The defaults are just fine. The only exception is security group. Make sure you set source to **My IP** so only you have SSH access.
4. Then launch the instance.

## CUDA Configuration
1. SSH into your AWS instance.
2. Type: `sudo apt-get update`
3. Type: `sudo apt-get install dkms`
3. Download CUDA by typing: `wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run`
4. Run CUDA script: `sudo sh cuda_8.0.61_375.26_linux-run`
5. An agreement will follow. Use spacebar to page to the end and type `accept`.
6. Type `yes` to install NVIDIA Graphics Driver.
7. Type `yes` to install OpenGL libraries.
8. Type `yes` to run nvidia-xconfig.
9. Type `yes` to install the CUDA 8.0 Toolkit.
10. Hit `enter` to accept the default Toolkit location.
11. Type `yes` to install a symbolic link at /usr/local/cuda.
12. Type `no` to install the CUDA 8.0 Samples.

## PyTorch Configuration
1. Download key libraries: `sudo apt-get install -y cmake zlib1g-dev libjpeg-dev xvfb libav-tools xorg-dev python-opengl libboost-all-dev libsdl2-dev swig libgl1-mesa-dev libglu1-mesa freeglut3 build-essential g++`
2. Download MiniConda: `wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/anaconda.sh`
3. Install MiniConda: `bash ~/anaconda.sh -b -p $HOME/anaconda`
4. Update path: `echo -e '\nexport PATH=$HOME/anaconda/bin:$PATH' >> $HOME/.bashrc && source $HOME/.bashrc`
5. Install PyTorch w/CUDA 8.0 support: `conda install pytorch torchvision cuda80 -c soumith`
6. Check that CUDA is configure properly by opening python, importing torch, and typing: `torch.cuda.is_available()`. Result should be *True*.

---

That's it. Happy Deep Learning!
