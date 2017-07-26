---
published: false
title: An Introduction To Online Learning
categories: [Online Learning, Python, Scikit-learn]
---
![](/assets/images/data-stream.jpg?raw=true){: .center-image }

# Introduction
While you may not know *batch* or *offline learning* by name, you surely know how it works. It's the standard approach to machine learning. Basically, you source a dataset and build a model on the whole dataset at once. This is why it's called batch learning. You may be wondering why it goes by yet another name: offline learning. That's because offline learning is the polar opposite of another machine learning approach that you may not even be aware of. It's called *online learning* and you should know what it can do for you.

# Objective
My objective in this post is to introduce you to online learning, describe its use cases, and show you how to get started in Scikit-learn. To help motivate things, know that online learning is a powerful tool that opens up a whole new world. It's a tool you can add to your toolbox, giving you capabilities to tackle problems that may have once been beyond your reach.

# Offline vs Online Learning
So what differentiates offline and online learning? In the simplest sense, offline learning is an approach that ingests all the data at one time to build a model whereas online learning is an approach that ingests data one observation at a time. There's a perfect one-to-one analogy here for those familiar with [Gradient Descent](https://en.wikipedia.org/wiki/Gradient_descent). Offline learning, also known as batch learning, is akin to batch gradient descent. Online learning, on the other hand, is the analog of stochastic gradient descent. In fact, as we'll see, implementing online learning in Scikit-learn will utilize stochastic gradient descent with a variety of loss functions to create online learning versions of algorithms like logistic regression and support vector machines. There's more to online learning, though.

Online learning is data efficient and adaptable. Online learning is data efficient because once data has been consumed it is no longer required. Technically, this means you don't have to store your data. Online learning is adapatable because it makes no assumption about your data distribution. As your data distribution morphs and/or drifts, due to say changing customer behavior, the model can adapt on-the-fly to keep pace with trends in real-time. In order to do something similar with offline learning you'd have to create a sliding window of your data and retrain every time. And if you've been paying attention, you surely noticed that you can use this methodology to do streaming analytics. A powerful tool indeed!

# Online Learning Use Cases
Now that you know the difference between offline and online learning, you may be wondering when to consider the latter. Simply put, consider online learning when:
1. Your data doesn't fit into memory
2. You expect your data distribution to morph and/or drift over time

# Implementing With Scikit-Learn
You can tackle both classification and regression problems with online learning. Additionally, there are a variety of loss functions, regularization options, and other hyperparameters for the choosing. To keep this brief, I'll walk you through a regression example using robust regression with L2 regularization. 

>If you're interested in implementing Ordinary Least Squares or in implementing Support Vector Machines or Logistic Regression for classification problems, see my notebook [here](https://github.com/dziganto/dziganto.github.io/blob/master/_notebooks/Online_Learning.ipynb) for details.

Scikit-learn comes with a number of canonical datasets. We'll use the [Boston](http://scikit-learn.org/stable/modules/generated/sklearn.datasets.load_boston.html#sklearn.datasets.load_boston) dataset here. 

Step 1 - Import the necessary libraries:
```
from sklearn.datasets import load_boston
from sklearn.model_selection import train_test_split
from sklearn.linear_model import SGDRegressor
from sklearn.metrics import mean_squared_error
from sklearn.preprocessing import StandardScaler
```

Step 2 - Load the data:
```
boston = load_boston()
```

Step 3 - Split data into training and test sets:
```
X_train_boston, X_test_boston, y_train_boston, y_test_boston = train_test_split(boston.data,
                                                                                boston.target,
                                                                                test_size=0.2, 
                                                                                random_state=42)
```

Step 4 - Instantiate the model:
```
robust = SGDRegressor(loss='huber',
                      penalty='l2', 
                      alpha=0.0001, 
                      fit_intercept=False, 
                      n_iter=5, 
                      shuffle=True, 
                      verbose=1, 
                      epsilon=0.1, 
                      random_state=42, 
                      learning_rate='invscaling', 
                      eta0=0.01, 
                      power_t=0.5)
```
Notice that the loss function is set to **huber**. If you're unfamiliar with this loss function, check out [this](https://en.wikipedia.org/wiki/Huber_loss) Wikipedia article. 

Since we're leveraging Gradient Descent, we need to standardize our data like so:
```
sc_boston = StandardScaler()
X_train_boston = sc_boston.fit_transform(X_train_boston)
X_test_boston = sc_boston.transform(X_test_boston)
```
Make sure to only fit on the training set. Then use that fit to transform the training and test sets. Unfortunately, many mistakenly standardize the data prior to splitting into train and test, which causes information leakage.  

Step 5 - Fit the model:
```
robust.fit(X_train_boston, y_train_boston)
```
Verbose was set to 1 when the model was instantiated, so you'll see printouts of metadata for each epoch. You can set verbose to 0 if you want this process to happen quietly.

Step 6 - Check the RMSE on the test set:
```
mean_squared_error(y_test_boston, robust.predict(X_test_boston)) ** 0.5
```
The RMSE turns out to be a little better for this robust regressor as opposed to OLS. You can check my notebook or run the code yourself. 

That's it. Pretty painless.

# What's Next?
This is just the tip of the iceburg. In a future post, we'll pair up online learning with something called out-of-core computation, all in the PyData stack. This will allow us to build models on data that is too large to fit in memory yet fits on disk. The great part about this is that we can build models on large datasets without having to resort to new tools, new computing architectures, or massive code revamps.

# Summary
In this post, I introduced online learning, constrasted it with offline or batch learning, described its typical use cases, and showed you how to implement it in Scikit-learn. 

What should you take away from this post? Online learning is a powerful tool you can now use to tackle problems that may have previously been beyond your reach. 

---

Stay tuned because in a future post I'll pair online learning with something called out-of-core computation to tackle data too big to fit in memory.

---

# Resources
[CILVR Lab @ NYU](http://cilvr.cs.nyu.edu/doku.php?id=courses:bigdata:slides:start)  
[Online Learning & Stochastic Approximations](http://leon.bottou.org/publications/pdf/online-1998.pdf)  
[Fractal Analytics Blog](http://blog.fractalanalytics.com/institutionalizing-analytics/online-machine-learning-2/)
