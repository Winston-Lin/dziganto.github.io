---
published: false
title: Understanding Classes Through Machine Learning
categories: [Classes, Data Science, Linear Regression, Machine Learning, Python]
---

![image](/assets/images/classes.png?raw=true){: .center-image }

## Introduction
Object-Oriented Programming (OOP) is not easy to wrap your head around. You can read tutorial after tutorial and sift through example after example only to find your head swimming. Don't worry, you're not alone. 

When I first started learning OOP, I read about bicycles and bank accounts and filing cabinets. I read about all manor of objects with basic and specific characteristics. It was easy to follow along. However, I always felt I was missing something. It wasn't until I had that *eureka moment* that I finally glimpsed the power of OOP. 

I always felt as though the eureka moment took longer than it should have. I doubt I'm alone. Therefore, this post is my attempt to explain the basics of OOP through the lens of my favorite subject - machine learning. I hope you find it helpful.

## Setup
I discussed the basics of [linear regression](https://dziganto.github.io/data%20science/linear%20regression/machine%20learning/python/Linear-Regression-101-Basics/) in a previous post. If you're unfamiliar, please start there because I'm going to assume you're up to speed. Anyway, in that discussion, I showed how to find the parameters of a linear regression model using nothing more than simple linear algebra. We defined a function called **ols**, short for Ordinary Least Squares, that looks like this:

```
def ols(X, y):
    '''returns parameters based on Ordinary Least Squares.'''
    xtx = np.dot(X.T, X) ## x-transpose times x
    inv_xtx = np.linalg.inv(xtx) ## inverse of x-transpose times x
    xty = np.dot(X.T, y) ## x-transpose times y
    return np.dot(inv_xtx, xty)
```
