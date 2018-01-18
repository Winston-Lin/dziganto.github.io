---
published: false
title: Model Tuning with Validation & Cross-Validation
categories: [Cross-Validation, Data Science, Machine Learning, Model Tuning, Python]
---

![Comic](/assets/images/cv_image.png?raw=true){: .center-image }

## Introduction
Last time we discussed train error (aka in-sample error), validation or test error (aka out-of-sample error), and train/test split. We learned that training a model on all the available data and then testing on that very same data is an awful way to build models because we have no indication as to how well that model will perform on unseen data. In other words, we don't know if the model is essentially memorizing the data it has seen or if it's truly picking up the pattern inherent in the data (i.e. its ability to generalize). 

To remedy that situation, we implemented train/test split that effectively holds some data aside from the model building process for testing at the very end when the model is fully trained. This allows us to see how the model performs on unseen data. This gives us some indication as to whether the model generalizes or not. 

Now that we have a solid foundation, we can move on to more advanced topics that will take our model-building skills to the next level. Specifically, we'll address the following topics:
* Bias-Variance Tradeoff
* Validation Set
* Model Tuning
* Cross-Validation

To make this concrete, we'll combine theory and application. We'll leverage the Boston dataset in sklearn. 
> Please refer to the [Boston dataset](http://scikit-learn.org/stable/modules/generated/sklearn.datasets.load_boston.html) for details.

Our first step is to read in the data and prep it for modeling. 

## Get & Prep Data
Here's a bit of code to get us going:

```
boston = load_boston()
data = boston.data
target = boston.target
```

And now let's split the data into train/test split like so:

```
# train/test split
X_train, X_test, y_train, y_test = train_test_split(data, 
                                                    target, 
                                                    shuffle=True,
                                                    test_size=0.2, 
                                                    random_state=15)
```

## Setup
We know we'll need to calculate train and validation error, so let's go ahead and create functions to do just that. Let's include a meta-function that will generate a nice report for us. Root Mean Squared Error (RMSE) will be our metric of choice.

```
def calc_train_error(X_train, y_train, model):
    '''returns in-sample error for already fit model.'''
    predictions = model.predict(X_train)
    mse = mean_squared_error(y_train, predictions)
    rmse = np.sqrt(mse)
    return mse
    
def calc_validation_error(X_test, y_test, model):
    '''returns out-of-sample error for already fit model.'''
    predictions = model.predict(X_test)
    mse = mean_squared_error(y_test, predictions)
    rmse = np.sqrt(mse)
    return mse
    
def calc_metrics(X_train, y_train, X_test, y_test, model):
    '''fits model and returns the RMSE for in-sample error and out-of-sample error'''
    model.fit(X_train, y_train)
    train_error = calc_train_error(X_train, y_train, model)
    validation_error = calc_validation_error(X_test, y_test, model)
    return train_error, validation_error
```

Time to dive into a little theory. Stay with it because we'll come back around to the application side where you'll see how all the pieces fit together.

## Theory
### Bias-Variance Tradeoff
Pay very close attention to this section. It is one of the most important concepts in all of machine learning. Understanding this concept will help you diagnose all types of models, be they linear regression, XGBoost, or Convolutional Neural Networks.

We already know how to calculate *train_error* and *validation_error*. So far we've simply been using *validation_error* as a way to gauge how well our model will generalize. That was a good first step but it's not good enough. We can do better. We can tune our model. Let's drill down.

We can compare *train_error* and *validation_error* to figure out what's going on with our model. Depending on the values of each, our model can be in one of three regions:

1) **High Bias** - underfitting  
2) **Goldilocks Zone** - just right (something I made up/not an industry term FYI)  
3) **High Variance** - overfitting

![Bias-Variance Tradeoff](/assets/images/bias-variance-tradeoff.png?raw=true){: .center-image }

#### Plot Orientation
The x-axis represents model complexity. This has to do with how flexible your model is. Some things that add complexity to a model include: additional features, increasing polynomial terms, feature interactions, and greater depth for tree-based models. Keep in mind that's far from an exhaustive list.

The y-axis indicates model error. It's often measured as *Mean-Squared Error (MSE)* for Regression and *Cross-Entropy* or *Accuracy* for Classification. 

The blue curve that only decreases is *Training Error* or what we've been calling train_error. What should be painfully obvious is that adding model complexity leads to smaller and smaller training errors. That's a key finding.

The green curve forms a U-shape. This curve represents *Validation Error*. Notice the trend. First it decreases, hits a minimum, and then increases. We'll talk in more detail about what exactly *Validation Error* is and how to calculate it.

#### High Bias
The rectangular box outlined by dashes to the left and labeled as *High Bias* is the first region of interest. Here you'll notice Training Error and Validation Error are high. You'll also notice that they are close to one another. This region is defined as the one where the model lacks the flexibility required to really pull out the inherent trend in the data. It is *underfitting*, meaning it's doing a poor job all around and won't generalize well. The model doesn't even do well on the training set.

How do you fix this?

By adding model complexity of course. I'll go into much more detail about what to do when you realize you're under or overfitting in another post. For now, assuming you're using Linear Regression, a good place to start is by adding additional features or feature interactions. That addition of parameters to your model allows it flexibility that can move you into the Golidlocks Zone.

#### Goldilocks Zone
The middle region without dashes I've named the Goldilocks Zone. Your model has just the right amount of flexibility to pick up on the pattern inherent in the data but isn't so flexible that it's really just memorizing the training data. This region is marked by Training Error and Validation Error that is both low and close to one another. This is where you want your model to be.

#### High Variance
The dashed rectangular box to the right and labeled *High Variance* is the flip of the High Bias Region. Here, the model has so much flexiblity that it essentially starts to memorize the training data. Not surprisingly, that approach leads to low Training Error. But as was mentioned in the train/test post, a lookup table does not generalize, which is why we see high Validation Error in this region. You know you're in this region when your Training Error is low but your Validation Error is high. Said another way, if there's a sizeable delta between the two, you're overfitting. 

How do you fix this?

By decreasing model complexity. Again, I'll go into much more detail about what exactly to do in another post. For now, consider outright dropping features or adding regularization.

#### Canonical Plot
Let's look at one more plot to drive these ideas home.

![Bias-Variance Target Pic](/assets/images/bias-and-variance-targets.jpg?raw=true){: .center-image }

Imagine you've entered an archery competition. You receive points based on which portion of the target you hit - 0 for the red circle, 1 for the blue, and 2 for the while. The goal is to minimize your score and you do that by hitting as many bullseyes as possible.

The archery metaphor is a useful analog to explain what we're trying to accomplish by building a model. Given different datasets (equivalent to different arrows), we want a model that predicts as close as possible to actual data that's been observed (aka targets). 

The top **Low Bias/Low Variance** portion of the graph represents the ideal case. This is the **Goldilocks Zone**. Our model has extracted all the useful information and generalizes well. We know this because the model is accurate and exhibits little variance, even when predicting on unforeseen data. The model is highly tuned, much like a highly trained archer who can adjust to wind speed, distance, and lighting conditions. 

The **Low Bias/High Variance** portion of the graph represents overfitting. Our model does well from an aggregate perspective on the training data but we see high variance for specific datasets, hence the spread. This is analagous to an archer who has trained under very specific conditions like no wind, the same distance every time, and consistent lighting conditions. Any variation in any of those attributes throws off the archer's accuracy somewhat, though in aggregate he or she is relatively accurate. 

The **High Bias/Low Variance** portion of the graph represent underfitting. Our model does poorly on any given dataset. In fact, it's so bad that it does just about as poorly regardless of the data you feed it, hence the small variance. A rather poor analog is an archer who trained wearing glasses for many years but for some reason had to perform at a competition without them. He or she is far from accurate but consistently so. 

The **High Bias/High Variance** portion of the graph actually has no analog in machine learning. There exists a tradeoff between bias and variance. Therefore, I'm not aware of a situtation where both can be high. 

