---
published: false
title: Locally Installing GraphFrames in PySpark
categories: [Apache Spark, PySpark, GraphFrames]
---

**Disclaimer:** [Tiffany Moeller](https://www.linkedin.com/in/tiffanymoeller1/) and [Joe Hamilton](https://www.linkedin.com/in/joseph-r-hamilton/) get all the credit for doing the leg work for this tutorial. Check them out!

**Objective:** a no frills tutorial to get you up and running with GraphFrames in PySpark (locally) in a just a few minutes.

**Prerequisites:**
1. You're using a Mac.
2. You've installed [brew](https://brew.sh/).
3. You've installed *apache-spark* with brew.
4. You've installed *wget* with brew.
5. You have basic familiarity with the command line.
6. You will type all following commands from your home directory. 

**Steps:**
1. Open a Terminal window.
2. Type ```wget http://dl.bintray.com/spark-packages/maven/graphframes/graphframes/0.5.0-spark2.1-s_2.11/graphframes-0.5.0-spark2.1-s_2.11.jar``` (see [graphframes](https://spark-packages.org/package/graphframes/graphframes) for latest version)
3. Type ```jar xf graphframes-0.5.0-spark2.1-s_2.11.jar```
4. Type ```cd /usr/local/Cellar/apache-zeppelin/0.7.3/libexec/interpreter/lib/python/```
5. Type ```cp -r ~/graphframes .```
6. Launch PySpark by typing ```pyspark```.
7. Once PySpark launches, type ```import graphframes```.
8. Then type ```graphframes.GraphFrame```.
9. If you see **<class 'graphframes.graphframe.GraphFrame'>**, then you're all set!
