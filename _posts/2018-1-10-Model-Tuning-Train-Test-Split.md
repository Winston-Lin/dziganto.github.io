---
published: true
title: Model Tuning (Part 1 - Train/Test Split)
categories: [Data Science, Machine Learning, Model Tuning, Python]
---

![image](/assets/images/train_test_split.jpeg?raw=true){: .center-image }

## Introduction
Building a model is simple but assessing your model and tuning it require care and proper technique. Unfortunately, this is a place where novice modelers make disastrous mistakes. So while this topic is not as exciting as say deep learning, it is nonetheless extraordinarily important. You really must know this inside and out. 

Let's motivate the discussion with a real-world example.

The [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/index.php) contains many wonderful datasets that you can download and experiment on. Datasets usually come with at least some description. Furthermore, the datasets are grouped according to a number of attributes like *Classification*, *Regression*, *Clustering*, *Time Series*, or *Text*. It really is a great resource to hone your modeling skills.

Anyway, for the purposes of this demonstration, we'll use the [Forest Fires](http://archive.ics.uci.edu/ml/datasets/Forest+Fires) dataset.

The task is this: Predict the area burned by forest fires in the northeast region of Portugal by using meteorological and other data.

A bit of information about the features:
1. **X** - x-axis spatial coordinate within the Montesinho park map: 1 to 9 
2. **Y** - y-axis spatial coordinate within the Montesinho park map: 2 to 9 
3. **month** - month of the year: 'jan' to 'dec' 
4. **day** - day of the week: 'mon' to 'sun' 
5. **FFMC** - FFMC index from the FWI system: 18.7 to 96.20 
6. **DMC** - DMC index from the FWI system: 1.1 to 291.3 
7. **DC** - DC index from the FWI system: 7.9 to 860.6 
8. **ISI** - ISI index from the FWI system: 0.0 to 56.10 
9. **temp** - temperature in Celsius degrees: 2.2 to 33.30 
10. **RH** - relative humidity in %: 15.0 to 100 
11. **wind** - wind speed in km/h: 0.40 to 9.40 
12. **rain** - outside rain in mm/m2 : 0.0 to 6.4 
13. **area** - the burned area of the forest (in ha): 0.00 to 1090.84 

Ok, let's get the data, clean it up, and then build a linear regression model.

### Get Data
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

Right away we're confronted with a problem. The columns *month* and *day* are coded as text, not numbers. This is a problem for our linear regression model that only understands numbers. We need to convert those categorical features. There are many ways to do this but for the purposes of linear regression we are going to do something called *one-hot encoding*. What this does is it takes a single categorical feature like day, which consists of Sunday, Monday, and so on, and splits it into numerous indicator features. Specifically, a column will be created for each day of the week in this example. So one column will parse into seven. 

You may be wondering how many columns result from one-hot encoding. It's simply the number of categories within a feature. 
> **Technical note:** You can one-hot encode multiple categorical features. Just keep in mind that your data matrix can expand in width very quickly using this approach. That may or not be a problem for you depending on a number of factors like which machine learning algorithm you plan to use, memory constraints, and so on.

### Clean Data
Pandas has a very nice method called *get_dummies* that will one-hot encode the categorical features for us automatically. It'll even delete the original feature, which is a nice touch. Here we go!
```
df = pd.get_dummies(df)
```

We can look at the columns by typing `df.columns`. The result looks like:
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

Think about the coding. Common convention states a week starts on Sunday. So we have features for Sunday through Saturday. But I don't need an indicator feature for Saturday. That's already encoded implicity when Sunday=0, Monday=0, Tuesday=0, Wednesday=0, Thursday=0, and Friday=0. If you're up on your linear algebra, you realize that adding Saturday causes linear dependence, which is a no-no for linear regression which assumes independent features. Therefore, we **must** drop one column of each one-hot encoded feature. In this case we need to drop one column from *month* and one from *day* - it doesn't matter which specific month and which specific day we choose. Then we'll be in good shape. We do that with this bit of code: `df.drop(labels=['month_dec', 'day_sat'], axis=1, inplace=True)`

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

Some of the variables have relatively high variance, like *DMC* and *DC*, whereas others are constrained between 0 and 1, like day of week. Linear regression can adjust to this variance with the magnitude of its coefficients, but it's really good practice to normalize or standardize first. If you leverage *regularization* or *Gradient Descent*, you must normalize/standardize. We won't normalize/standardize here. You'll understand why shortly. 

For now let's pretend we're in good shape. On to the modeling.

### Fit Model
```
from sklearn.linear_model import LinearRegression

data = df.copy()
target = data.pop('area')

lr = LinearRegression(fit_intercept=True)
lr.fit(data, target)
```

### How'd we do?
Let's look at R^2 and Root Mean Squared Error (RMSE) to see how our model performed. 
```
from sklearn.metrics import mean_squared_error

# R^2
print(lr.score(data, target)) 

predictions = lr.predict(data)
mse = mean_squared_error(target, predictions)
rmse = np.sqrt(mse)
print(rmse)
```

Which returns, respectively:
```
0.045782096508085179

62.121433117927239
```

### Interpretation
Right away we can see the R^2 is abysmal. It's really not too surprising because if you look at the documentation on UCI you'll notice that the target variable is highly skewed with several high leverage points. This is worthy of investigation and could yield substantial performance gains. Review SSE, SST, and R^2 if you're unclear as to why.

The RMSE is a measure of how far off on average our model is from ground truth. I'm using the term *average* loosely here because it's really the average square root of the squared residuals. Yikes, that's a mouthful. Said another way, it's one way to measure the magnitude of errors, though it's not the only one. Mean Absolute Error (MAE) is another. The two measures will give you different answers, so you should ponder on that.

But here's the thing: our model is rubbish no matter what. We could have had an R^2 approaching 1 or an RMSE close to 0 but that's totally and completely meaningless in the real-world. We have no idea how this model would generalize to data it hasn't seen. We merely have a measure of how well it's doing on the data it sees. This is a major problem for predictive analytics. You can have what seems like an incredible model but then you unleash it in the wild and it performs poorly. Understanding why this is the case is absolutely essential.

## Why This Model Sucks
In the most extreme case, I can create a model that is really a lookup table. You give me an input and I give you the output. Another way to say this is take a model and let it memorize the data it can see. The result: an R^2 of 1 and an RMSE of 0. 

Clearly, nobody thinks that's a great model. The point of building a model is to predict something interesting. You can't do that with a lookup table. Yet, that's exactly how we tried to assess our linear regression model above - give it some data and then see how well it does predicting that SAME data. That's why it's rubbish. PLEASE DO NOT EVER DO THIS!

What we've done is look at something called *in-sample error* (ISE) or *train error*. It is a useful metric but only tells half the story. 

## Out-of-Sample Error
The other half of the story is something called *out-of-sample error*, which I'll denote henceforth as *OSE* or *test error*. Simply put, OSE or test error is how well the model performs on data it's never seen. 

But where do we get this data? 

Easy, holdout some data at the beginning. Don't let the model see during the modeling phase. Once you're happy with your model, make predictions on the unseen data and see how well it performs. This gives you an indication as to how well your model will do in the wild.

This process we just discussed is called *train/test split*. You determine how much data to holdout at the beginning, split the data into a training dataset and a test dataset, model on the training set, and then calculate train error and test error.

Let's see how to do this with Sklearn.

### Train/Test Split
```
from sklearn.model_selection import train_test_split

X_train, X_test, y_train, y_test = train_test_split(data, target, shuffle=True,
                                                    test_size=0.5, random_state=49)
```

### Fit Model on Training Data
```
lr_split = LinearRegression(fit_intercept=True)
lr_split.fit(X_train, y_train)
```

### Functions to Calculate ISE and OSE
```
def calc_ISE(X_train, y_train, model):
    '''returns the in-sample R^2 and RMSE; assumes model already fit.'''
    predictions = lr.predict(X_train)
    mse = mean_squared_error(y_train, predictions)
    rmse = np.sqrt(mse)
    return model.score(X_train, y_train), rmse
    
def calc_OSE(X_test, y_test, model):
    '''returns the out-of-sample R^2 and RMSE; assumes model already fit.'''
    predictions = lr.predict(X_test)
    mse = mean_squared_error(y_test, predictions)
    rmse = np.sqrt(mse)
    return model.score(X_test, y_test), rmse
```

### Calculate In-Sample and Out-of-Sample R^2 and Error
```
is_r2, ise = calc_ISE(X_train, y_train, lr_split)
os_r2, ose = calc_OSE(X_test, y_test, lr_split)

# show dataset sizes
data_list = (('R^2_in', is_r2), ('R^2_out', os_r2), 
             ('ISE', ise), ('OSE', ose))
for item in data_list:
    print('{:10}: {}'.format(item[0], item[1]))
```

The output is:
```
R^2_in     : 0.07513974961762804
R^2_out   : -0.005167798223800313
ISE       : 27.50204577364648
OSE       : 83.36547731820247
```

### Interpretation
We can see that the in-sample R^2 is pretty low but what's interesting here is that the out-of-sample R^2 is lower. In fact, it's slightly below zero. Even more telling is the RMSE values. The RMSE for the data the model saw (ISE or train error) is significantly lower (by a factor of 3) than the RMSE for the data the model has never seen (OSE or test error). In machine learning speak our model is *overfitting*, meaning it's doing a much better job on the data it has seen. In other words, the trained model does not generalize well. The greater the gap between between train error and test error, the greater the overfitting. You can equate overfitting with memorizing the data. It becomes more and more like creating a lookup table.

So the big takeaway here is that you *must* calculate train error and test error to get an accurate picture as to how your model is doing. This necessiates holding out some data at the beginning so you can test your model on data it's never seen. I showed you show to do that with sklearn's *train_test_split*. 

Now you may be wondering how to address overfitting. To fully understand that, we need to discuss something called the **Bias-Variance Tradeoff**, which is a topic for another post. For now, understanding what overfitting is and knowing it's a problem is a big first step.

Before we wrap up, there's one more subtle item we need to address: The downside of *train/test split*.

## Downside of Train/Test Split
I just told you that train/test split gives you both sides of the story - how well your model performs on data it's seen and data it hasn't. That's true to an extent but there's something subtle you need to be aware of. Let me show you by example. Let's try a few different train/test splits and check train error and test error values.

### Multiple Train/Test Splits
```
# create array of random_state values
random_states = np.random.randint(1, 100, size=5)
random_states

for random_state in random_states:
    # split data according to random state
    X_train, X_test, y_train, y_test = train_test_split(data, target, 
                                                        shuffle=True,
                                                        test_size=0.5, 
                                                        random_state=random_state)
    # instantiate mmodel
    lr = LinearRegression(fit_intercept=True)
    # fit model
    lr.fit(X_train, y_train)
    # capture key metrics
    is_r2, ise = calc_ISE(X_train, y_train, lr)
    os_r2, ose = calc_OSE(X_test, y_test, lr)
    # round values
    is_r2, os_r2 = round(is_r2, 4), round(os_r2, 4)
    ise, ose = round(ise, 4), round(ose, 4)
    
    # print key metrics
    print('Random State: {}'.format(random_state))
    print('IS_R^2: {} | IS_RMSE: {}'.format(is_r2, ise))
    print('OS_R^2: {} | OS_RMSE: {}'.format(os_r2, ose))
    print('-'*34)
```

Output looks like this:
```
Random State: 93
IS_R^2: 0.0747 | IS_RMSE: 82.3296
OS_R^2: -0.6624 | OS_RMSE: 35.326
----------------------------------
Random State: 98
IS_R^2: 0.1051 | IS_RMSE: 51.0612
OS_R^2: -0.0676 | OS_RMSE: 74.2931
----------------------------------
Random State: 61
IS_R^2: 0.075 | IS_RMSE: 83.5672
OS_R^2: -1.3045 | OS_RMSE: 34.0928
----------------------------------
Random State: 45
IS_R^2: 0.0865 | IS_RMSE: 71.3173
OS_R^2: -0.193 | OS_RMSE: 54.8203
----------------------------------
Random State: 75
IS_R^2: 0.0793 | IS_RMSE: 80.9714
OS_R^2: -0.7537 | OS_RMSE: 41.286
----------------------------------
```

### Takeaways
* R^2 is always higher in-sample as opposed to out-of-sample
* RMSE show great variability in-sample vs out-of-sample

### Discussion
It's no surprise that R^2 is higher in-sample. The surprise here is RMSE. What's particularly interesting is that sometimes train error is higher than test error and sometimes it's the other way around. This is a small dataset so the skewed distribution in the target variable is having major consequences. A much larger dataset would still be affected but to a considerably smaller degree. With that in mind, you'll almost always see train errors that are higher than test error. If not, there's something funky going on in your data like we have here. It's a red flag to keep in mind. Anyway, we get very different results depending on how we split the data. In this case, I didn't change the proportion of data that's selected, merely how it's split. So that's good to know. How you split can dramatically affect your model. In some cases it generalizes well and other times it doesn't. 

An obvious question you're probably asking is how do I best split my data? Trial and error?

No, there's a better method. For large datasets, it's called train/validation/test split and for small to medium-sized datasets, it's called Cross-Validation. We'll pickup that discussion next time.
