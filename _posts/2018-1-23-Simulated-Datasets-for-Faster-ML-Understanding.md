---
published: false
title: Simulated Datasets for Faster ML Understanding
categories: [Data Science, EDA, Machine Learning, Python, Simulated Data]
---

![image](/assets/images/innovative_approach.jpg?raw=true){: .center-image }

## Introduction
Oftentimes, the most difficult part of gaining expertise in machine learning is developing intuition about the strengths and weaknesses of the various algorithms. Common pedagogy follows a familiar pattern: theoretical exposition followed by application to a contrived dataset. For example, suppose you're learning a classification algorithm for supervised machine learning. For specificity, let's assume the algorithm du jour is [Gaussian Naive Bayes](https://en.wikipedia.org/wiki/Naive_Bayes_classifier#Gaussian_naive_Bayes) (GNB). You learn the mechanics and the fundamental assumptions, as a natural starting point. That gives you the big idea. Maybe you even code GNB from scratch to gain deeper insight. Great. Now comes time to apply GNB to real data. A canonical example is often presented, for example the [Iris](https://en.wikipedia.org/wiki/Iris_flower_data_set) dataset. You learn to connect theory and application. Powerful. So what's the problem?

The problem is simply this: You don't know the generative process underlying the Iris dataset. Sure, you're trying to deduce a proxy by fitting your GNB model. That's the point of modeling. But that's not what I'm getting at. Instead, I want to pull back the curtain. I want to show you how to understand machine learning algorithms at a much deeper level, the level of intuition. How you get there and how quickly you get there is a matter of technique, and it's this technique that I'll share with you so you too can gain deep expertise and intuition about machine learning algorithms with great alacrity. 

## Baby Steps
Imagine you knew the generative process underlying a dataset. In other words, imagine you knew exactly how data was generated and how all the pieces fit together. In short, imagine you have perfect information. Now imagine running GNB on your data. Because you know precisely how the data was generated and because you know how GNB works, you can start piecing together where GNB performs well and in what situations it struggles. Now imagine you knew the generative process of not one but many datasets. Furthermore, imagine applying not just GNB but Logistic Regression, Random Forest, Support Vector Machines, and a slew of other classification algorithms you have at your disposal. All of a sudden you have the ability to garner deep insights into each of the algorithms and fast. 

But how do you move from imagination to reality?

## Simulated Data
