---
published: false
title: An Introduction To Online Learning
categories: [Online Learning, Python, Scikit-learn]
---
![](/assets/images/data-stream.jpg?raw=true){: .center-image }

# Introduction
While you may not know batch or offline learning by name, you surely know how it works. It's the standard approach to machine learning. Basically, you source a dataset and build a model on the whole dataset at once. This is why it's called batch learning. You may be wondering why it goes by yet another name: offline learning. That's because offline learning is the polar opposite of another machine learning approach that you may not even be aware of. It's called online learning and you should know what it can do for you.

# Objective
My objective in this post is to introduce you to this concept of online learning, describe its use cases, and show you how to get started in Scikit-learn. To help motivate things, know that online learning is a powerful tool that opens up a whole new world. In other words, its a tool you can add to your toolbox, giving you capabilities to tackle problems that may have once been beyond your reach.

# Offline vs Online Learning
So what differentiates offline and online learning? In the simplest sense, offline learning is an approach that ingests all the data at one time to build a model whereas online learning is an approach that ingests data one observation at a time. There's a perfect one-to-one analogy here for those familiar with [Gradient Descent](https://en.wikipedia.org/wiki/Gradient_descent). Offline learning, also known as batch learning, is akin to batch gradient descent. Online learning, on the other hand, is the analog of stochastic gradient descent. In fact, many machine learning algorithms that you're already familiar with use gradient descent under the hood - algorithms like linear regression or logistic regression. 

Furthermore, online learning is data efficient and adaptable. Online learning is data efficient because once data has been consumed it is no longer required. Technically, this means you don't have to store your data. Online learning is adapatable because it makes no assumption about your data distribution. As your data distribution morphs and/or drifts, due to say changing customer behavior, the model can adapt on-the-fly to keep pace with trends in real-time. In order to do something similar with offline learning you'd have to create a sliding window of your data and retrain every time. And if you've been paying attention, you surely noticed that you can use this methodology to do streaming analytics. A powerful tool indeed!

# Online Learning Use Cases
Now that you know the difference between offline and online learning, you may be wondering when to consider the latter. Simply put, consider online learning when:
1. Your data doesn't fit into memory
2. You expect your data distribution to morph and/or drift over time

# Implementing With Scikit-Learn
Notebook located [here](https://github.com/dziganto/dziganto.github.io/blob/master/_notebooks/Online_Learning.ipynb).


# What's Next?
This is just the tip of the iceburg. In a future post, we'll pair up online learning with something called out-of-core computation, all in the PyData stack. This will allow us to build models on data that is too large for memory yets fits on disk. The great part about this is that we can build models on large datasets without having to resort to new tools, new computing architectures, or massive code revamps.

# Summary
In this post, I introduced online learning, constrasted it with offline or batch learning, described its typical use cases, and showed how to implement it in Scikit-learn. What should you take away from this? Online learning is a powerful tool you can use to tackle problems that may have seemed out of reach before. For example, by pairing this approach with another called out-of-core that I'll present in a future post, we can tackle data too big for memory. Additionally, online learning is data efficient and highly adapatable to changing data distributions in real-time, which goes by the name streaming analytics. 

# Resources
[CILVR Lab @ NYU](http://cilvr.cs.nyu.edu/doku.php?id=courses:bigdata:slides:start)  
[Online Learning & Stochastic Approximations](http://leon.bottou.org/publications/pdf/online-1998.pdf)  
[Fractal Analytics Blog](http://blog.fractalanalytics.com/institutionalizing-analytics/online-machine-learning-2/)
