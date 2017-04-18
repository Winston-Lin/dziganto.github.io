---
permalink: /posts/
---

![Image of Binary](/assets/images/binary-number-tunnel.jpg?raw=true)

# Introduction
Sparse matrices are common in machine learning. While they occur naturally in some data collection processes, more often they arise when applying certain data transformation techniques like:

- [One-hot encoding](http://scikit-learn.org/stable/modules/generated/sklearn.preprocessing.OneHotEncoder.html) categorical variables
- [CountVectorizer](http://scikit-learn.org/stable/modules/generated/sklearn.feature_extraction.text.CountVectorizer.html) for NLP
- [TfidfVectorizer](http://scikit-learn.org/stable/modules/generated/sklearn.feature_extraction.text.TfidfVectorizer.html) for NLP

Let's step back for a second. Just what the heck is a sparse matrix and how is it different than other matrices? Turns out there are two major types of matrices: dense and sparse. Sparse matrices have lots of zero values. Dense matrices do not. 

Here is an example of a sparse matrix:

![Sparse Matrix](/assets/images/sparse_matrix.png?raw=true){: .center-image }

Because sparse matrices have lots of zero values, we can apply special algorithms that will do two important things:

1. **compress the memory footprint of our matrix object**  
2. **speed up many machine learning routines**

Since storing all those zero values is a waste, we can apply data compression techniques to minimize the amount of data we need to store. That is not the only benefit, however. Users of [sklearn](http://scikit-learn.org/stable/index.html) will note that all native machine learning algorithms require data matrices to be in-memory. Said another way, the machine learning process breaks down when a data matrix (usually called a dataframe) does not fit into RAM. One of the perks of converting a dense data matrix to sparse is that in many cases it is possible to compress it so that it can fit in RAM.

Additionally, consider multiplying a sparse matrix by a dense matrix. Even though the sparse matrix has many zeros, and zero times anything is always zero, the standard approach requires this pointless operation nonetheless. The result is slowed processing time. It is much more efficient to operate only on elements that will return non-zero values. Therefore, any algorithm that applies some basic mathematical computation like multiplication will benefit from a sparse matrix implementation.

Sklearn has many algorithms that accept sparse matrices. The way to know is by checking the *fit* attribute in the documentation. Look for this: **X: {array-like, sparse matrix}**. 

At the time of this writing, the following sklearn 0.18.1 algorithms accept sparse matrices:

### Classification
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
  
### Regression
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
 
### Clustering
- [KMeans](http://scikit-learn.org/stable/modules/generated/sklearn.cluster.KMeans.html#sklearn.cluster.KMeans)
- [MiniBatchKMeans](http://scikit-learn.org/stable/modules/generated/sklearn.cluster.MiniBatchKMeans.html#sklearn.cluster.MiniBatchKMeans)
- [SpectralClustering](http://scikit-learn.org/stable/modules/generated/sklearn.cluster.SpectralClustering.html#sklearn.cluster.SpectralClustering)
- [DBSCAN](http://scikit-learn.org/stable/modules/generated/sklearn.cluster.DBSCAN.html#sklearn.cluster.DBSCAN)
- [Birch](http://scikit-learn.org/stable/modules/generated/sklearn.cluster.Birch.html#sklearn.cluster.Birch)
  
### Decomposition
- [TruncatedSVD](http://scikit-learn.org/stable/modules/generated/sklearn.decomposition.TruncatedSVD.html#sklearn.decomposition.TruncatedSVD)
- [NonnegativeMatrixFactorization](http://scikit-learn.org/stable/modules/generated/sklearn.decomposition.NMF.html#sklearn.decomposition.NMF)
- [LatentDirichletAllocation](http://scikit-learn.org/stable/modules/generated/sklearn.decomposition.LatentDirichletAllocation.html#sklearn.decomposition.LatentDirichletAllocation)
  
### Feature Selection
- [VarianceThreshold](http://scikit-learn.org/stable/modules/generated/sklearn.feature_selection.VarianceThreshold.html#sklearn.feature_selection.VarianceThreshold)
- [RecursiveFeatureElimination](http://scikit-learn.org/stable/modules/generated/sklearn.feature_selection.RFE.html#sklearn.feature_selection.RFE)

### Other
- [OneClassSVM](http://scikit-learn.org/stable/modules/generated/sklearn.svm.OneClassSVM.html#sklearn.svm.OneClassSVM)
- [NearestNeighbors](http://scikit-learn.org/stable/modules/generated/sklearn.neighbors.NearestNeighbors.html#sklearn.neighbors.NearestNeighbors)
- [LSHForest](http://scikit-learn.org/stable/modules/generated/sklearn.neighbors.LSHForest.html#sklearn.neighbors.LSHForest)
- [RandomTreesEmbedding](http://scikit-learn.org/stable/modules/generated/sklearn.ensemble.RandomTreesEmbedding.html#sklearn.ensemble.RandomTreesEmbedding)
  
# Examples
I will cover several intersting topics in this section. First, there is a great tool called [spy()](https://matplotlib.org/api/_as_gen/matplotlib.axes.Axes.spy.html). It is available in the Matplotlib library and it allows us to visually inspect a matrix for sparsity. Next, Scipy has the Compressed Sparse Row [(CSR)](https://docs.scipy.org/doc/scipy/reference/generated/scipy.sparse.csc_matrix.html#scipy.sparse.csc_matrix) algorithm which converts a dense matrix to a sparse matrix, allowing us to significantly compress our example data. And finally, I will run three classification algorithms on both dense and sparse versions of the same data to show how sparsity leads to markedly faster computation times. 

### Setup
I generated a sparse 2,000 by 10,000 dataset matrix composed of zeros and ones. 
```
import numpy as np
np.random.seed(seed=12)  ## for reproducibility
dataset = np.random.binomial(1, 0.1, 20000000).reshape(2000,10000)  ## dummy data
y = np.random.binomial(1, 0.5, 2000)  ## dummy target variable
```

### Spy()
I mentioned Matplotlib's *spy()* method which allows us to visualize the sparsity of a dataset. [Note: the *%matplotlib* is for Jupyter notebook users. Feel free to omit it otherwise.]
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
We have a data matrix called *dataset*. We already know it is very sparse so let's go ahead and transform it with Scipy's CSR. 
```
from scipy.sparse import csr_matrix
sparse_dataset = csr_matrix(dataset)
```

### Compression
```
import seaborn as sns

dense_size = np.array(dataset).nbytes/1e6
sparse_size = (sparse_dataset.data.nbytes + sparse_dataset.indptr.nbytes + sparse_dataset.indices.nbytes)/1e6

sns.barplot(['DENSE', 'SPARSE'], [dense_size, sparse_size])
plt.ylabel('MB')
plt.title('Compression')
```
![Compression](/assets/images/sparse_matrix_compression.png?raw=true){: .center-image }

From the graph above we can see that the dense matrix is 160 MB while the sparse matrix is 24 MB. That's 85% compression! Granted we started with a pretty sparse matrix.

### Computation Time
I ran three different classification algorithms - Naive Bayes, Logistic Regression, Support Vector Machines - and checked processing times for each.  

```
from sklearn.naive_bayes import BernoulliNB
nb = BernoulliNB(binarize=None)
%timeit nb.fit(dataset, y)
%timeit nb.fit(sparse_dataset, y)
```
![Compute Time](/assets/images/sparse_matrix_compute_time_nb.png?raw=true){: .center-image }  

As you can see, the Naive Bayes classifier ran 8 times faster when operating on the sparse matrix!

```
from sklearn.linear_model import LogisticRegression
lr = LogisticRegression(random_state=99)
%timeit lr.fit(dataset, y)
%timeit lr.fit(sparse_dataset, y)
```

![Compute Time](/assets/images/sparse_matrix_compute_time_logistic.png?raw=true){: .center-image }  
 
For logistic regression, we see roughly a 33% decrease in processing time. Not quite as performant as Naive Bayes but a big difference nonetheless.

```
from sklearn.svm import LinearSVC
svc = LinearSVC()
%timeit svc.fit(dataset, y)
%timeit svc.fit(sparse_dataset, y)
```
 
![Compute Time](/assets/images/sparse_matrix_compute_time_svm.png?raw=true){: .center-image }  
 
And finally, we have SVM. With sparse matrices we were able to achieve roughly a 50% reduction in processing time!

All in all, converting sparse matrices to the sparse matrix format almost always yields some efficiency in processing time. We saw this to be the case for Naive Bayes, Logistic Regression, and Support Vector Machines. Where do we not see improved processing times? Unfortunately for decision tree-based algorithms like random forest.

# How CSR Works
![CSR](/assets/images/CSR.png?raw=true)
*Image Credit: Nathan Bell's Sparse Matrix Representations & Iterative Solvers.*

CSR requires three arrays. The first array stores the cumulutive count of non-zero values in all current and previous rows. The second array stores column index values for each non-zero value. And the third array stores all non-zero values. I realize that may be confusing, so let's walk through an example.   

Refer to the diagram above. The first step is to populate the first array. It always starts with 0. Since there are two non-zero values in row 1, we update our array like so [0 2]. There are 2 non-zero values in row 2, so we update our array to [0 2 4]. Doing that for the remaining rows yields [0 2 4 7 9]. By the way, the length of this array should always be the number of rows + 1. Step two is populating the second array of column indices. Note that the columns are zero-indexed. The first value, 1, is in column 0. The second value, 7, is in column 1. The third value, 2, is in column 1. And so on. The result is the array [0 1 1 2 0 2 3 1 3]. Finally, we populate the third array which looks like this [1 7 2 8 5 3 9 6 4]. Again, we are only storing non-zero values.   

Believe it or not, these three arrays allow us to perfectly reconstruct the original matrix. From here, common mathematical operations like addition or multiplication can be applied in an efficient manner, the details of which are beyond the scope of this post. Suffice it to say there are many wonderful resources online if you are interested.

# Summary
A matrix composed of many zeros is known as a sparse matrix. Sparse matrices have nice properties. How do you know if you have a sparse matrix? Use Matplotlib's *spy()* method. Once you know your matrix is sparse, use Scipy's CSR to convert its type from dense to sparse, check data compression, and apply any of the machine learning algorithms listed above. 

In closing, I want you to leave you with this: what if the original data matrix won't fit into memory in the first place? Can you think of a way to convert it to a sparse matrix anyway? 

**Stay tuned because I'll answer that and many other questions in coming posts.**

# Additional Resources
[Working with Sparse Matrices](http://www.mathcs.emory.edu/~cheung/Courses/561/Syllabus/3-C/sparse.html)  
[Sparse Matrix Representations & Iterative Solvers](http://www.bu.edu/pasi/files/2011/01/NathanBell1-10-1000.pdf)  
[Scikit-learn Documentation](http://scikit-learn.org/stable/index.html)  
[Scipy Sparse Matrices](https://docs.scipy.org/doc/scipy/reference/sparse.html)
[My Jupyter Notebook]()
