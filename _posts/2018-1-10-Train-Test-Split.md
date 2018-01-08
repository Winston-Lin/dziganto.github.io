---
published: false
title: Train-Test Split
categories: [Data Science, Machine Learning, Python]
---

![image](/assets/images/train_test_split.jpeg?raw=true){: .center-image }

## Introduction
Building a model is simple but assessing your model and tuning it require care and proper technique. Unfortunately, this is a place where novice modelers make disastrous mistakes. So while this topic is not as exciting as a shiny new algorithm, it is nonetheless extraordinarily important. You must know this inside and out. There's no two ways about it.

Let's motivate the discussion with a real-world example.

The [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/index.php) contains many wonderful datasets that you can download and experiment on. Datasets usually come with at least some description. Furthermore, the datasets are grouped according to a number of attributes like Classification, Regression, Clustering or Multivariate, Time Series, Text. It really is a great resource to hone your modeling skills.

Anyway, for the purposes of this demonstration, we'll use the [Forest Fires](http://archive.ics.uci.edu/ml/datasets/Forest+Fires) dataset.

The task is this: predict the burned area of forest fires, in the northeast region of Portugal, by using meteorological and other data.

A bit of information about the features:
1. X - x-axis spatial coordinate within the Montesinho park map: 1 to 9 
2. Y - y-axis spatial coordinate within the Montesinho park map: 2 to 9 
3. month - month of the year: 'jan' to 'dec' 
4. day - day of the week: 'mon' to 'sun' 
5. FFMC - FFMC index from the FWI system: 18.7 to 96.20 
6. DMC - DMC index from the FWI system: 1.1 to 291.3 
7. DC - DC index from the FWI system: 7.9 to 860.6 
8. ISI - ISI index from the FWI system: 0.0 to 56.10 
9. temp - temperature in Celsius degrees: 2.2 to 33.30 
10. RH - relative humidity in %: 15.0 to 100 
11. wind - wind speed in km/h: 0.40 to 9.40 
12. rain - outside rain in mm/m2 : 0.0 to 6.4 
13. area - the burned area of the forest (in ha): 0.00 to 1090.84 

Ok, let's get the data, clean it up, and then build a Linear Regression model.

#### Get Data
```
import pandas as pd

url = 'http://archive.ics.uci.edu/ml/machine-learning-databases/forest-fires/forestfires.csv'
df = pd.read_csv(url)
df.head()
```

The output looks like this:
```
X	Y	month	day	FFMC	DMC	  DC	  ISI	 temp	 RH	 wind	 rain	 area
7	5	 mar	fri	86.2	26.2	94.3	5.1	 8.2	 51	 6.7	 0.0	 0.0
7	4	 oct	tue	90.6	35.4	669.1	6.7	 18.0	 33	 0.9	 0.0	 0.0
7	4	 oct	sat	90.6	43.7	686.9	6.7	 14.6	 33	 1.3	 0.0	 0.0
8	6	 mar	fri	91.7	33.3	77.5	9.0	 8.3	 97	 4.0	 0.2	 0.0
8	6	 mar	sun	89.3	51.3	102.2	9.6	 11.4	 99	 1.8	 0.0	 0.0
```

Right away we see a problem. The columns *month* and *day* are coded as text, not numbers. This is a problem for our Linear Regression model. We need to convert those categorical features. There are many ways to do this but for the purposes of Linear Regression we are going to do something called one-hot encoding. What this does is take a single categorical feature like day, which consists of Sunday through Saturday, and splits it into numerous indicator features. Specifically, a column will be created for each day of the week in this example. So one column will parse into seven. 

You may be wondering how many columns result from one-hot encoding. It's simply the number of categories within a feature. Of course you can one-hot encode multiple categorical features. Just keep in mind that your data matrix can expand wide very quickly using this schema. 

#### Clean Data
Pandas has a very nice method called *get_dummies* that will one-hot encode the categorical features for us automatically. It'll even delete the original feature, which is a nice touch. Here we go!
```
df = pd.get_dummies(df)
```

We can look at the columns by typing `df.columns`. The result is:
```
Index(['X', 'Y', 'FFMC', 'DMC', 'DC', 'ISI', 'temp', 'RH', 'wind', 'rain',
       'area', 'month_apr', 'month_aug', 'month_dec', 'month_feb', 'month_jan',
       'month_jul', 'month_jun', 'month_mar', 'month_may', 'month_nov',
       'month_oct', 'month_sep', 'day_fri', 'day_mon', 'day_sat', 'day_sun',
       'day_thu', 'day_tue', 'day_wed'],
       dtype='object')
```

Something should worry you very much at this point. If it doesn't, go back and look at the columns again. Think it through before I give you the answer. There's a crucial problem we need to address. Can you spot it?

**Spoiler Alert:** I'm going to tell you what's wrong. I hope you spotted it yourself.

Think about what's happening for the day of week indicator features. We have a column for each day of the week. They can only take values of 0 or 1, indicating if a fire occurred on that given day. The features are mutually exclusive meaning there can only be a 1 in one of the columns. All the rest have to be 0 because it's impossible for the same day to be both Monday and Thursday, for example. 

Ok, so what's the problem?

Think about the coding. Common convention states a week starts on Sunday. So we have features for Sunday through Saturday. But I don't need an indicator feature for Saturday. That's already encoded implicity when Sunday=0, Monday=0, Tuesday=0, Wednesday=0, Thursday=0, and Friday=0. If you're up on your linear algebra you realize that adding Saturday causes linear dependence, which is a no-no for Linear Regression which assumes independent features. Therefore, we **must** drop one column of each one-hot encoded feature. In this case we need to drop one column from month and one from day of week. Then we'll be in good shape. We do that with this bit of code: `df.drop(labels=['month_dec', 'day_sat'], axis=1, inplace=True)`

It's always worthwhile to check the range of values for each feature. That's as simple as `df.max() - df.min()`.

The result is:
```
X               8.00
Y               7.00
FFMC           77.50
DMC           290.20
DC            852.70
ISI            56.10
temp           31.10
RH             85.00
wind            9.00
rain            6.40
area         1090.84
month_apr       1.00
month_aug       1.00
month_feb       1.00
month_jan       1.00
month_jul       1.00
month_jun       1.00
month_mar       1.00
month_may       1.00
month_nov       1.00
month_oct       1.00
month_sep       1.00
day_fri         1.00
day_mon         1.00
day_sun         1.00
day_thu         1.00
day_tue         1.00
day_wed         1.00
```

Some of the variables have relatively high variance, like *DMC* and *DC*, whereas others are constrained between 0 and 1, like day of week. Linear Regression can adjust with the magnitude of its coefficients, but it's really good practice to normalize or standardize first, especially when we use regularization or Gradient Descent. We won't normalize/standardize here. You'll understand why shortly. 

For now let's pretend we're in good shape. Let's model.

#### Fit Model
```
data = df.copy()
target = data.pop('area')

lr = LinearRegression(fit_intercept=True)
lr.fit(data, target)
```
