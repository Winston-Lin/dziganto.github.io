---
published: false
title: Creating Conda Environments
categories: [Data Science, Python, Anaconda]
---

![Anaconda](/assets/images/anaconda_continuum.png?raw=true){: .center-image }

What's a *virtual environment* and why would I ever use one?

Simply put, you can think of a virtual environment as a container which houses some software. Great, so what? Well it turns out these containers have a number of useful properties. For example, imagine you created the world's most perfect demo that uses NumPy and Matplotlib under the hood. Your code is beautiful, efficient, and the visualizations are mind boggling. Then a few months go by. You **conda update --all** and notice newer versions of NumPy and Matplotlib so you update. No big deal, right? 

But then a friend of yours is in a pinch. Someone was supposed to give a demo at her conference but backed out last minute. Lo and behold your old demo is the perfect substitute. Yay! You agree to run a one-hour session because, hey, the work is all done; you just need a brush up. So you dust off the old code and give it a run. Then it happens. You get the infamous error message that some key function imported from Matplotlib was deprecated in the new version. Now your code doesn't work. What do you do? 

You have a few options. You could search for a substitute function in the new version. Not the worst option but definitely requires at least a bit of effort. You could write your own function to substitute in. Definitely not a great option. This will require a fair bit of work, though it does make your code a little more robust. But wait, there's a better option. If you were smart, you enumerated package versions in your code so you know exactly what made it go so many months ago. If only you could revert your packages and all would be well, right? Not so fast! You've written code recently that leverages new functions from the updated libraries. You break that code by reverting. Seems like a catch-22. Alas, there is another option that solves all your problems. Enter virtual environments.

What you do is this. You use conda to create a new environment called *demo* that is built with which software packages and versions you need to run your demo. That's it. Create a new environment and life is good. Nothing breaks and everything works. Oh, did I mention it takes maybe a minute or two to set all this up. Easy peasy!

Alright, let's see how to actually do this.

It's no secret that I'm a big fan of PyTorch. Sure, it's a great deep learning framework but it's also a GPU-enabled beast that picks up where NumPy leaves off. In fact, it's perfectly integrated with the PyData stack and if you know NumPy you can learn the majority of the functionality sans deep learning in a few minutes. To get PyTorch on your machine, let's create a *pytorch* environment using conda. 

> Note: I'm using conda version 4.4.6 and PyTorch version 0.3.0. Mileage may vary if you're using different versions.

