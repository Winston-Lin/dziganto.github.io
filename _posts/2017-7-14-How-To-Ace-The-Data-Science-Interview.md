---
published: false
categories: [Data Science, Interview]
title: How To Ace The Data Science Interview
---
![Scary Interview](/assets/images/scary-interview.jpg?raw=true){: .center-image }

There's no way around it. Technical interviews can seem harrowing. I would argue nowhere is this more so than in data science. There's just so much to know. 
>What if they ask about Support Vector Machines or boosting or A/B testing? What about SQL? Apache Spark? Maximum likelihood? Poisson regression? Precision vs recall? And on and on and on.

Unfortunately, I'm aware of no magic bullet that'll prepare you for the breadth of questions you'll be up against. Experience is all you'll have to rely upon. However, having interviewed scores of applicants, I can share some insights that will make your interview smoother and your ideas clearer, more succinct, and of the appropriate depth. All of this so that you'll finally stand out among the ever growing crowd. 

Without further ado, here are interviewing tips to make you stand out.

## Tip #1: Use Concrete Examples
This is a simple fix that reframes a complicated idea into one that's easy to follow and grasp. Unfortunately, it's an area where many interviewees go astray, leading to long, rambling, and occassionally nonsensical explanations. Let's look at an example. 

>"Tell me about K-means clustering."

#### Typical Approach
K-means clustering is an unsupervised machine learning algorithm that segments data into groups. It's unsupervised because the data isn't labeled. In other words, there is no ground truth to speak of. Instead, we're trying to extract underlying structure from the data, if indeed it exists. Let me show you what I mean. (draws image on whiteboard)

![Kmeans](/assets/images/kmeans.jpg?raw=true){: .center-image }

The way it works is simple. First, you initialize some centroids. Then you calculate the distance of each data point to each centroid. Each data point gets assigned to its nearest centroid. Once all data points have been assigned, the centroid is moved to the mean position of all the data points within its group. You repeat this process until no points change groups.

#### What Went Wrong?
On the face of it, this is a solid explanation. However, from an interviewer's perspective there are several issues. First, you provided no context. You spoke in generalities and abstractions. This makes your explanation harder to follow. Second, while the whiteboard drawing is helpful, you did not explain the axes, how to choose the number of centroids, how to initialize, and so on. There's so much more information that you could have included. 

#### Better Approach
K-means clustering is an unsupervised machine learning algorithm that segments data into groups. It's unsupervised because the data isn't labeled. In other words, there is no ground truth to speak of. Instead, we're trying to extract underlying structure from the data, if indeed it exists.

Let me give you an example. Say we're an advertising firm. Up to this point we have been showing the same online ad to all viewers of a given website. We think we can be more effective if we can find a way to segment those viewers to send them targeted ads instead. One way to do this is through clustering. We already have a way to capture a viewer's income and age. (draws image on whiteboard)

![Kmeans](/assets/images/kmeans.jpg?raw=true){: .center-image }

The x-axis is *age* and y-axis is *income* in this case. This is a simple 2D case so we can easily visualize the data. This helps us choose the number of clusters (which is the *K* in K-means). It looks like there are two clusters so we will initialize the algorithm with K=2. If visually it wasn't clear how many K to choose or if we were in higher dimensions, we could use inertia or silhouette score to help us hone in on the optimal K value. In this example, we'll randomly inititalize the two centroids, though we could have chosen K++ initialization as well. This is what's depicted in the top left graph.

Distance between each data point to each centroid is calculated and each data point gets assigned to its nearest centroid. Once all data points have been assigned, the centroid is moved to the mean position of all the data points within its group. This is shown in the top right graph. Distances from centroids are again calculated and data points reassigned as depicted in the bottom right graph. The centroids move. See bottom left graph. 

This process repeats until no points change groups. And now we have segmented our viewers so we can show them targeted advertisements.

## Tip #2: Know How To Answer Ambiguous Questions
From the interviewer's perspective, these are some of the most exciting questions to ask. It's something like: 
>"How do you approach classification problems?"

As an interviewee, before I had the chance to sit on the other side of the table, I thought these questions were ill posed. What an overly vague question I would think to myself. What was the point? However, now that I've interviewed scores of applicants, I see the value in this type of question. It shows several things about the interviewee: 
1. how they react on their feet 
2. if they ask probing questions 
3. how they go about attacking a problem

Let's look at a concrete example:
>"I'm trying to classify loan defaults. Which machine learning algorithm should I use and why?"

Admittedly, not much information is provided. That is usually by design. So it makes perfect sense to ask probing questions. The dialogue may go something like this:

**Me:** Tell me more about the data. Specifically, which features are included and how many observations?

**Interviewer:** The features include income, debt, number of accounts, number of missed payments, and length of credit history. This is a big dataset as there are over 100 million customers.

**Me:** So relatively few features but lots of data. Got it. Are there any constraints I should be aware of?

**Interviewer:** I'm not sure. Like what?

**Me:** Well, for starters, what metric are we focused on? Do you care about accuracy, precision, recall, log loss, or something else?

**Interviewer:** That'a great question. We're interested in knowing the probability that someone will default on their loan. 

**Me:** Ok, that's very helpful. Are there any constraints around interpretability of the model and/or the speed of the response from the model?

**Interviewer:** Yes, actually both. The model has to be highly interpretable since we work in a highly regulated industry. Also, customers apply for loans online and we guarantee a response within a few seconds. 

**Me:** So let me just make sure I understand. We've got just a few features with lots of records. Furthermore, our model has to ouptut class probabilities, has to run quickly, and has to be highly interpretable. Is that correct?

**Interviewer:** You've got it!

**Me:** Based on that information, I would recommend a logistic regression model. It outputs class probabilities so we can check that box. Additionally, it's a linear model so it runs much more quickly than lots of other models and it produces coefficients that are relatively easy to interpret. 

The point here is to ask enough pointed questions to get the necessary information you need to make an informed decision. The dialogue may go lot so of different ways but don't hesitate to ask clarifying questions. Get used to it because it's something you'll have to do on a daily basis when you're working as a DS in the wild!

## Tip #3: Choose The Best Algorithm: Accuracy vs Speed vs Interpretability
I covered this implicitly in Tip #2 but any time someone asks you about the merits of using one algorithm over another, the answer almost always boils down to pinpointing which of 1 or 2 of the 3 characteristics - accuracy or speed or interpretability - are most important. Note, it's usually not possible to get all 3 unless you have some trivial problem. I've never been so fortunate. Anyway, some situations will favor accuracy over intrepretability. For example, a deep neural net may outperform a decision tree on a certain problem. The converse can be true as well. There are some circumstances, especially in highly regulated industries like insurance and finance, that prioritize interpretability. In this case, it's completely acceptable to give up some accuracy for a model that's easily interpretable. Of course there are situations where speed is paramount. 

To distill this down, whenever you're answering a question about which algorithm to use, consider the implications of a particular model with regards to accuracy, speed, and intrepretability. Let the constraints around these 3 characteristics drive your decision about which algorithm to use.

## Tip #4: Draw Pictures
