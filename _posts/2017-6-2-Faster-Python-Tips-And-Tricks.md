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
## Looping Over A Collection
Looping over a collection is like this. Say you have a list of animals ['aardvark', 'bee', 'cat', 'dog'] and you want to access each item one at a time. How can you do this. One way is to access the item by index. So, for example, you could use a listcomp like this: 
```
animals = ['aardvark', 'bee', 'cat', 'dog']
[animals[i] for i in range(len(animals))]
```
Of course, this example is silly because we are generating a list from a list. However, the point is that we are iterating and doing something with the iterables. The *thing* we do can be anything.

Another way to approach the same problem is:
```
animals = ['aardvark', 'bee', 'cat', 'dog']
[animal for animal in animals]
```
It is definitely easier to read and understand what is happening. But is it faster? Turns out that it is. Cuts the processing time nearly in half. 

## Looping Over A Collection & Indices
We know what looping over a collection looks like. What is this *indices* business. Well, instead of just returning the list item, we also want to know its index value. The two approaches that were tested are as follows:
```
# Approach #1
animals = ['aardvark', 'bee', 'cat', 'dog']
[(i, animals[i]) for i in range(len(animals))]
```
```
# Approach #2
animals = ['aardvark', 'bee', 'cat', 'dog']
[(i, animals) for i in enumerate(animals)]
```
Again, the second approach is clearly more readable. But is it faster? Turns out the first approach is slightly faster. Exactly why is something I intend to investigate in the future.

## Looping Over Two Collections
We know what looping over a single collection looks like. What do we mean looping over two collections? Here's an example. Say we have the animals list as before. Also say we have another list of flowers ['allium', 'bellflower', 'crocus', 'dahlia']. The output we are looking for is a list of tuples that looks like [('aardvark', 'allium'), ('bee', 'bellflower'), ('cat', 'crocus'), ('dog', 'dahlia')]. The two approaches tested were as follows:
```
Approach #1
animals = ['aardvark', 'bee', 'cat', 'dog']
flowers = ['allium', 'bellflower', 'crocus', 'dahlia']
[(animals[i], flowers[i]) for i in range(min(len(animals), len(flowers)))]
```
```
Approach #2
animals = ['aardvark', 'bee', 'cat', 'dog']
flowers = ['allium', 'bellflower', 'crocus', 'dahlia']
[(animal, flower) for animal, flower in zip(animals, flowers)]
```
I suspect most everyone would agree that the second approach is more Pythonic. But is it faster? Here we see our first discrepancy between Py27 and Py35. The first approach is faster for Py27 while the second approach is faster for Py35. The reason for this peculiar behavior has to do with the zip function. In Py35, zip() is an iterator whereas it is not in Py27. One way to combat this in Py27 is by using izip() in the itertools library. 

## Sorting Lists In Reverse Order
This one is straightforward. Say I have my list of animals but I want to reverse the order so it looks like ['dog', 'cat', 'bee', 'aardvark']. Here are the two approaches:

```
Approach #1
animals = ['bee', 'dog', 'cat', 'aardvark']
[animals[i] for i in range(len(animals)-1, -1, -1)]
```
```
Approach #2
animals = ['bee', 'dog', 'cat', 'aardvark']
[animal for animal in reversed(animals)]
```
The second approach is once again much more elegant. But is it faster? Yes, it is. By quite a bit and for both versions of Python.

## Appending Strings
Say I want to loop through and append my strings like I would a list. If you are familiar with Python strings, you know that a new string is actually created, not actually appending to the original string. Good to know. So let's look at the two approaches.
```
Approach #1
my_string = ""
mylist = list('abcdefghijklmnopqrstuvwxyz')
for item in mylist: my_string += item
```
```
Approach #2
my_string = ""
mylist = list('abcdefghijklmnopqrstuvwxyz')
my_string = "".join([item for item in mylist])
```
The first is probably easier to wrap your head around unless you have already worked with the esoteric looking *string.join()* function before. So which is faster? It appears the first approach may be faster. However, I am calling this result inconclusive. Why? I will skip the implementation details but the short version is that I was only able to time a single run for each approach using *%time* instead of the multi-run *%timeit*. Therefore, the results are questionable. I plan to circle back in the future to conduct a more thorough test.

## Standard Library


## ListExp vs GenExp


## Dots


# Part 2: Py27 vs Py35

---
# Links
[4 Performance Optimization Tips For Faster Python Code](http://blog.hackerearth.com/4-Performance-Optimization-Tips-Faster-Python-Code)  
[PythonSpeed Performance Tips](https://wiki.python.org/moin/PythonSpeed/PerformanceTips)  
[6 Python Performance Tips](https://dzone.com/articles/6-python-performance-tips)
