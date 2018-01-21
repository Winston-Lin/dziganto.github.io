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

## On the Road to Something Greater
The answer may surprise you. Create your own datasets! That may sound daunting but really it's not. Let me walk you through one of my earliest incarnations. I even created a little backstory just to keep things interesting. Without further ado, allow me to introduce my first dataset.

## Dataset Description
What follows is a full on description of the very first dataset I created. Industry tends to call this process this type of dataset a **simulated dataset**. 

### Introduction
This dataset is built from scratch. It has the following properties: 

>**Type:** Classification  
**Balanced:** No (slightly imbalanced)  
**Outliers:** Yes  
**Simulated Human Data Entry Errors:** Yes  
**Missing Values:** Yes  
**Nonsensical Data Types:** Yes  

Furthermore, the dataset is designed in such a way that relying on intuition alone will lead the data science practitioner astray. 

### Problem Description
InstaFace (IF) is a cutting edge startup specializing in facial recognition. As a hot tech startup, IF is constantly on the lookout for identifying and hiring the best talent. Because they are the best at what they do, their applicant pool is massive and growing. In fact, the number of applicants has grown so large and so fast that Human Resources just can't keep up, so they need your help to create an automated way to identify the most promising candidates. In particular, they asked that you create a model that can take a number of predefined inputs and output a probability that a particular candidate will be hired. The good news is IF has hired scores of data scientists, so the dataset is relatively rich. One thing to note is that IF has automated some of their information collecting processes but also relies on human data entry for the remainder. The latter has been a source of error in the past. 

### Features
Below I describe the various features, whether that feature has any importance on the target variable, and if so the likelihood of someone being hired for a specific value of that feature

---
|Feature #|Description|Important|
|:--:|:--:|:--:|
|1|degree|Y|
|2|age|N|
|3|gender|N|
|4|major|N|
|5|GPA|N|
|6|experience|Y|
|7|bootcamp|Y|
|8|GitHub|Y|
|9|blogger|Y|
|10|blogs|N|

---

#### Feature 1 
* description: highest degree achieved
* important: Yes
* values: [(0=no bachelors, 8%), (1=bachelors, 70%), (2=masters, 80%), (3=PhD, 20%)]

#### Feature 2
* description: age
* important: No
* values: [18, 60]

#### Feature 3
* description: gender
* important: No
* values: [0=female, 1=male]

#### Feature 4
* description: major
* important: No
* values: [0=anthropology, 1=biology, 2=business, 3=chemistry, 4=engineering, 5=journalism, 6=math, 7=political science]

#### Feature 5
* description: GPA
* important: No
* values: [1.00, 4.00]

#### Feature 6
* description: years of experience
* important: Yes
* values: [(0-10, 90%), (10-25, 20%), (25-50, 5%)]

#### Feature 7
* description: attended bootcamp
* important: Yes
* values: [(0=No, 25%), (1=Yes, 75%)]

#### Feature 8
* description: number of projects on GitHub
* important: Yes
* values: [(0, 5%), (1-5, 65%), (6-20, 95%)]

#### Feature 9
* description: writes data science blog posts
* important: Yes
* values: [(0=No, 30%), (1=Yes, 70%)]

#### Feature 10
* description: number of blog articles written
* important: No
* values: [0, 20]

### More Details
Without looking at the data, many people would likely assume that a PhD would have better chances of getting hired than someone with a Master's, that a Master's candidate would have better chances of getting hired than someone with a Bachelor's, and so on. This is simply not true in this case. I specifically created this dataset in such a way that people with Bachelor's and Master's degrees are far more likely to get hired than PhD's or those without a degree.

Regarding **age** and **gender**, one may reasonably conjecture that these attributes would have high impact with regard to hiring decisions since this is a well-known bias in many real companies. However, I specifically created this dataset so that hiring decisions were made independently of these two attributes. Again, the goal is to let the data speak for itself, not to rely on intuition. There is an interesting result lurking beneath the surface, however. **Age** is correlated with **experience** so it exhibits some signal, but the true source is *experience*.

One may also assume that **major** and **GPA** are strong predictors. That may be the case at some real-world companies but not in this case. They have no impact whatsoever. Any signal present is purely due to chance.

On the other hand, **years of experience**, **bootcamp experience**, **number of projects on GitHub**, and **blog experience** are all strong predictors. Specifically, the dataset was designed such that candidates with light experience, bootcamp experience, numerous independent GitHub projects, and a data science blog are preferred. Surprisingly perhaps, the number of blog articles one writes is irrelevant. This was by design.

One last thing to note: Whether a candidate was hired is not based on any one of the 5 important features. Rather, five target flags were generated probabilistically based on the values of those features and a simple majority results in being hired. To add a bit more complexity, I randomly flipped 5% of hiring decisions so that learning the hiring decision rule would be more difficult. 
