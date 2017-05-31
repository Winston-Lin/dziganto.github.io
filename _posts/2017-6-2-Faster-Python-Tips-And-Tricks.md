---
published: false
categories: [Python]
title: Faster Python - Tips & Tricks
---

# Introduction
There is a plethora of information about how to speed up Python code. Some stategies revolve around leveraging libraries like Cython whereas others propose a "do this, not that" approach. An example of the latter is using list expressions instead of creating an empty list, looping through, and appending at each iteration. There exist many "do this, not that" strategies but I decided to focus on just a few, which I discovered in the *Links* section below. 

My initital intent was just to test the assertions. However, as I collected experimental data on the various methods, I became curious about another claim I hear often: Python 3 is faster than Python 2. So I plied the exact same experimental methods in Python 2.7 (Py27) and Python 3.5 (Py35), effecting the necessary changes like using xrange for Py27 and and range for Py35. All of my experiments as well as results and corresponding graphs can be found here: [Py27 Notebook](https://github.com/dziganto/dziganto.github.io/blob/master/_notebooks/Faster_Python_Tips_And_Tricks_Py27.ipynb) and [Py35 Notebook](https://github.com/dziganto/dziganto.github.io/blob/master/_notebooks/Faster_Python_Tips_And_Tricks_Py35.ipynb).

This post is split into two parts. In **Part 1**, I will compare two approaches commensurate with the "do this, not that" line of reasoning to see if there is a substantial difference and, if so, which approach is better. In **Part 2**, I will compare Py27 and Py35 within each category to see if there is credence to the claim that Py35 is indeed faster. 

# Part 1: Comparing Methods
