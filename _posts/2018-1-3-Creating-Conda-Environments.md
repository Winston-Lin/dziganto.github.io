---
published: false
title: Creating Conda Environments
categories: [Data Science, Python, Anaconda]
---

![Anaconda](/assets/images/anaconda_continuum.png?raw=true){: .center-image }

## Introduction

What's a *virtual environment* and why would you ever use one?

Simply put, you can think of a virtual environment as a container which houses software. 

Great, so what? 

Well it turns out these containers have a number of useful properties. For example, imagine you created the world's most perfect Python demo that uses the NumPy and Matplotlib packages. Your code is beautiful, efficient, and the visualizations are mind boggling. Then a few months go by. You `conda update --all` and notice newer versions of NumPy and Matplotlib. So you update. No big deal, right? 

A friend of yours reaches out because she's in a pinch. Someone was supposed to give a demo at her conference but backed out last minute. Lo and behold your old demo is the perfect substitute. Yay! You agree to run a one-hour session because, hey, the work is all done and you just need to brush up. So you dust off the old code and give it a run. 

Then it happens. You get the infamous error message that some key function imported from Matplotlib was deprecated. Now your code doesn't work. What do you do? 

You have a few options. You could search for a substitute function in the new version. It may or may not exist. Not the worst option but definitely requires a bit of effort without a guarantee of success. Alternatively, you could write your own function to substitute in. This likely requies some heavy lifting, though it could make your code a little more robust. All in all this is not a great option either. 

At this point you're starting to sweat. You expected to devote a few minutes to knocking off the rust but now you're contemplating reconfiguring old code. Not fun.

There is another option and it's particularly enticing.  Because you're whip smart, you enumerated package versions in your code so you know exactly what made it go many months ago. If only you could revert your packages then all would be well, right? 

Not so fast! You've written code recently for another project that leverages new functions from the updated libraries. You break that code by reverting. 

Seems like a catch-22. 

Alas, there is another option that solves all your problems. Enter **virtual environments**. 

What you do is this. You use conda to create a new environment called *demo* that is built with whichever software packages and versions you need to run your demo. That's it. Create a new environment and life is good. You have your root environment for your new projects and the demo environment for your demo. Nothing breaks and everything works. Oh, did I mention it takes maybe a minute or two to set all this up? Easy peasy! Problem solved.

## Details

Alright, let's see how to do this in practice.

Anyone who knows me knows that I'm a HUGE fan of PyTorch. Sure, it's a great deep learning framework but it's also a GPU-enabled beast that picks up where NumPy leaves off. In fact, it's perfectly integrated with the PyData stack, and if you know NumPy you can learn the functionality of PyTorch - sans deep learning - in a few minutes. To get PyTorch on your machine, let's create a *pytorch* environment using conda. 

> Note: I'm using conda version 4.4.6 and PyTorch version 0.3.0. Mileage may vary if you're using different versions.

Here are the steps:
1. create environment with specific Python and package versions
2. activate the environment
3. list packages in environment
4. install PyTorch
5. deactivate enviroment
6. list environments

### Create Environment
Enter this command in Terminal to install Python 3.6, NumPy 1.13.3, and the newest version of SciPy. Note: including a conda package without a version number installs the latest and greatest by default.   
`conda create -n pytorch python=3.6 numpy=1.13.3 scipy`

### Activate Environment
You have to activate the environment to actually use it. Do this like so:  
`source activate pytorch`

### List Packages
Now we're inside the pytorch container (notice *pytorch* in parantheses?). We can see which packages are installed by typing:  
`conda list`

### Install PyTorch
Let's install PyTorch while we're here.  
`conda install pytorch torchvision -c pytorch`

### Deactivate Environment
We can return to the root environment by typing:  
`source deactivate`

### List Environments
We can also see which environments are installed.  
`conda info --envs`

There's so much more you can do with virtual environments but that gives you a taste. Check [managing environments](https://conda.io/docs/user-guide/tasks/manage-environments.html#creating-an-environment-with-commands) in the docs for more details.
