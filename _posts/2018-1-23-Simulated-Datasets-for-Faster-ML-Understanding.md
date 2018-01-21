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

Great, so now we have all that background behind us which means it's time to actually generate the data. 

## Generate Data
There are many ways to efficiently create datasets using NumPy and Pandas. I tried to keep things simple and understandable, not necessarily efficient. Please bare with me here. 

```
import numpy as np
import pandas as pd

# reproducibility
np.random.seed(10)

# number of observations
size = 5000

# feature setup
degree = np.random.choice(a=range(4), size=size)
age = np.random.choice(a=range(18,61), size=size)
gender = np.random.choice(a=range(2), size=size)
major = np.random.choice(a=range(8), size=size)
gpa = np.round(np.random.normal(loc=2.90, scale=0.5, size=size), 2)
experience = None  
bootcamp = np.random.choice(a=range(2), size=size)
github = np.random.choice(a=range(21), size=size)
blogger = np.random.choice(a=range(2), size=size)
articles = 0  
t1, t2, t3, t4, t5 = None, None, None, None, None
hired = 0
```

Now to create a pandas dataframe.

```
mydict = {"degree":degree, "age":age, 
          "gender":gender, "major":major, 
          "gpa":gpa, "experience":experience, 
          "github":github, "bootcamp":bootcamp, 
          "blogger":blogger, "articles":articles,
          "t1":t1, "t2":t2, "t3":t3, "t4":t4, "t5":t5, "hired":hired}

df = pd.DataFrame(mydict,
                  columns=["degree", "age", "gender", "major", "gpa", 
                           "experience", "bootcamp", "github", "blogger", "articles",
                           "t1", "t2", "t3", "t4", "t5", "hired"])
```

We're not quite there yet. We still need to update some columns. Here's an inefficient but hopefully understandable way to do that:

```
np.random.seed(42)

for i, _ in df.iterrows(): 
    
    # Constrain GPA
    if df.loc[i, 'gpa'] < 1.00 or df.loc[i, 'gpa'] > 4.00:
        if df.loc[i, 'gpa'] < 1.00:
            df.loc[i, 'gpa'] = 1.00
        else:
            df.loc[i, 'gpa'] = 4.00
    
    # Set experience based on age
    df.loc[i, 'experience'] = np.random.choice(a=range(0, df.loc[i, 'age']-17))    
    
    # Set number of articles if blogger flag
    if df.loc[i, 'blogger']:
        df.loc[i, 'articles'] = np.random.choice(a=range(1, 21), size=1) 
    
    # Set target flags
    for feature in ['degree', 'experience', 'bootcamp', 'github', 'blogger']:
        if feature == 'degree':  
            if df.loc[i, feature] == 0:
                df.loc[i, 't1'] = int(np.random.choice(a=range(2), size=1, p=[0.92, 0.08])) ## no bachelors
            elif df.loc[i, feature] == 1:
                df.loc[i, 't1'] = int(np.random.choice(a=range(2), size=1, p=[0.30, 0.70])) ## bachelors
            elif df.loc[i, feature] == 2:
                df.loc[i, 't1'] = int(np.random.choice(a=range(2), size=1, p=[0.20, 0.80])) ## masters
            else:
                df.loc[i, 't1'] = int(np.random.choice(a=range(2), size=1, p=[0.80, 0.20])) ## PhD
        elif feature == 'experience':
            if df.loc[i, feature] <= 10:
                df.loc[i, 't2'] = int(np.random.choice(a=range(2), size=1, p=[0.10, 0.90])) ## <= 10 yrs exp
            elif df.loc[i, feature] <= 25:
                df.loc[i, 't2'] = int(np.random.choice(a=range(2), size=1, p=[0.80, 0.20])) ## 11-25 yrs exp
            else:
                df.loc[i, 't2'] = int(np.random.choice(a=range(2), size=1, p=[0.95, 0.05])) ## >= 26 yrs exp
        elif feature == 'bootcamp':
            if df.loc[i, feature]:
                df.loc[i, 't3'] = int(np.random.choice(a=range(2), size=1, p=[0.25, 0.75])) ## bootcamp
            else:
                df.loc[i, 't3'] = int(np.random.choice(a=range(2), size=1, p=[0.50, 0.50])) ## no bootcamp
        elif feature == 'github':
            if df.loc[i, feature] == 0:
                df.loc[i, 't4'] = int(np.random.choice(a=range(2), size=1, p=[0.95, 0.05])) ## 0 projects
            elif df.loc[i, feature] <= 5:
                df.loc[i, 't4'] = int(np.random.choice(a=range(2), size=1, p=[0.35, 0.65])) ## 1-5 projects
            else:
                df.loc[i, 't4'] = int(np.random.choice(a=range(2), size=1, p=[0.05, 0.95])) ## > 5 projects
        else:
            if df.loc[i, feature]:
                df.loc[i, 't5'] = int(np.random.choice(a=range(2), size=1, p=[0.30, 0.70])) ## blogger
            else:
                df.loc[i, 't5'] = int(np.random.choice(a=range(2), size=1, p=[0.50, 0.50])) ## !blogger
    
    # Set hired value
    if (df.loc[i, 't1'] + df.loc[i, 't2'] + df.loc[i,'t3'] + df.loc[i,'t4'] + df.loc[i, 't5']) >= 3:
        df.loc[i, 'hired'] = 1
```

The big takeaway is the last *if* statement. That's where the target variable (aka *hired*) is set. This is the generative process. It simply states that if the temporary flag variable t1-t5 sum to at least three, then set hired equal to one, otherwise zero. It's a simple decision based on a simple summation - probably not too far off of many real hiring decisions!

It's worthwhile to apply just a bit more processing. Specifically, we want to remove those temporary flag variables t1-t5 and convert *experience* from an object type to numeric.

```
# Drop target flags        
df.drop(df[['t1', 't2', 't3', 't4', 't5']], axis=1, inplace=True)

# Set 'experience' to numeric (was object type)
df['experience'] = df['experience'].apply(pd.to_numeric)
```

Great, we're almost there. We just need to add the last bit of complexity where we flip a few hiring decisions. Again, the aim is not efficiency but ease of understanding here.

```
np.random.seed(15)

percent_to_flip = 0.03  ## % of hired values to flip
num_to_flip = int(np.floor(percent_to_flip * len(df)))  ## determine number of hired values to flip
flip_idx = np.random.randint(low=0, high=len(df), size=num_to_flip)  ## randomly select indices

for i, _ in df.loc[flip_idx].iterrows(): 
    if df.loc[i, 'hired'] == 1:
        df.loc[i, 'hired'] = 0
    else:
        df.loc[i, 'hired'] = 1
```
## Wrap Up
We covered lots of ground already. I introduced the idea of generating your own datasets from scratch. This process is known as simulating datasets. The reason for doing this is simple: You want to truly understand the generative process so you can apply various Exploratory Data Analysis (EDA) and machine learning techniques for the express purposes of building your intuition into which techniques work best on different types of data. That easily takes you from novice to expert and all it requires is a little time and practice.

Next time we'll dig a bit deeper into the data. We'll apply some basic EDA and then round out the discussion with a few traditional machine learning models to understand a bit better why one performs better than another. 
