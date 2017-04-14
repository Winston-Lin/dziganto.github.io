---
permalink: /posts/
---

![Image of Binary](/assets/images/binary-number-tunnel.jpg?raw=true)

# Introduction
Sparse matrices are common in machine learning. While they occur naturally in some data collection processes, more often they arise when applying certain data transformation techniques like:

- [One-hot encoding](http://scikit-learn.org/stable/modules/generated/sklearn.preprocessing.OneHotEncoder.html) categorical variables
- [CountVectorizer](http://scikit-learn.org/stable/modules/generated/sklearn.feature_extraction.text.CountVectorizer.html) for NLP
- [TfidfVectorizer](http://scikit-learn.org/stable/modules/generated/sklearn.feature_extraction.text.TfidfVectorizer.html) for NLP

Let's step back for a second. Just what the heck is a sparse matrix and how is it different than other matrices? Turns out there are two major types of matrices: dense and sparse. Sparse matrices have lots of zero values. Dense matrices do not. Here is a side-by-side comparison:

[Insert Images]

Now for the punchline. Because sparse matrices have lots of zero values, we can apply special algorithms that will do two important things:

1. **compress the memory footprint of our matrix object**  
2. **speed up many machine learning routines**

Data compression minimizes the amount of data we need to store. That is not the only benefit, however. Users of [sklearn](http://scikit-learn.org/stable/index.html) will note that all native machine learning algorithms operate on objects that are in-memory. Said another way, the machine learning process breaks down when a matrix object (usually called a dataframe) does not fit into RAM. In the event that we have a sparse matrix, storing all those zero values is a waste. In many cases it is possible to compress the matrix object so that it can fit in RAM.

Additionally, consider multiplying a sparse matrix and a dense matrix. Even though the sparse matrix has many zeros, and zero times anything is always zero, the standard approach requires this pointless operation nonetheless. The result is slowed computation time. It is much more efficient to only operate on elements that will return non-zero values. Therefore, any algorithm that applies some basic mathematical computation like multiplication will benefit from a sparse matrix implementation.

Sklearn has many algorithms that accept sparse matrices. The way to know is by checking the *fit* attribute in the documentation. Look for this: **X: {array-like, sparse matrix}**. 

At the time of this writing, the following sklearn 0.18.1 algorithms accept sparse matrices:

- Classification
  - [Logistic Regression](http://scikit-learn.org/stable/modules/generated/sklearn.linear_model.LogisticRegression.html#sklearn.linear_model.LogisticRegression)
  - [SGDClassifier](http://scikit-learn.org/stable/modules/generated/sklearn.linear_model.SGDClassifier.html#sklearn.linear_model.SGDClassifier)
  - [Perceptron](http://scikit-learn.org/stable/modules/generated/sklearn.linear_model.Perceptron.html#sklearn.linear_model.Perceptron)
  - [PassiveAggressiveClassifier](http://scikit-learn.org/stable/modules/generated/sklearn.linear_model.PassiveAggressiveClassifier.html#sklearn.linear_model.PassiveAggressiveClassifier)
  - [NuSVC](http://scikit-learn.org/stable/modules/generated/sklearn.svm.NuSVC.html#sklearn.svm.NuSVC)
  - [LinearSVC](http://scikit-learn.org/stable/modules/generated/sklearn.svm.LinearSVC.html#sklearn.svm.LinearSVC)
  - [SVC](http://scikit-learn.org/stable/modules/generated/sklearn.svm.SVC.html#sklearn.svm.SVC)
  - [KNeighborsClassifier](http://scikit-learn.org/stable/modules/generated/sklearn.neighbors.KNeighborsClassifier.html#sklearn.neighbors.KNeighborsClassifier)
  - [RadiusNeighborsClassifier](http://scikit-learn.org/stable/modules/generated/sklearn.neighbors.RadiusNeighborsClassifier.html#sklearn.neighbors.RadiusNeighborsClassifier)
  - [NearestCentroid](http://scikit-learn.org/stable/modules/generated/sklearn.neighbors.NearestCentroid.html#sklearn.neighbors.NearestCentroid)
  - [MultinomialNB](http://scikit-learn.org/stable/modules/generated/sklearn.naive_bayes.MultinomialNB.html#sklearn.naive_bayes.MultinomialNB)
  - [BernoulliNB](http://scikit-learn.org/stable/modules/generated/sklearn.naive_bayes.BernoulliNB.html#sklearn.naive_bayes.BernoulliNB)
  - [DecisionTreeClassifier](http://scikit-learn.org/stable/modules/generated/sklearn.tree.DecisionTreeClassifier.html#sklearn.tree.DecisionTreeClassifier)
  - [BaggingClassifier](http://scikit-learn.org/stable/modules/generated/sklearn.ensemble.BaggingClassifier.html#sklearn.ensemble.BaggingClassifier)
  - [RandomForestClassifier](http://scikit-learn.org/stable/modules/generated/sklearn.ensemble.RandomForestClassifier.html#sklearn.ensemble.RandomForestClassifier)
  - [ExtraTreesClassifier](http://scikit-learn.org/stable/modules/generated/sklearn.ensemble.ExtraTreesClassifier.html#sklearn.ensemble.ExtraTreesClassifier)
  - [AdaBoostClassifier](http://scikit-learn.org/stable/modules/generated/sklearn.ensemble.AdaBoostClassifier.html#sklearn.ensemble.AdaBoostClassifier)
  - [VotingClassifier](http://scikit-learn.org/stable/modules/generated/sklearn.ensemble.VotingClassifier.html)
  - [OneVsRestClassifier](http://scikit-learn.org/stable/modules/generated/sklearn.multiclass.OneVsRestClassifier.html#sklearn.multiclass.OneVsRestClassifier)
  - [OneVsOneClassifier](http://scikit-learn.org/stable/modules/generated/sklearn.multiclass.OneVsOneClassifier.html#sklearn.multiclass.OneVsOneClassifier)
  - [OutputCodeClassifier](http://scikit-learn.org/stable/modules/generated/sklearn.multiclass.OutputCodeClassifier.html#sklearn.multiclass.OutputCodeClassifier)
  - [MultiOutputClassifier](http://scikit-learn.org/stable/modules/generated/sklearn.multioutput.MultiOutputClassifier.html)
  - [MLPClassifier](http://scikit-learn.org/stable/modules/generated/sklearn.neural_network.MLPClassifier.html#sklearn.neural_network.MLPClassifier)
  
- Regression
  - [Linear Regression](http://scikit-learn.org/stable/modules/generated/sklearn.linear_model.LinearRegression.html#sklearn.linear_model.LinearRegression)
  - [Ridge Regression](http://scikit-learn.org/stable/modules/generated/sklearn.linear_model.Ridge.html#sklearn.linear_model.Ridge)
  - [Lasso Regression](http://scikit-learn.org/stable/modules/generated/sklearn.linear_model.Lasso.html#sklearn.linear_model.Lasso)
  - [ElasticNet](http://scikit-learn.org/stable/modules/generated/sklearn.linear_model.ElasticNet.html#sklearn.linear_model.ElasticNet)
  - [SGDRegressor](http://scikit-learn.org/stable/modules/generated/sklearn.linear_model.SGDRegressor.html#sklearn.linear_model.SGDRegressor)
  - [PassiveAggressiveRegressor](http://scikit-learn.org/stable/modules/generated/sklearn.linear_model.PassiveAggressiveRegressor.html#sklearn.linear_model.PassiveAggressiveRegressor)
  - [RANSACRegressor](http://scikit-learn.org/stable/modules/generated/sklearn.linear_model.RANSACRegressor.html#sklearn.linear_model.RANSACRegressor)
  - [KernelRidge](http://scikit-learn.org/stable/modules/generated/sklearn.kernel_ridge.KernelRidge.html#sklearn.kernel_ridge.KernelRidge)
  - [SVR](http://scikit-learn.org/stable/modules/generated/sklearn.svm.SVR.html#sklearn.svm.SVR)
  - [NuSVR](http://scikit-learn.org/stable/modules/generated/sklearn.svm.NuSVR.html#sklearn.svm.NuSVR)
  - [LinearSVR](http://scikit-learn.org/stable/modules/generated/sklearn.svm.LinearSVR.html#sklearn.svm.LinearSVR)
  - [KNeighborsRegressor](http://scikit-learn.org/stable/modules/generated/sklearn.neighbors.KNeighborsRegressor.html#sklearn.neighbors.KNeighborsRegressor)
  - [RadiusNeighborsRegressor](http://scikit-learn.org/stable/modules/generated/sklearn.neighbors.RadiusNeighborsRegressor.html#sklearn.neighbors.RadiusNeighborsRegressor)
  - [DecisionTreeRegressor](http://scikit-learn.org/stable/modules/generated/sklearn.tree.DecisionTreeRegressor.html#sklearn.tree.DecisionTreeRegressor)
  - [BaggingRegressor](http://scikit-learn.org/stable/modules/generated/sklearn.ensemble.BaggingRegressor.html#sklearn.ensemble.BaggingRegressor)
  - [RandomForestRegressor](http://scikit-learn.org/stable/modules/generated/sklearn.ensemble.RandomForestRegressor.html#sklearn.ensemble.RandomForestRegressor)
  - [ExtraTreesRegressor](http://scikit-learn.org/stable/modules/generated/sklearn.ensemble.ExtraTreesRegressor.html#sklearn.ensemble.ExtraTreesRegressor)
  - [AdaBoostRegressor](http://scikit-learn.org/stable/modules/generated/sklearn.ensemble.AdaBoostRegressor.html#sklearn.ensemble.AdaBoostRegressor)
  - [MultiOutputRegressor](http://scikit-learn.org/stable/modules/generated/sklearn.multioutput.MultiOutputRegressor.html)
  - [MLPRegressor](http://scikit-learn.org/stable/modules/generated/sklearn.neural_network.MLPRegressor.html#sklearn.neural_network.MLPRegressor)
  
- Unsupervised
  - [OneClassSVM](http://scikit-learn.org/stable/modules/generated/sklearn.svm.OneClassSVM.html#sklearn.svm.OneClassSVM)
  - [NearestNeighbors](http://scikit-learn.org/stable/modules/generated/sklearn.neighbors.NearestNeighbors.html#sklearn.neighbors.NearestNeighbors)
  - [LSHForest](http://scikit-learn.org/stable/modules/generated/sklearn.neighbors.LSHForest.html#sklearn.neighbors.LSHForest)
  - [RandomTreesEmbedding](http://scikit-learn.org/stable/modules/generated/sklearn.ensemble.RandomTreesEmbedding.html#sklearn.ensemble.RandomTreesEmbedding)
  
- Clustering
  - [KMeans](http://scikit-learn.org/stable/modules/generated/sklearn.cluster.KMeans.html#sklearn.cluster.KMeans)
  - [MiniBatchKMeans](http://scikit-learn.org/stable/modules/generated/sklearn.cluster.MiniBatchKMeans.html#sklearn.cluster.MiniBatchKMeans)
  - [SpectralClustering](http://scikit-learn.org/stable/modules/generated/sklearn.cluster.SpectralClustering.html#sklearn.cluster.SpectralClustering)
  - [DBSCAN](http://scikit-learn.org/stable/modules/generated/sklearn.cluster.DBSCAN.html#sklearn.cluster.DBSCAN)
  - [Birch](http://scikit-learn.org/stable/modules/generated/sklearn.cluster.Birch.html#sklearn.cluster.Birch)
  
- Decomposition
  - [TruncatedSVD](http://scikit-learn.org/stable/modules/generated/sklearn.decomposition.TruncatedSVD.html#sklearn.decomposition.TruncatedSVD)
  - [NonnegativeMatrixFactorization](http://scikit-learn.org/stable/modules/generated/sklearn.decomposition.NMF.html#sklearn.decomposition.NMF)
  - [LatentDirichletAllocation](http://scikit-learn.org/stable/modules/generated/sklearn.decomposition.LatentDirichletAllocation.html#sklearn.decomposition.LatentDirichletAllocation)
  
- Feature Selection
    - [VarianceThreshold](http://scikit-learn.org/stable/modules/generated/sklearn.feature_selection.VarianceThreshold.html#sklearn.feature_selection.VarianceThreshold)
    - [RecursiveFeatureElimination](http://scikit-learn.org/stable/modules/generated/sklearn.feature_selection.RFE.html#sklearn.feature_selection.RFE)
  

# Examples
Several intersting topics will be covered in this section. First, I am going to introduce you to a great tool called [spy()](https://matplotlib.org/api/_as_gen/matplotlib.axes.Axes.spy.html). It is available in the matplotlib library and it allows us to visually inspect a matrix for sparsity. Next, I will show you how to apply Scipy's Compressed Sparse Row [(CSR)](https://docs.scipy.org/doc/scipy/reference/generated/scipy.sparse.csc_matrix.html#scipy.sparse.csc_matrix) algorithm to obtain a sparse matrix. Next, I will show how this method allows us to compress our example data by 85%. And finally, I will run a Bernoulli Naive Bayes classifier on two versions of the same example data, dense and sparse, to show how sparsity leads to markedly decreased computation times. 

### Setup
I generated a sparse 2,000 by 10,000 dataset matrix composed of zeros and ones. 
```
import numpy as np
np.random.seed(seed=12)  ## for reproducibility
dataset = np.random.binomial(1, 0.1, 20000000).reshape(2000,10000)  ## dummy features
y = np.random.binomial(1, 0.5, 2000)  ## dummy target variable
```

### Spy()
I mentioned matplotlib's *spy()* method which allows us to visualize the sparsity of a dataset. The %matplotlib is for Jupyter notebook users. Feel free to omit otherwise.
```
%matplotlib inline
import matplotlib.pyplot as plt
plt.spy(dataset)
plt.title("Sparse Matrix");
```
![Spy Sparse](/assets/images/sparse_matrix_spy_sparse.png?raw=true)

Notice that the graph is mostly white. For comparison purposes, here's a dense matrix.
```
np.random.seed(seed=43)
plt.figure(figsize=(14,12))
plt.spy(np.random.binomial(1, 0.9, 20000000).reshape(2000,10000))
plt.title("Dense Matrix");
```
![Spy Dense](/assets/images/sparse_matrix_spy_dense.png?raw=true)

### Scipy CSR
We have a dense matrix called *dataset*. We already know is very sparse. Let's go ahead and transform it into a sparse matrix with Scipy's CSR.
```
from scipy.sparse import csr_matrix
sparse_dataset = csr_matrix(dataset)
```

### Compression
![Compression](/assets/images/sparse_matrix_compression.png?raw=true)  
From the graph above we can see that the dense matrix is 160 MB while the sparse matrix is 24 MB. That's 85% compression! Granted we started with a pretty sparse matrix.

### Computation Time
![Computation](/assets/images/sparse_matrix_compute_time.png?raw=true)  
Since I made this a classification problem and since NLP problems often result in sparse matrices, I used the Bernoulli Naive Bayes classifier. It is known for speed. As you can see, converting to a sparse matrix lead to an 8-fold decrease in computation time! This makes sense because computing all those nonsensical zero multiplications has been eliminated. Hooray! 

By the way, this works with plenty of other algorithms, too. For example, I ran vanilla logistic regression and cut processing time in half. Where do we not see improved processing times? Decision tree-based algorithms like random forest. 

If you're interested in how CSR works, keep reading. Otherwise, go forth and experiment.


# How CSR Works

# Additional Resources
[Working with Sparse Matrices](http://www.mathcs.emory.edu/~cheung/Courses/561/Syllabus/3-C/sparse.html)  
[Sparse Matrix Representations & Iterative Solvers](http://www.bu.edu/pasi/files/2011/01/NathanBell1-10-1000.pdf)  
[Scikit-learn Documentation](http://scikit-learn.org/stable/index.html)  
[Scipy Sparse Matrices](https://docs.scipy.org/doc/scipy/reference/sparse.html)
