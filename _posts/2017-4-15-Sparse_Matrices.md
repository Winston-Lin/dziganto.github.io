![Image of Binary](/assets/images/binary-number-tunnel.jpg?raw=true)

# Introduction
Sparse matrices are common in machine learning. While they occur naturally in some data collection processes, more often they arise when applying certain data transformation techniques like:

- [One-hot encoding](http://scikit-learn.org/stable/modules/generated/sklearn.preprocessing.OneHotEncoder.html) categorical variables
- [CountVectorizer](http://scikit-learn.org/stable/modules/generated/sklearn.feature_extraction.text.CountVectorizer.html) for NLP
- [TfidfVectorizer](http://scikit-learn.org/stable/modules/generated/sklearn.feature_extraction.text.TfidfVectorizer.html) for NLP

Let's step back for a second. Just what the heck is a sparse matrix and how is it different than other matrices? Turns out there are two major types of matrices: dense and sparse. Dense matrices are composed primarily of non-zero values. Sparse matrices, on the other hand, are composed primarily of zero values. Here is a side-by-side comparison:

