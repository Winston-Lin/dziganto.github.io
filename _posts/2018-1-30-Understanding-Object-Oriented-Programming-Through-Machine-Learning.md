---
published: false
title: Understanding Object-Oriented Programming Through Machine Learning
categories: [Classes, Data Science, Linear Regression, Machine Learning, Python]
---

![image](/assets/images/classes.png?raw=true){: .center-image }

## Introduction
Object-Oriented Programming (OOP) is not easy to wrap your head around. You can read tutorial after tutorial and sift through example after example only to find your head swimming. Don't worry, you're not alone. 

When I first started learning OOP, I read about bicycles and bank accounts and filing cabinets. I read about all manor of objects with basic and specific characteristics. It was easy to follow along. However, I always felt I was missing something. It wasn't until I had that inexplicable *eureka moment* that I finally glimpsed the power of OOP. 

I always felt as though my eureka moment took longer than it should have. I doubt I'm alone. Therefore, this post is my attempt to explain the basics of OOP through the lens of my favorite subject - machine learning. I hope you find it helpful.

## Setup
I discussed the basics of linear regression in a previous post entitled [Linear Regression 101 (Part 1 - Basics)](https://dziganto.github.io/data%20science/linear%20regression/machine%20learning/python/Linear-Regression-101-Basics/). If you're unfamiliar, please start there because I'm going to assume you're up to speed. Anyway, in that discussion I showed how to find the parameters of a linear regression model using nothing more than simple linear algebra. We defined a function called **ols**, short for Ordinary Least Squares, that looks like this:

```
def ols(X, y):
    '''returns parameters based on Ordinary Least Squares.'''
    xtx = np.dot(X.T, X) ## x-transpose times x
    inv_xtx = np.linalg.inv(xtx) ## inverse of x-transpose times x
    xty = np.dot(X.T, y) ## x-transpose times y
    return np.dot(inv_xtx, xty)
```

The output of the **ols** function is an array of parameter values that minimize the squared residuals. As the parameters or coefficients compose the linear regression model, we saved those values like so:

```
parameters = ols(X,y)
```

In other words, the variable *parameters*, an array of scalar values, defines our model. To make predictions we simply take the dot product of our model's parameters and data in the same format as the *X* that was passed to the **ols** function. Here's that same idea in code:

```
predictions = np.dot(X_new, parameters)
```

So now we have a model and a way to make predictions. Not too complicated. But as it turns out we can do better. We can simplify. 

Enter OOP. In the same way we abstracted away a series of calculutions that return the Ordinary Least Squares model parameters in a function called **ols**, we can abstract away *functions* and *data* in a single object called a **class**. Let me show you what I mean and then I'll explain what's going on.

```
import numpy as np

class MyLinearRegression:
    
    def __init__(self, fit_intercept=True):
        self.coef_ = None
        self.intercept_ = None
        self._fit_intercept = fit_intercept

    
    def fit(self, X, y):
        """
        Fit model coefficients.

        Arguments:
        X: 1D or 2D numpy array 
        y: 1D numpy array
        """
        
        # check if X is 1D or 2D array
        if len(X.shape) == 1:
            X = X.reshape(-1,1)
            
        # add bias if fit_intercept
        if self._fit_intercept:
            X = np.c_[np.ones(X.shape[0]), X]
        
        # closed form solution
        xTx = np.dot(X.T, X)
        inverse_xTx = np.linalg.inv(xTx)
        xTy = np.dot(X.T, y)
        coef = np.dot(inverse_xTx, xTy)
        
        # set attributes
        if self._fit_intercept:
            self.intercept_ = coef[0]
            self.coef_ = coef[1:]
        else:
            self.intercept_ = 0
            self.coef_ = coef
            
    def predict(self, X):
        """
        Output model prediction.

        Arguments:
        X: 1D or 2D numpy array 
        """
        # check if X is 1D or 2D array
        if len(X.shape) == 1:
            X = X.reshape(-1,1) 
        return self.intercept_ + np.dot(X, self.coef_) 
```

