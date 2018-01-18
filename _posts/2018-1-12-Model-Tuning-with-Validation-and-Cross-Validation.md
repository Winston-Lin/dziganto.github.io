---
published: false
title: Model Tuning with Validation & Cross-Validation
categories: [Cross-Validation, Data Science, Machine Learning, Model Tuning, Python]
---

![image](/assets/images/cv_image.png?raw=true){: .center-image }

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

